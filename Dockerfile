FROM docker:dind

RUN apk update
RUN apk upgrade
RUN apk add supervisor bash curl git icu-libs jq openjdk17 helm kubectl

ENV TARGETARCH="linux-musl-x64"
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk
ENV PATH="$JAVA_HOME/bin:${PATH}"  

COPY ./supervisord.conf /etc/supervisor/conf.d/

WORKDIR /azp/

COPY ./start.sh .

RUN chmod +x start.sh

ENV AGENT_ALLOW_RUNASROOT="true"

ENTRYPOINT ./start.sh