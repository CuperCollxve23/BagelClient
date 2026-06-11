#!/usr/bin/env bash

# Run this from the BagelClient workspace root.
# If port 8000 is busy, it will try 8001, 8002, 8003, and 8004.
# Then open the URL it prints in your browser.

cd "$(dirname "$0")"
python3 - <<'PY'
import http.server
import socketserver
import socket

PORTS = [8000, 8001, 8002, 8003, 8004]
for port in PORTS:
    try:
        with socketserver.TCPServer(("", port), http.server.SimpleHTTPRequestHandler) as httpd:
            print(f"Serving BagelClient at http://127.0.0.1:{port}")
            httpd.serve_forever()
    except OSError as e:
        if e.errno == 98:
            continue
        raise
print("All ports busy. Close programs using 8000-8004 and try again.")
PY
