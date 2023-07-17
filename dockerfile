# # Используйте официальный образ Golang в качестве базового
# FROM golang:latest
#
# # Установите рабочую директорию /app
# WORKDIR /app
#
# # Скопируйте содержимое текущей директории в контейнер в /app
# COPY . .
# # COPY . /app
# # COPY ./**/*.go /app/
# # COPY cmd/main.go cmd/
# # COPY initialize/redis.go initialize/
# # COPY internal/delivery/*.go delivery/
# # COPY internal/interfaces/routes.go interfaces/
# # Скачайте и установите необходимые зависимости
# RUN go mod download
#
# # Соберите приложение на Golang
FROM golang:latest AS builder
WORKDIR /server/
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app /server/cmd/main.go

FROM scratch
WORKDIR /bin/
COPY --from=builder /server/app .
ENV REDIS_ADDR redis:6379
ENV REDIS_PASSWORD ""
CMD [ "./app" ]
EXPOSE 8000


