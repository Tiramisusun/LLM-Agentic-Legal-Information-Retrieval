#!/usr/bin/env bash
set -euo pipefail

# Install Kaggle CLI
if ! command -v kaggle &>/dev/null; then
    echo "Installing kaggle CLI..."
    pip install --quiet kaggle
fi

# Credentials: place your kaggle.json at ~/.kaggle/kaggle.json (chmod 600)
# Download from https://www.kaggle.com/settings → API → Create New Token
if [[ ! -f "$HOME/.kaggle/kaggle.json" ]]; then
    echo "ERROR: ~/.kaggle/kaggle.json not found."
    echo "Go to https://www.kaggle.com/settings → API → Create New Token, then:"
    echo "  mkdir -p ~/.kaggle && mv ~/Downloads/kaggle.json ~/.kaggle/ && chmod 600 ~/.kaggle/kaggle.json"
    exit 1
fi

mkdir -p data

kaggle competitions download \
    -c llm-agentic-legal-information-retrieval \
    -p data/

unzip -o data/llm-agentic-legal-information-retrieval.zip -d data/

echo "Done. Files in data/:"
ls data/
