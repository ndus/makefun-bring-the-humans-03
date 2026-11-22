#!/bin/sh
set -eu
ffmpeg -y \
  -f lavfi -i 'color=c=0x191419:s=1080x1920:r=30:d=3.5' \
  -f lavfi -i 'color=c=0xc41c83:s=1080x1920:r=30:d=5.5' \
  -f lavfi -i 'color=c=0x191419:s=1080x1920:r=30:d=5.5' \
  -f lavfi -i 'color=c=0xc41c83:s=1080x1920:r=30:d=3' \
  -f lavfi -i 'color=c=0xc41c83:s=1080x1920:r=30:d=2.5' \
  -loop 1 -framerate 30 -i press/makefun-badge-9x16.png \
  -c:v libvpx-vp9 -i press/makefun-card-9x16-transparent.webm \
  -f lavfi -i 'anullsrc=channel_layout=stereo:sample_rate=48000' \
  -filter_complex_script press/render.ffgraph \
  -map '[vout]' -map 7:a -t 20 -r 30 -fps_mode cfr \
  -c:v libx264 -preset medium -crf 18 -pix_fmt yuv420p \
  -c:a aac -b:a 96k -ar 48000 -movflags +faststart ad.mp4
