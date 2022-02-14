Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29C3C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Feb 2022 18:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357511AbiBNSjZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Feb 2022 13:39:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbiBNSjZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Feb 2022 13:39:25 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E7065418
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 10:39:13 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id bt13so49000219ybb.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 10:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A3IDWsr7pQasCgLof1uuYvu23ASiDLQs21jzN8ILbD8=;
        b=nd0v8trHoBHqpoOJgAJL7om1Belj33I7+KN11bH2m0JXmYWMio2voWkBHZHYLHkgkk
         0+hIp+/PKJi/kG9cykv74z6NDtH2/3NpSqkSSdoNYnj4QJVrQ3f1RAiWAeKRdusqgRiE
         4jLQkpU17qsNjatjUQ74WgjfF22umcnAI1NGVQ2TfkBSkZXWMkuBTJncz88CE5v5+GC1
         yK0iXzmQfskj5XPIG+f9NxwH1/wF9HiumcRI4xFU2JfSQDqVC9zSVuEwL0pFJjw0edGk
         CyNHz16/hS5RBiVKF/sE8/ltY7cWGrwK5TzJRTqSGrNTfqPwdTWq82MJuu+OI9TLXgm0
         FBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A3IDWsr7pQasCgLof1uuYvu23ASiDLQs21jzN8ILbD8=;
        b=WMO+QHp+gFL4ZWFaxv+rRsZz/rlCNM1usQN3FKABmSyT7rHEs6uYEiz9EQtyxQmNXc
         nhOqW3LIaGVkFNFvVNz914kOZeoK6TUjjV1zGG5UYSUfz7UPX1bWD5jNf+py1C2syNUg
         d7nxzezRn64giUSI8tj3deN2gHm3O0iRhy39uD7bAp9vJ77dwvfAc4C3yBGbhPydF4lv
         zUXD6ze3zyFFnNFC5CdKvhCUYMB82x1XpOfoQA5wfuxZwnX6STw0al3iRF4vBleSFsHD
         ojv5gqWW7eXD0Q6RH8iUsHISG3jSflyD5o2CnC9ZSMCVtP7fT40YER4ZcZmo+dMEO8/k
         RRxA==
X-Gm-Message-State: AOAM531V2I3wB8Vek208hhPDmZ39kZgyIlPu3YqAknw7J+zrVA+q9ciQ
        qJisweuZf3k6EqIaYzFUGfggVVpw9wKAU+2wBHOIsXDtqzY=
X-Google-Smtp-Source: ABdhPJzz5qdZDioHZfv9/Rti2q1QohH7G94HzN6d8vE4vCZBJ5mBkwgxmdb6wARLtPcNu4SaZIhRzDzRRLlbZh7gMbQ=
X-Received: by 2002:a81:4005:: with SMTP id l5mr6021ywn.317.1644863952894;
 Mon, 14 Feb 2022 10:39:12 -0800 (PST)
MIME-Version: 1.0
References: <20220214153105.2862331-1-fontaine.fabrice@gmail.com>
In-Reply-To: <20220214153105.2862331-1-fontaine.fabrice@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 14 Feb 2022 10:39:02 -0800
Message-ID: <CABBYNZ+_JiB=RZmcWuFtPL4p39gB1T3v85LbdWyVodcoYQLFRA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] fix build with glibc < 2.25
To:     Fabrice Fontaine <fontaine.fabrice@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Fabrice,

