FROM golang:1.23

WORKDIR /usr/src/app

# pre-copy/cache go.mod for pre-downloading dependencies and only redownloading them in subsequent builds if they change
COPY go.mod go.sum ./
RUN go mod download && go mod verify

COPY . .
RUN go get github.com/rexjohannes/nntp-proxy-2/config && go get golang.org/x/crypto/bcrypt
RUN go build -v -o /usr/local/bin/app .

CMD ["/usr/local/bin/app"]