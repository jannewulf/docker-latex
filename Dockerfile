FROM ubuntu:latest

COPY texlive-full.profile /tmp/texlive.profile

RUN apt update \
    && apt upgrade -y \
    && apt install -y wget tar perl

RUN mkdir -p /tmp/latex_download \
    && cd /tmp/latex_download \
    && wget -q http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz \
    && tar -xf install-tl-unx.tar.gz \
    && cd $(tar -tf install-tl-unx.tar.gz | head -n 1) \
    && perl install-tl -profile /tmp/texlive.profile

ENV PATH="/usr/local/texlive/2019/bin/x86_64-linux:${PATH}"

RUN mkdir -p /var/latex_source
WORKDIR /var/latex_source

