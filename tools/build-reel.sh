#!/usr/bin/env bash
# Arma assets/reel-*.mp4: picado de los fragmentos de TRUCCO (../site/assets/media)
# con planos del reel de federicocarlini.com (../REEL/src/fc-reel-1080.mp4). Sin audio, en loop.
set -euo pipefail
cd "$(dirname "$0")/.."
M=../site/assets/media
FC=../REEL/src/fc-reel-1080.mp4
TMP=$(mktemp -d); command -v cygpath >/dev/null && TMP=$(cygpath -m "$TMP")  # ffmpeg de Windows
VF="fps=24,scale=1920:1080:force_original_aspect_ratio=increase,crop=1920:1080,setsar=1,format=yuv420p"
n=0
cut() { # archivo inicio duración
  n=$((n+1)); ffmpeg -v error -y -ss "$2" -t "$3" -i "$1" -an -vf "$VF" -c:v libx264 -crf 16 -preset fast "$TMP/$(printf %02d $n).mp4"
  echo "file '$TMP/$(printf %02d $n).mp4'" >> "$TMP/list.txt"
}
frag() { # proyecto número: 1.6 s del medio del fragmento
  local f="$M/$1/frag-$2.mp4" d; d=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$f")
  cut "$f" "$(awk "BEGIN{print ($d-1.6)/2}")" 1.6
}
frag paraiso 1; cut $FC 1.35 0.65; cut $FC 3.6 1
frag wine 1;    cut $FC 10 1
frag paraiso 4; cut $FC 14.25 0.7
frag wine 2;    cut $FC 16.65 0.85; cut $FC 20 0.9
frag paraiso 5; cut $FC 21.4 0.7
frag wine 3;    cut $FC 24.5 1
frag paraiso 8; cut $FC 26.65 0.85; cut $FC 27.55 0.65
frag wine 6;    cut $FC 28.3 1
frag paraiso 2; cut $FC 30 0.85
frag paraiso 6; cut $FC 38 1.1
ffmpeg -v error -y -f concat -safe 0 -i "$TMP/list.txt" -c copy "$TMP/reel.mp4"
ffmpeg -v error -y -i "$TMP/reel.mp4" -c:v libx264 -crf 27 -preset slow -movflags +faststart assets/reel-1080.mp4
ffmpeg -v error -y -i "$TMP/reel.mp4" -vf scale=1280:-2 -c:v libx264 -crf 27 -preset slow -movflags +faststart assets/reel-720.mp4
ffmpeg -v error -y -ss 0.8 -i "$TMP/reel.mp4" -frames:v 1 -vf scale=1280:-2 -q:v 4 assets/reel-poster.jpg
rm -rf "$TMP"
ls -la assets/reel-*
