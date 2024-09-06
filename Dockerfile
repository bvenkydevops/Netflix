FROM ubuntu:latest 
RUN apt-get update && \
    apt-get install -y git curl && \
    apt-get clean

ENV NVM_DIR=/root/.nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash && \
    . "$NVM_DIR/nvm.sh" && \
    nvm install 16 && \
    nvm alias default 16 && \
    nvm use 16 && \
    ln -s "$NVM_DIR/versions/node/$(nvm version)/bin/node" /usr/local/bin/node && \
    ln -s "$NVM_DIR/versions/node/$(nvm version)/bin/npm" /usr/local/bin/npm


RUN git clone https://github.com/bvenkydevops/Netflix.git
WORKDIR /Netflix/
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build
EXPOSE 3000
CMD ["npm", "start"]
