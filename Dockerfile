FROM alpine:3
MAINTAINER sylvain@sleede.com

WORKDIR /workdir

RUN apk update && apk upgrade && \
    apk add bash less git bat && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

RUN set -eux; \
    addgroup -g 1000 bat; \
    adduser -u 1000 -G bat -s /bin/sh -h /home/bat -D bat

RUN chown -R bat:bat /workdir

# configure bash to check window size after each command
RUN echo "shopt -s checkwinsize" >> ~/.bashrc

USER bat

# execute `bat` after a slight pause in order to give
# the tty time to realize the current window size
ENTRYPOINT ["/bin/bash", "-c", "sleep 0.1; /usr/bin/bat $0 $@"]
