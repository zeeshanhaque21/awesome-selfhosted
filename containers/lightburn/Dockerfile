FROM lscr.io/linuxserver/webtop:ubuntu-xfce

# Install dependencies for LightBurn (if any are missing)
RUN apt-get update && \
    apt-get install -y wget git zsh neovim htop libusb-1.0-0 libpulse0 libxcb-icccm4 libxcb-image0 libxcb-keysyms1 libxcb-render-util0 libxcb-xinerama0 libxcb-xfixes0 && \
    rm -rf /var/lib/apt/lists/*

# Download and install LightBurn
RUN wget https://release.lightburnsoftware.com/LightBurn/Release/LightBurn-v1.7.08/LightBurn-Linux64-v1.7.08.run -O LightBurn.run && \
    chmod +x LightBurn.run && \
    ./LightBurn.run \
    && rm LightBurn.run

RUN sed -i 's|^Exec=.*|Exec=env BOX64_ALLOWMISSINGLIBS=1 box64 /usr/share/LightBurn/LightBurn|' /usr/share/applications/lightburn.desktop


# Create a script that will be run at container startup to add user to dialout
RUN echo '#!/bin/bash\n\
if id -u abc >/dev/null 2>&1; then\n\
    usermod -aG dialout abc 2>/dev/null || true\n\
fi\n\
exec "$@"' > /usr/local/bin/add-dialout.sh && \
    chmod +x /usr/local/bin/add-dialout.sh

ADD box64.tar.gz /

EXPOSE 3000 3001

# Override entrypoint to add user to dialout first
ENTRYPOINT ["/usr/local/bin/add-dialout.sh", "/init"]
