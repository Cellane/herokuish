FROM heroku/cedar:14
RUN curl "https://github.com/gliderlabs/herokuish/releases/download/v0.3.35/herokuish_0.3.35_linux_x86_64.tgz" \
		--silent -L | tar -xzC /bin
RUN apt-get update && apt-get -qq -y --force-yes dist-upgrade && apt-get clean && rm -rf /var/cache/apt/archives/*
RUN /bin/herokuish buildpack install \
	&& ln -s /bin/herokuish /build \
	&& ln -s /bin/herokuish /start \
	&& ln -s /bin/herokuish /exec
COPY include/default_user.bash /tmp/default_user.bash
RUN bash /tmp/default_user.bash && rm -f /tmp/default_user.bash
