Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1382623538-17510-1-git-send-email-szymon.janc@tieto.com>
References: <1382623538-17510-1-git-send-email-szymon.janc@tieto.com>
Date: Thu, 24 Oct 2013 18:40:37 +0300
Message-ID: <CABBYNZ+HT-huAYAPpmxWdJjOHxdV=rCGAinY6S_jo9_r-kokqw@mail.gmail.com>
Subject: Re: [PATCH] android: Fix debug logs when running on Android
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Oct 24, 2013 at 5:05 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> Current Android log backed dones't enable debug logs. Instead of coping
> code from src/log.c, just use it on Android as well.
>
> No functionality is lost as currently Android log backed only prints
> to standard output.
> ---
>  Makefile.android   |  5 ++-
>  android/Android.mk |  2 +-
>  android/log.c      | 90 ------------------------------------------------------
>  3 files changed, 3 insertions(+), 94 deletions(-)
>  delete mode 100644 android/log.c
>
> diff --git a/Makefile.android b/Makefile.android
> index 8e09a78..01b3cea 100644
> --- a/Makefile.android
> +++ b/Makefile.android
> @@ -64,9 +64,8 @@ android_haltest_LDFLAGS = -pthread
>
>  endif
>
> -EXTRA_DIST += android/Android.mk android/log.c android/device.c \
> -               android/adapter.c android/main.c android/hal-msg.h \
> -               android/hal.h
> +EXTRA_DIST += android/Android.mk android/device.c android/adapter.c\
> +               android/main.c android/hal-msg.h android/hal.h
>
>  EXTRA_DIST += android/hal-bluetooth.c \
>                 android/hal-sock.c \
> diff --git a/android/Android.mk b/android/Android.mk
> index aac5c67..890b5ac 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -14,11 +14,11 @@ include $(CLEAR_VARS)
>
>  LOCAL_SRC_FILES := \
>         main.c \
> -       log.c \
>         adapter.c \
>         hid.c \
>         socket.c \
>         ipc.c ipc.h \
> +       ../src/log.c \
>         ../src/shared/mgmt.c \
>         ../src/shared/util.c \
>         ../src/sdpd-database.c \
> diff --git a/android/log.c b/android/log.c
> deleted file mode 100644
> index 98afaa9..0000000
> --- a/android/log.c
> +++ /dev/null
> @@ -1,90 +0,0 @@
> -/*
> - *
> - *  BlueZ - Bluetooth protocol stack for Linux
> - *
> - *  Copyright (C) 2013  Intel Corporation. All rights reserved.
> - *
> - *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, write to the Free Software
> - *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> - *
> - */
> -
> -#ifdef HAVE_CONFIG_H
> -#include <config.h>
> -#endif
> -
> -#include <fcntl.h>
> -#include <stdio.h>
> -#include <stdarg.h>
> -#include <unistd.h>
> -#include <sys/uio.h>
> -
> -#include <glib.h>
> -
> -void info(const char *format, ...)
> -{
> -       va_list ap;
> -
> -       va_start(ap, format);
> -
> -       vfprintf(stdout, format, ap);
> -       fprintf(stdout, "\n");
> -
> -       va_end(ap);
> -}
> -
> -void warn(const char *format, ...)
> -{
> -       va_list ap;
> -
> -       va_start(ap, format);
> -
> -       vfprintf(stderr, format, ap);
> -       fprintf(stderr, "\n");
> -
> -       va_end(ap);
> -}
> -
> -void error(const char *format, ...)
> -{
> -       va_list ap;
> -
> -       va_start(ap, format);
> -
> -       vfprintf(stderr, format, ap);
> -       fprintf(stderr, "\n");
> -
> -       va_end(ap);
> -}
> -
> -void btd_debug(const char *format, ...)
> -{
> -       va_list ap;
> -
> -       va_start(ap, format);
> -
> -       vfprintf(stdout, format, ap);
> -       fprintf(stdout, "\n");
> -
> -       va_end(ap);
> -}
> -
> -void __btd_log_init(const char *debug, int detach)
> -{
> -}
> -
> -void __btd_log_cleanup(void)
> -{
> -}
> --
> 1.8.4.1

Pushed, thanks.


-- 
Luiz Augusto von Dentz
