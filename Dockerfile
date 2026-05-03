FROM alpine:latest
RUN apk add --no-cache bash wget unzip
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD /entrypoint.sh
