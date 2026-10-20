#!/usr/bin/env bash
# Builds the gzipped site ConfigMap from site/ and deploys medscribe-saas to Kubernetes via ubuntu03.
set -euo pipefail
cd "$(dirname "$0")/.."

HOST="${HOST:-ubuntu03}"

{
  cat deploy/k8s.yaml
  echo "---"
  python3 - <<'PY'
import base64, gzip, json, pathlib
files = sorted(pathlib.Path("site").glob("*.html"))
body = {f.name + ".gz": base64.b64encode(gzip.compress(f.read_bytes(), compresslevel=9)).decode() for f in files}
print(json.dumps({
    "apiVersion": "v1",
    "kind": "ConfigMap",
    "metadata": {"name": "site-gz", "namespace": "medscribe-saas"},
    "binaryData": body
}, ensure_ascii=False))
PY
} | ssh "$HOST" 'kubectl apply --server-side --force-conflicts -f - && kubectl -n medscribe-saas rollout restart deploy/web && kubectl -n medscribe-saas rollout status deploy/web --timeout=120s && kubectl -n medscribe-saas get pods,svc -o wide'
