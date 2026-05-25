# LLM Agentic Legal Information Retrieval

Kaggle competition: **[LLM Agentic Legal Information Retrieval](https://www.kaggle.com/competitions/llm-agentic-legal-information-retrieval)**

## Competition Overview

Given a legal query (a question or passage from a Swiss court decision), retrieve the exact set of legal citations the court referenced. Citations come from two corpora:

- **`laws_de.csv`** — Swiss statutory law articles (e.g. `Art. 17 Abs. 2 IVG`)
- **`court_considerations.csv`** — Prior court decisions (e.g. `BGE 142 V 106 E. 3.2`)

Evaluation metric: **mean F1** across all test queries (prediction is a semicolon-separated list of citations, order does not matter).

## Approach

### Current pipeline (`tfidf-cocitation.ipynb`)

| Stage | Technique |
|---|---|
| Regex extraction | Multi-pass patterns for `Art. N [Abs. M] ABBREV`, BGE refs, case numbers |
| Abbreviation normalisation | French → German law abbrev mapping (e.g. `LAI` → `IVG`) |
| Co-citation expansion | Counter-weighted co-occurrence graph built from train/val gold labels |
| Domain keyword hints | Keyword → law-family mapping for queries with no explicit citations |
| TF-IDF transfer | Query similarity against training set; propagate gold citations by sim² weight |
| Adaptive k | Predict more citations when many regex/abbrev signals are present |

### Data files (not committed — download from Kaggle)

```
/kaggle/input/competitions/llm-agentic-legal-information-retrieval/
├── train.csv               # query_id, query, gold_citations
├── val.csv
├── test.csv
├── laws_de.csv             # citation column
└── court_considerations.csv
```

## Setup

Requires [uv](https://github.com/astral-sh/uv).

```bash
# Create virtual environment using local Python 3
uv venv .venv --python python3

# Install dependencies
uv sync

# Activate (optional — uv run works without activating)
source .venv/bin/activate
```

### Launch Jupyter

```bash
uv run jupyter lab
# or
source .venv/bin/activate && jupyter lab
```

## Notebooks

| Notebook | Description |
|---|---|
| `tfidf-cocitation.ipynb` | Baseline: TF-IDF + regex + co-citation expansion |

## Submission

The notebook writes `submission.csv` to `/kaggle/working/`. When running locally, change the output path accordingly.
