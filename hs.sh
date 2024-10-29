#!/bin/bash

# Проверяем, был ли передан аргумент (имя пользователя)
if [ -z "$1" ]; then
  echo "Использование: $0 USERNAME"
  exit 1
fi

USERNAME=$1
BASE_DIR="$HOME/users/$USERNAME"

# Создаем основную директорию и инициализируем git репозиторий
mkdir -p "$BASE_DIR"
cd "$BASE_DIR" || exit
git init

# Функция для создания папок и файлов
create_structure() {
  local folder_name=$1
  local file_extension=$2

  # Создаем основную папку
  mkdir -p "$folder_name"
  
  # Создаем папки и файлы 2020-2024
  for year in {2020..2024}; do
    mkdir -p "$folder_name/$year"
    touch "$folder_name/$year/default.$file_extension"
  done

  # Добавляем изменения и коммитим
  git add .
  git commit -m "Добавлены папки и файлы для $folder_name"
}

# Создаем структуры для photos, videos и documents
create_structure "photos" "png"
create_structure "videos" "mp4"
create_structure "documents" "txt"

echo "Структура пользователя $USERNAME успешно создана."
