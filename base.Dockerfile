FROM ubuntu:20.04
LABEL maintainer="Niklas Hauser <niklas.hauser@rwth-aachen.de>, Raphael Lehmann <raphael+docker@rleh.de"
LABEL description="Image for building and debugging modm"
LABEL org.opencontainers.image.source https://github.com/modm-ext/docker-modm-build

WORKDIR /work

ADD requirements3.txt /work

ENV LANG="en_US.UTF-8"
ENV SCONSFLAGS="-j4"
ENV MAKEFLAGS="-j4"

ENV TZ=Europe/Berlin
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq && \
    apt-get upgrade -y -qq && \
    apt-get install -y -qq \
      build-essential \
      gcc-10 g++-10 \
      git \
      bzip2 \
      wget \
      python3 \
      python3-dev \
      python3-pip \
      python-is-python3 \
      libboost-all-dev \
      libsdl1.2-dev \
      libsdl-image1.2-dev \
      libgtkmm-2.4-dev \
      libmpc-dev \
      libmpfr-dev \
      libgmp-dev \
      cmake \
      locales \
      texlive-latex-base \
      texlive-fonts-recommended \
      doxygen \
      graphviz \
      curl && \
    apt-get clean -qq
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 90 --slave /usr/bin/g++ g++ /usr/bin/g++-10 --slave /usr/bin/gcov gcov /usr/bin/gcov-10
RUN locale-gen en_US.UTF-8
RUN pip3 install -r requirements3.txt && rm requirements3.txt
RUN mkdir /opt/doxypress && \
    wget -qO- https://download.copperspice.com/doxypress/binary/doxypress-1.4.1-ubuntu20.04-x64.tar.bz2 | tar xj -C /opt/doxypress

ENV PATH "/opt/doxypress:$PATH"
