USER root
RUN apt-get update && apt-get install -y software-properties-common --no-install-recommends \
            && apt-get install -y chromium-browser chromium-browser-l10n chromium-codecs-ffmpeg \
            && ln -s /usr/bin/chromium-browser /usr/bin/google-chrome \
            && apt-get clean \
            && rm -rf /var/lib/apt/lists/*

RUN wget -q https://chromedriver.storage.googleapis.com/85.0.4183.87/chromedriver_linux64.zip && \
	unzip chromedriver_linux64.zip && \
	rm chromedriver_linux64.zip && \
	chmod a+x chromedriver && \
	mv chromedriver /usr/bin/ && \
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - && \
	echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list

RUN sudo apt-get update  && \
	sudo apt-get -y install google-chrome-stable && \
	sudo apt-get clean

RUN pip install --no-cache-dir 'selenium==3.141.0'

USER $NB_USER
