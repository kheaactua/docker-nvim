ARG UBUNTU_TAG=20.04
FROM ubuntu:${UBUNTU_TAG}

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get -q -y update                              \
    && apt-get install -q -y                          \
        build-essential                               \
        autoconf automake libtool libtool-bin         \
        curl g++ make gcc                             \
        git xsel pkg-config bison gettext             \
        python-dev python3-dev python3-pip            \
        ninja-build cmake                             \
        unzip                                         \
    && apt-get -q -y autoremove                       \
    && apt-get -q -y clean

LABEL                                                             \
  org.label-schema.description="nvim"                             \
  org.label-schema.name="kheaactua/nvim"                          \
  org.label-schema.schema-version="1.0"                           \
  org.label-schema.url="https://github.com/kheaactua/docker-nvim" \
  org.label-schema.vendor="Matthew Russell"                       \
  org.label-schema.version="0.2"

ARG INSTALL_PREFIX=/usr/local
ENV INSTALL_PREFIX=${INSTALL_PREFIX}

ARG NVIM_TAG=4a996bc
ENV NVIM_TAG=${NVIM_TAG}

WORKDIR /bin
COPY install.sh ./
RUN ["chmod", "+x", "install.sh"]
RUN ["./install.sh"]

ENTRYPOINT ["/usr/local/bin/nvim"]

# vim: ts=4 sw=4 expandtab ff=unix :
