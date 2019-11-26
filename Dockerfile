FROM golang:1 AS build

WORKDIR /root

RUN git clone https://github.com/kushtaka/kushtakad && \
  cd kushtakad && \
  ./build.sh

FROM debian:buster

COPY --from=build /root/kushtakad/kushtakad /usr/local/bin

EXPOSE 8080

VOLUME ["/data"]

CMD ["kushtakad"]
