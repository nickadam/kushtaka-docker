FROM golang:1 AS build

RUN wget -q https://github.com/kushtaka/kushtakad/releases/download/v0.2.14/kushtakad_0.2.14_linux_amd64.gz && \
  gunzip kushtakad_0.2.14_linux_amd64.gz && \
  mv kushtakad_0.2.14_linux_amd64 /kushtakad && \
  chmod +x /kushtakad

FROM debian:buster

RUN useradd -ms /bin/bash kushtaka && \
  mkdir /data && \
  chown kushtaka:kushtaka /data

USER kushtaka

COPY --from=build /kushtakad /usr/local/bin

EXPOSE 8080

VOLUME ["/data"]

CMD ["kushtakad", "-server"]