On Mon, Feb 14, 2022 at 8:09 AM Fabrice Fontaine
<fontaine.fabrice@gmail.com> wrote:
>
> getrandom and sys/random.h are only available since glibc 2.25:
> https://www.gnu.org/software/gnulib/manual/html_node/sys_002frandom_002eh.html
> resulting in the following build failures since version 5.63 and
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/log/?qt=grep&q=getrandom:
>
> plugins/autopair.c:20:24: fatal error: sys/random.h: No such file or directory
>  #include <sys/random.h>
>                         ^
>
> To fix this build failure, add a getrandom fallback borrowed from
> pipewire and licensed under MIT:
> https://gitlab.freedesktop.org/pipewire/pipewire/-/blob/master/src/pipewire/utils.c
>
> Fixes:
>  - http://autobuild.buildroot.org/results/6b8870d12e0804d6154230a7322c49416c1dc0e2
>
> Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
> ---
> Changes v1 -> v2 (after review of Marcel Holtmann):
>  - Add a getrandom fallback in src/missing.h instead of adding ifdef
>
>  Makefile.am            |  1 +
>  configure.ac           |  4 +++-
>  emulator/le.c          |  3 +++
>  emulator/phy.c         |  3 +++
>  peripheral/main.c      |  3 +++
>  plugins/autopair.c     |  3 +++
>  profiles/health/hdp.c  |  3 +++
>  profiles/health/mcap.c |  3 +++
>  src/missing.h          | 30 ++++++++++++++++++++++++++++++
>  tools/btgatt-server.c  |  3 +++
>  10 files changed, 55 insertions(+), 1 deletion(-)
>  create mode 100644 src/missing.h
>
> diff --git a/Makefile.am b/Makefile.am
> index 82125c482..d6c18fe0d 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -299,6 +299,7 @@ pkglibexec_PROGRAMS += src/bluetoothd
>  src_bluetoothd_SOURCES = $(builtin_sources) \
>                         $(attrib_sources) $(btio_sources) \
>                         src/bluetooth.ver \
> +                       src/missing.h \
>                         src/main.c src/log.h src/log.c \
>                         src/backtrace.h src/backtrace.c \
>                         src/rfkill.c src/btd.h src/sdpd.h \
> diff --git a/configure.ac b/configure.ac
> index 07d068a4d..441bd5f29 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -54,6 +54,8 @@ AC_ARG_ENABLE(threads, AS_HELP_STRING([--enable-threads],
>
>  AC_CHECK_FUNCS(explicit_bzero)
>
> +AC_CHECK_FUNCS(getrandom)
> +
>  AC_CHECK_FUNCS(rawmemchr)
>
>  AC_CHECK_FUNC(signalfd, dummy=yes,
> @@ -68,7 +70,7 @@ AC_CHECK_LIB(pthread, pthread_create, dummy=yes,
>  AC_CHECK_LIB(dl, dlopen, dummy=yes,
>                         AC_MSG_ERROR(dynamic linking loader is required))
>
> -AC_CHECK_HEADERS(linux/types.h linux/if_alg.h linux/uinput.h linux/uhid.h)
> +AC_CHECK_HEADERS(linux/types.h linux/if_alg.h linux/uinput.h linux/uhid.h sys/random.h)
>
>  PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.28, dummy=yes,
>                                 AC_MSG_ERROR(GLib >= 2.28 is required))
> diff --git a/emulator/le.c b/emulator/le.c
> index f8f313f2c..b3916d49b 100644
> --- a/emulator/le.c
> +++ b/emulator/le.c
> @@ -20,12 +20,15 @@
>  #include <sys/socket.h>
>  #include <sys/un.h>
>  #include <sys/uio.h>
> +#ifdef HAVE_SYS_RANDOM_H
>  #include <sys/random.h>
> +#endif
>  #include <time.h>
>
>  #include "lib/bluetooth.h"
>  #include "lib/hci.h"
>
> +#include "src/missing.h"
>  #include "src/shared/util.h"
>  #include "src/shared/crypto.h"
>  #include "src/shared/ecc.h"
> diff --git a/emulator/phy.c b/emulator/phy.c
> index 44cace438..9cb6460d7 100644
> --- a/emulator/phy.c
> +++ b/emulator/phy.c
> @@ -19,11 +19,14 @@
>  #include <stdlib.h>
>  #include <string.h>
>  #include <sys/socket.h>
> +#ifdef HAVE_SYS_RANDOM_H
>  #include <sys/random.h>
> +#endif
>  #include <netinet/in.h>
>  #include <netinet/ip.h>
>  #include <time.h>
>
> +#include "src/missing.h"
>  #include "src/shared/util.h"
>  #include "src/shared/mainloop.h"
>
> diff --git a/peripheral/main.c b/peripheral/main.c
> index 91adb45fc..e854bd14c 100644
> --- a/peripheral/main.c
> +++ b/peripheral/main.c
> @@ -25,12 +25,15 @@
>  #include <sys/stat.h>
>  #include <sys/types.h>
>  #include <sys/mount.h>
> +#ifdef HAVE_SYS_RANDOM_H
>  #include <sys/random.h>
> +#endif
>
>  #ifndef WAIT_ANY
>  #define WAIT_ANY (-1)
>  #endif
>
> +#include "src/missing.h"
>  #include "src/shared/mainloop.h"
>  #include "peripheral/efivars.h"
>  #include "peripheral/attach.h"
> diff --git a/plugins/autopair.c b/plugins/autopair.c
> index a75ecebe4..6ce97672b 100644
> --- a/plugins/autopair.c
> +++ b/plugins/autopair.c
> @@ -17,13 +17,16 @@
>  #include <fcntl.h>
>  #include <unistd.h>
>  #include <errno.h>
> +#ifdef HAVE_SYS_RANDOM_H
>  #include <sys/random.h>
> +#endif
>
>  #include <glib.h>
>
>  #include "lib/bluetooth.h"
>  #include "lib/sdp.h"
>
> +#include "src/missing.h"
>  #include "src/plugin.h"
>  #include "src/adapter.h"
>  #include "src/device.h"
> diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
> index 9d9d1e824..1e6e16fd2 100644
> --- a/profiles/health/hdp.c
> +++ b/profiles/health/hdp.c
> @@ -16,7 +16,9 @@
>  #include <stdint.h>
>  #include <stdbool.h>
>  #include <unistd.h>
> +#ifdef HAVE_SYS_RANDOM_H
>  #include <sys/random.h>
> +#endif
>
>  #include <glib.h>
>
> @@ -26,6 +28,7 @@
>
>  #include "gdbus/gdbus.h"
>
> +#include "src/missing.h"
>  #include "src/dbus-common.h"
>  #include "src/log.h"
>  #include "src/error.h"
> diff --git a/profiles/health/mcap.c b/profiles/health/mcap.c
> index aad0a08a3..6b779c513 100644
> --- a/profiles/health/mcap.c
> +++ b/profiles/health/mcap.c
> @@ -19,13 +19,16 @@
>  #include <errno.h>
>  #include <unistd.h>
>  #include <time.h>
> +#ifdef HAVE_SYS_RANDOM_H
>  #include <sys/random.h>
> +#endif
>
>  #include <glib.h>
>
>  #include "lib/bluetooth.h"
>  #include "bluetooth/l2cap.h"
>  #include "btio/btio.h"
> +#include "src/missing.h"
>  #include "src/log.h"
>  #include "src/shared/timeout.h"
>
> diff --git a/src/missing.h b/src/missing.h
> new file mode 100644
> index 000000000..df8bd980a
> --- /dev/null
> +++ b/src/missing.h
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2018 Wim Taymans
> + *
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#ifndef HAVE_GETRANDOM
> +ssize_t getrandom(void *buf, size_t buflen, unsigned int flags)
> +{
> +       ssize_t bytes;
> +       int fd;
> +
> +       fd = open("/dev/urandom", O_CLOEXEC);
> +       if (fd < 0)
> +               return -1;
> +
> +       bytes = read(fd, buf, buflen);
> +       close(fd);
> +
> +       return bytes;
> +}
> +#endif

How about having this under src/shared/util.h, name it util_getrandom
and don't bother with glibc otherwise this really gets messy
maintaining it over time

> diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
> index 15d49a464..30314f4ac 100644
> --- a/tools/btgatt-server.c
> +++ b/tools/btgatt-server.c
> @@ -20,7 +20,9 @@
>  #include <getopt.h>
>  #include <unistd.h>
>  #include <errno.h>
> +#ifdef HAVE_SYS_RANDOM_H
>  #include <sys/random.h>
> +#endif
>
>  #include "lib/bluetooth.h"
>  #include "lib/hci.h"
> @@ -28,6 +30,7 @@
>  #include "lib/l2cap.h"
>  #include "lib/uuid.h"
>
> +#include "src/missing.h"
>  #include "src/shared/mainloop.h"
>  #include "src/shared/util.h"
>  #include "src/shared/att.h"
> --
> 2.34.1
>


-- 
Luiz Augusto von Dentz
