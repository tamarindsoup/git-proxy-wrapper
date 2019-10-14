#! /bin/sh

if [ -z "$(/usr/bin/git config --get http.proxy)" ]; then
    if [ ! -z ${http_proxy:+x} ] || [ ! -z ${HTTP_PROXY:+x} ]; then
        GIT_HTTP_PROXY_CONFIGURED=1
        /usr/bin/git config --global http.proxy ${http_proxy:-${HTTP_PROXY}}
    fi
fi
if [ -z "$(/usr/bin/git config --get https.proxy)" ]; then
    if [ ! -z ${https_proxy:+x} ] || [ ! -z ${HTTPS_PROXY:+x} ]; then
        GIT_HTTPS_PROXY_CONFIGURED=1
        /usr/bin/git config --global https.proxy ${https_proxy:-${HTTPS_PROXY}}
    fi
fi

/usr/bin/git ${@}

if [ -n "${GIT_HTTP_PROXY_CONFIGURED}" ]; then
    /usr/bin/git config --global --unset http.proxy
    unset GIT_HTTP_PROXY_CONFIGURED
fi

if [ -n "${GIT_HTTPS_PROXY_CONFIGURED}" ]; then
    /usr/bin/git config --global --unset https.proxy
    unset GIT_HTTPS_PROXY_CONFIGURED
fi
