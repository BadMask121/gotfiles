#!/bin/bash

# pull submodules
git submodule update --init

sudo apt-get update && apt-get install -y --no-install-recommends \
  coreutils \
  curl \
  wget \
  cron \
  gnupg2 \
  libprotobuf-dev \
  protobuf-compiler \
  unzip \
  ca-certificates \
  libssl-dev \
  pkg-config \
  libx11-dev \
  libasound2-dev \
  libudev-dev \
  vim \
  libxkbcommon-x11-0 \
  ffmpeg \
  python3 \
  python3-pip \
  && which cron \
  && rm -rf /var/lib/apt/lists/* \
  && \
  rm -rf /etc/cron.*/*


# Add Docker's official GPG key:
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
# install docker
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# setup portainer
docker compose -f ./portainer/docker-compose.yml

# setup cloudflare tunnel
docker compose -f ./cloudflare/tunnel/docker-compose.yml

# setup tinyproxy
docker compose -f ./tinyproxy/docker-compose.yml
