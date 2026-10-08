#!/bin/sh
IPK_URL="https://raw.githubusercontent.com/kongon13/Shiavoice-enigma2/main/enigma2-plugin-extensions-shiavoice_0.8.52.ipk"
IPK_FILE="/tmp/enigma2-plugin-extensions-shiavoice_0.8.52.ipk"

echo 'Shiavoice_by_kongon13 0.8.52'
echo 'Downloading...'

if ! wget -q -O "$IPK_FILE" "$IPK_URL"; then
    echo 'ERROR: Download failed.'
    rm -f "$IPK_FILE"
    exit 1
fi

if [ ! -s "$IPK_FILE" ]; then
    echo 'ERROR: Downloaded file is empty.'
    rm -f "$IPK_FILE"
    exit 1
fi

echo 'Installing...'

if ! opkg install --force-reinstall "$IPK_FILE"; then
    echo 'ERROR: Installation failed.'
    rm -f "$IPK_FILE"
    exit 1
fi

rm -f "$IPK_FILE"
echo 'Installation completed.'
echo 'Restarting Enigma2...'

(sleep 3; init 4; sleep 2; init 3) >/dev/null 2>&1 &
exit 0
