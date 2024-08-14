# sml-django-backend

### 도커 빌드
> docker build .
> docker-compose build

### 장고 세팅
> docker-compose run --rm app sh -c "django-admin startproject app ."

### 어드민 계정 생성
> docker-compose run --rm app sh -c "python manage.py migrate"
> docker-compose run --rm app sh -c "python manage.py createsuperuser"

### 깃 푸시

> git add . # 지금까지 작업한 전체 파일 올려줘 (로컬에)
> git commit -m "Project Settings"
> git push -u origin main