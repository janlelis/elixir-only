# sio-elixir

# # #
# Base Dockerfile for Elixir applications
# # #

FROM ubuntu:trusty
ENV DEBIAN_FRONTEND noninteractive

# Ensure Locale
RUN apt-get -y update
RUN dpkg-reconfigure locales && \
     locale-gen en_US.UTF-8 && \
     /usr/sbin/update-locale LANG=en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Packages
RUN apt-get -y update
RUN apt-get -y install wget build-essential git

# Install Erlang
RUN mkdir /tmp/erlang-build
WORKDIR /tmp/erlang-build
RUN wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
RUN dpkg -i erlang-solutions_1.0_all.deb
RUN apt-get -y update
RUN apt-get -y install erlang

# Install Erlang Build Tool
RUN git clone git://github.com/rebar/rebar.git
WORKDIR /tmp/erlang-build/rebar
RUN ./bootstrap
RUN cp rebar /usr/local/bin/

# Build Elixir
WORKDIR /tmp/erlang-build/
RUN git clone https://github.com/elixir-lang/elixir.git
WORKDIR /tmp/erlang-build/elixir
RUN git checkout v0.15.0
RUN make install

# Clean Up
WORKDIR /
RUN rm -rf /tmp/erlang-build
RUN apt-get clean
