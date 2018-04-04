Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Szymon Janc <szymon.janc@codecoup.pl>,
        linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: Re: [PATCH v4] tools: Add initial code for btmon-logger
In-Reply-To: <20180314142801.21381-1-szymon.janc@codecoup.pl>
References: <20180314142801.21381-1-szymon.janc@codecoup.pl>
Date: Wed, 04 Apr 2018 16:38:53 -0700
Message-ID: <87vad6mtiq.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

Szymon Janc <szymon.janc@codecoup.pl> writes:

> This is intended for use for automated logging or unatrended systems.
> It doesn't contain any packet decoding functionality which results
> in much smaller binary.
> ---
>  .gitignore                    |   2 +
>  Makefile.tools                |  15 ++
>  android/bluetoothd-snoop.c    |   2 +-
>  bootstrap-configure           |   1 +
>  configure.ac                  |   4 +
>  monitor/control.c             |   2 +-
>  src/shared/btsnoop.c          |  75 +++++++++-
>  src/shared/btsnoop.h          |   3 +-
>  tools/btmon-logger.c          | 314 ++++++++++++++++++++++++++++++++++++++++++
>  tools/btmon-logger.service.in |  15 ++
>  10 files changed, 428 insertions(+), 5 deletions(-)
>  create mode 100644 tools/btmon-logger.c
>  create mode 100644 tools/btmon-logger.service.in
>
> diff --git a/.gitignore b/.gitignore
> index 47808059b..2c5cf0f83 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -118,6 +118,8 @@ tools/btconfig
>  tools/btmgmt
>  tools/btsnoop
>  tools/btpclient
> +tools/btmon-logger
> +tools/btmon-logger.service
>  peripheral/btsensor
>  monitor/btmon
>  emulator/btvirt
> diff --git a/Makefile.tools b/Makefile.tools
> index f7ab77de1..75e39085d 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -66,6 +66,21 @@ monitor_btmon_LDADD = lib/libbluetooth-internal.la \
>  				src/libshared-mainloop.la @UDEV_LIBS@
>  endif
>  
> +if LOGGER
> +libexec_PROGRAMS += tools/btmon-logger
> +
> +tools_btmon_logger_SOURCES = tools/btmon-logger.c lib/monitor.h
> +tools_btmon_logger_LDADD = src/libshared-mainloop.la
> +tools_btmon_logger_DEPENDENCIES = tools/btmon-logger.service

The autotools documentation may have an explanation for the problem you
reported on IRC (repeating here, in case you didn't have the chance to
see it there).

It could be that _LDADD variables are used to build the value of
_DEPENDENCIES variables, and so, the fact that you are setting the
value, you are overriding the "calculated" value. (This is a *wild*
guess)

>From here:

https://www.gnu.org/software/automake/manual/html_node/Linking.html

"If prog_DEPENDENCIES is not supplied, it is computed by Automake. The
automatically-assigned value is the contents of prog_LDADD, with most
configure substitutions, -l, -L, -dlopen and -dlpreopen options
removed."

Perhaps replacing "=" by "+=" would help?


Cheers,
--
Vinicius
