# 1. ビルド環境を設定
FROM node:20-slim as builder
WORKDIR /app
COPY package*.json ./
RUN npm install

# 2. ソースコードをコピーしてビルド
COPY . .
RUN npm run build

# 3. 実行環境を設定
FROM node:20-slim
WORKDIR /app
COPY --from=builder /app/build ./build
COPY --from=builder /app/node_modules ./node_modules
COPY package*.json ./

# サーバーを起動
CMD [ "node", "build/index-http.js" ]
