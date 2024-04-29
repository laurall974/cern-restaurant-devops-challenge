FROM python:3.10

ENV DB_HOST=${DB_HOST}
ENV DB_PORT=${DB_PORT}
ENV DB_DATABASE=${DB_DATABASE}
ENV DB_USERNAME=${DB_USERNAME}
ENV DB_PASSWORD=${DB_PASSWORD}
ENV SERVER_PORT=${SERVER_PORT}

WORKDIR /app

COPY ./requirements.txt ./requirements.txt 

RUN pip install -r requirements.txt

COPY ./server/ ./server

EXPOSE ${SERVER_PORT}

CMD ["sh", "-c", "uvicorn server.main:app --host 0.0.0.0 --port ${SERVER_PORT}","--reload"]
