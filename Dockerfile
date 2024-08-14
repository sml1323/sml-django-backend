# alpine 3.19 버전의 리눅스를 구축하는데, 파이썬 버전은 3.11로 설치된 이미지를 불러와줘
# alpine - 경량화된 리눅스 버전 -> 가볍다 -> ??
# => 빌드가 계속 반복이 되는데, 이미지 자체가 무거우면 빌드 속도가 느려진다.
# ex) miniconda
FROM python:3.11-alpine3.19

LABEL maintainer='seopftware'


# python0:1 = False:True
# 컨테이너가 찍히는 로그를 볼 수 있도록 허용한다.
# 도커 컨테이너에서 어떤 일이 벌어지고 있는지 알아야 디버깅이 가능
# 실시간으로 볼 수 있기 때문에 컨테이너 관리가 편해진다.
ENV PYTHONUNBUFFERED 1

# tmp에 넣는 이유: 컨테이너를 최대한 경량상태로 유지하기 위해
# tmp 폴더는 나중에 빌드가 완료되면 삭제한다.
COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app

WORKDIR /app
EXPOSE 8000

ARG DEV=false

# && /: Enter
RUN python -m venv /py && \ 
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"

USER django-user

