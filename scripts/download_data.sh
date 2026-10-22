#!/usr/bin/env bash
# Download the KION dataset (English metadata) into data/raw/data_en/.
# Source: https://github.com/irsafilo/KION_DATASET
set -euo pipefail

URL="https://github.com/irsafilo/KION_DATASET/raw/main/data_en.zip"

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
RAW_DIR="$ROOT_DIR/data/raw"
ZIP_PATH="$RAW_DIR/data_en.zip"
OUT_DIR="$RAW_DIR/data_en"

if [[ -f "$OUT_DIR/interactions.csv" && -f "$OUT_DIR/users_en.csv" && -f "$OUT_DIR/items_en.csv" ]]; then
    echo "Dataset already present in $OUT_DIR, skipping."
    exit 0
fi

mkdir -p "$RAW_DIR"

echo "Downloading $URL ..."
curl -fL --retry 3 -o "$ZIP_PATH" "$URL"

echo "Extracting to $RAW_DIR ..."
unzip -q -o "$ZIP_PATH" -x '__MACOSX/*' -d "$RAW_DIR"
rm "$ZIP_PATH"

echo "Done:"
ls -lh "$OUT_DIR"
