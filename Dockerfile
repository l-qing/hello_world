# docker build . -t harbor-b.alauda.cn/devops/liuqing/hello_world:latest
# docker run --name=hello_world --rm -p 80:80 harbor-b.alauda.cn/devops/liuqing/hello_world:latest
# curl http://localhost/healthy

# docker login https://harbor-b.alauda.cn/ -u '刘庆'
# docker push  harbor-b.alauda.cn/devops/liuqing/hello_world:latest

FROM golang:alpine AS builder
WORKDIR /workdir
ENV GOOS linux
ENV GOARCH amd64
ENV CGO_ENABLED 0
COPY . .
RUN time go build -o hello_world main.go

FROM alpine
LABEL maintainer=qingliu@alauda.io
WORKDIR /workdir
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk update \
    && apk add --no-cache tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && apk del tzdata
COPY --from=builder /workdir/hello_world /workdir/
CMD  ./hello_world

