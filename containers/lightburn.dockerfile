FROM lscr.io/linuxserver/webtop:ubuntu-xfce

# Install dependencies for LightBurn (if any are missing)
RUN apt-get update && \
    apt-get install -y wget libpulse0 libxcb-icccm4 libxcb-image0 libxcb-keysyms1 libxcb-render-util0 libxcb-xinerama0 libxcb-xfixes0 && \
    rm -rf /var/lib/apt/lists/*

# Download and install LightBurn
RUN wget https://release.lightburnsoftware.com/LightBurn/Release/LightBurn-v1.7.08/LightBurn-Linux64-v1.7.08.run -O LightBurn.run && \
    chmod +x LightBurn.run && \
    ./LightBurn.run \
    && rm LightBurn.run

EXPOSE 3000 3001

# The rest is handled by the base image's entrypoint