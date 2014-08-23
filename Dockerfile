FROM ubuntu:trusty

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update
RUN apt-get -y install wget build-essential git
RUN mkdir /tmp/erlang-build
WORKDIR /tmp/erlang-build
RUN wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
RUN dpkg -i erlang-solutions_1.0_all.deb
RUN apt-get -y update
RUN apt-get -y install erlang

RUN git clone git://github.com/rebar/rebar.git
WORKDIR /tmp/erlang-build/rebar
RUN ./bootstrap
RUN cp rebar /usr/local/bin/

WORKDIR /tmp/erlang-build/
RUN git clone https://github.com/elixir-lang/elixir.git
WORKDIR /tmp/erlang-build/elixir
RUN git checkout v0.15.0
RUN make install

WORKDIR /
RUN rm -rf /tmp/erlang-build
RUN apt-get clean
