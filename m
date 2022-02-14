Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976F2C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Feb 2022 21:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiBNVCC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Feb 2022 16:02:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiBNVCA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Feb 2022 16:02:00 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643BF9BBBC
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 13:01:50 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id f11-20020a4abb0b000000b002e9abf6bcbcso20855484oop.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 13:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=in1ukgDdwmi4z1sey7AxFBnq4qyguMC8bim4ccG+/Bg=;
        b=WjVZsYC2W1494cKXSCFlVAf74EMuwbMarec3BKN+0N+22So0qDFMINdmk8m6a5molz
         JqhD3Q6EOercZcqSRZsOpu0D8e5ElMz12X8it/moNEAe4N6h5ia4DH/OJwxGKC5K4Rm9
         FwOxmX4F3Sk7rB4bPzcA4Jlkrl6u7ltYbe2Bve8WWvXO1h8HJltOacOHZ5TWG0kY7JSk
         x37mxavIWihMY+F3N0I5V45Yg5DpFwaBzqr4PV2eTVQQcg78/Ri6mQAgVEHMi4smBA6Y
         vtmxLs1oLu2uQG7jHM9EjIqrhJu5Mmp37LjvvicdL17NZahFpUdJZDOd9o1U9BJbywqD
         YYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=in1ukgDdwmi4z1sey7AxFBnq4qyguMC8bim4ccG+/Bg=;
        b=hd1742doeMf28hemEnHp5TUA68ppQvr0DXdCA/n0+ZFa+crQEw+UldQBu65t1hNp8b
         w0vgDQDATArrkEaI8nhLwKPBtub7gbXXgpExvXHbzi3x4XXwwRTF4DDRZco8IAv5p9PD
         iGUqFoSRJxdRS5HtMSgZoOF5NTAGw5yiE63j7kR/Nd5hsgIAPgeEPoUSIc4hR+my9Xr1
         0oObZ6PDb29OdD9GqSyPPjsovFF1xS/on3ohv4KE/sArw1e6BlLmcDaOkfVdhCyTlNXu
         xk/yS0cLKYHIaf8lfoq0kzTQuYTsba3Yl4LnKgexBtlnyNCUVY3UX5w6Qt3W4/kFMzQV
         p7bw==
X-Gm-Message-State: AOAM531w89dcVXck6i/Kr3cmRWcjMl7bOmvqhByk0CyCeNMAuMTC6hDJ
        dOSi1Orc3Ll5gRCGeQVnO1iFoydo8oKEADlqdlcMVoJZxQScHQ==
X-Google-Smtp-Source: ABdhPJzWJ8Hbt4i3K6rbTcE1xyOLKvaReaS7XNNF5eJ6qWI3UhP1gW/QXZST1t80HzBuwXHr0oQVMJzFbvDEbj+nx1o=
X-Received: by 2002:a05:6870:8c2f:b0:d0:88cf:27be with SMTP id
 ec47-20020a0568708c2f00b000d088cf27bemr150047oab.60.1644867302747; Mon, 14
 Feb 2022 11:35:02 -0800 (PST)
MIME-Version: 1.0
References: <20220214153105.2862331-1-fontaine.fabrice@gmail.com> <CABBYNZ+_JiB=RZmcWuFtPL4p39gB1T3v85LbdWyVodcoYQLFRA@mail.gmail.com>
In-Reply-To: <CABBYNZ+_JiB=RZmcWuFtPL4p39gB1T3v85LbdWyVodcoYQLFRA@mail.gmail.com>
From:   Fabrice Fontaine <fontaine.fabrice@gmail.com>
Date:   Mon, 14 Feb 2022 20:35:15 +0100
Message-ID: <CAPi7W80u1-45gPxLSWS3Jysb7xOeaLH8AdUUHj2sotBMmHQqcQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] fix build with glibc < 2.25
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Le lun. 14 f=C3=A9vr. 2022 =C3=A0 19:39, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> a =C3=A9crit :
>
> Hi Fabrice,
>
> On Mon, Feb 14, 2022 at 8:09 AM Fabrice Fontaine
> <fontaine.fabrice@gmail.com> wrote:
> >
> > getrandom and sys/random.h are only available since glibc 2.25:
> > https://www.gnu.org/software/gnulib/manual/html_node/sys_002frandom_002=
eh.html
> > resulting in the following build failures since version 5.63 and
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/log/?qt=3Dgrep&q=3Dg=
etrandom:
> >
> > plugins/autopair.c:20:24: fatal error: sys/random.h: No such file or di=
rectory
> >  #include <sys/random.h>
> >                         ^
> >
> > To fix this build failure, add a getrandom fallback borrowed from
> > pipewire and licensed under MIT:
> > https://gitlab.freedesktop.org/pipewire/pipewire/-/blob/master/src/pipe=
wire/utils.c
> >
> > Fixes:
> >  - http://autobuild.buildroot.org/results/6b8870d12e0804d6154230a7322c4=
9416c1dc0e2
> >
> > Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
> > ---
> > Changes v1 -> v2 (after review of Marcel Holtmann):
> >  - Add a getrandom fallback in src/missing.h instead of adding ifdef
> >
> >  Makefile.am            |  1 +
> >  configure.ac           |  4 +++-
> >  emulator/le.c          |  3 +++
> >  emulator/phy.c         |  3 +++
> >  peripheral/main.c      |  3 +++
> >  plugins/autopair.c     |  3 +++
> >  profiles/health/hdp.c  |  3 +++
> >  profiles/health/mcap.c |  3 +++
> >  src/missing.h          | 30 ++++++++++++++++++++++++++++++
> >  tools/btgatt-server.c  |  3 +++
> >  10 files changed, 55 insertions(+), 1 deletion(-)
> >  create mode 100644 src/missing.h
> >
> > diff --git a/Makefile.am b/Makefile.am
> > index 82125c482..d6c18fe0d 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -299,6 +299,7 @@ pkglibexec_PROGRAMS +=3D src/bluetoothd
> >  src_bluetoothd_SOURCES =3D $(builtin_sources) \
> >                         $(attrib_sources) $(btio_sources) \
> >                         src/bluetooth.ver \
> > +                       src/missing.h \
> >                         src/main.c src/log.h src/log.c \
> >                         src/backtrace.h src/backtrace.c \
> >                         src/rfkill.c src/btd.h src/sdpd.h \
> > diff --git a/configure.ac b/configure.ac
> > index 07d068a4d..441bd5f29 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -54,6 +54,8 @@ AC_ARG_ENABLE(threads, AS_HELP_STRING([--enable-threa=
ds],
> >
> >  AC_CHECK_FUNCS(explicit_bzero)
> >
> > +AC_CHECK_FUNCS(getrandom)
> > +
> >  AC_CHECK_FUNCS(rawmemchr)
> >
> >  AC_CHECK_FUNC(signalfd, dummy=3Dyes,
> > @@ -68,7 +70,7 @@ AC_CHECK_LIB(pthread, pthread_create, dummy=3Dyes,
> >  AC_CHECK_LIB(dl, dlopen, dummy=3Dyes,
> >                         AC_MSG_ERROR(dynamic linking loader is required=
))
> >
> > -AC_CHECK_HEADERS(linux/types.h linux/if_alg.h linux/uinput.h linux/uhi=
d.h)
> > +AC_CHECK_HEADERS(linux/types.h linux/if_alg.h linux/uinput.h linux/uhi=
d.h sys/random.h)
> >
> >  PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.28, dummy=3Dyes,
> >                                 AC_MSG_ERROR(GLib >=3D 2.28 is required=
))
> > diff --git a/emulator/le.c b/emulator/le.c
> > index f8f313f2c..b3916d49b 100644
> > --- a/emulator/le.c
> > +++ b/emulator/le.c
> > @@ -20,12 +20,15 @@
> >  #include <sys/socket.h>
> >  #include <sys/un.h>
> >  #include <sys/uio.h>
> > +#ifdef HAVE_SYS_RANDOM_H
> >  #include <sys/random.h>
> > +#endif
> >  #include <time.h>
> >
> >  #include "lib/bluetooth.h"
> >  #include "lib/hci.h"
> >
> > +#include "src/missing.h"
> >  #include "src/shared/util.h"
> >  #include "src/shared/crypto.h"
> >  #include "src/shared/ecc.h"
> > diff --git a/emulator/phy.c b/emulator/phy.c
> > index 44cace438..9cb6460d7 100644
> > --- a/emulator/phy.c
> > +++ b/emulator/phy.c
> > @@ -19,11 +19,14 @@
> >  #include <stdlib.h>
> >  #include <string.h>
> >  #include <sys/socket.h>
> > +#ifdef HAVE_SYS_RANDOM_H
> >  #include <sys/random.h>
> > +#endif
> >  #include <netinet/in.h>
> >  #include <netinet/ip.h>
> >  #include <time.h>
> >
> > +#include "src/missing.h"
> >  #include "src/shared/util.h"
> >  #include "src/shared/mainloop.h"
> >
> > diff --git a/peripheral/main.c b/peripheral/main.c
> > index 91adb45fc..e854bd14c 100644
> > --- a/peripheral/main.c
> > +++ b/peripheral/main.c
> > @@ -25,12 +25,15 @@
> >  #include <sys/stat.h>
> >  #include <sys/types.h>
> >  #include <sys/mount.h>
> > +#ifdef HAVE_SYS_RANDOM_H
> >  #include <sys/random.h>
> > +#endif
> >
> >  #ifndef WAIT_ANY
> >  #define WAIT_ANY (-1)
> >  #endif
> >
> > +#include "src/missing.h"
> >  #include "src/shared/mainloop.h"
> >  #include "peripheral/efivars.h"
> >  #include "peripheral/attach.h"
> > diff --git a/plugins/autopair.c b/plugins/autopair.c
> > index a75ecebe4..6ce97672b 100644
> > --- a/plugins/autopair.c
> > +++ b/plugins/autopair.c
> > @@ -17,13 +17,16 @@
> >  #include <fcntl.h>
> >  #include <unistd.h>
> >  #include <errno.h>
> > +#ifdef HAVE_SYS_RANDOM_H
> >  #include <sys/random.h>
> > +#endif
> >
> >  #include <glib.h>
> >
> >  #include "lib/bluetooth.h"
> >  #include "lib/sdp.h"
> >
> > +#include "src/missing.h"
> >  #include "src/plugin.h"
> >  #include "src/adapter.h"
> >  #include "src/device.h"
> > diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
> > index 9d9d1e824..1e6e16fd2 100644
> > --- a/profiles/health/hdp.c
> > +++ b/profiles/health/hdp.c
> > @@ -16,7 +16,9 @@
> >  #include <stdint.h>
> >  #include <stdbool.h>
> >  #include <unistd.h>
> > +#ifdef HAVE_SYS_RANDOM_H
> >  #include <sys/random.h>
> > +#endif
> >
> >  #include <glib.h>
> >
> > @@ -26,6 +28,7 @@
> >
> >  #include "gdbus/gdbus.h"
> >
> > +#include "src/missing.h"
> >  #include "src/dbus-common.h"
> >  #include "src/log.h"
> >  #include "src/error.h"
> > diff --git a/profiles/health/mcap.c b/profiles/health/mcap.c
> > index aad0a08a3..6b779c513 100644
> > --- a/profiles/health/mcap.c
> > +++ b/profiles/health/mcap.c
> > @@ -19,13 +19,16 @@
> >  #include <errno.h>
> >  #include <unistd.h>
> >  #include <time.h>
> > +#ifdef HAVE_SYS_RANDOM_H
> >  #include <sys/random.h>
> > +#endif
> >
> >  #include <glib.h>
> >
> >  #include "lib/bluetooth.h"
> >  #include "bluetooth/l2cap.h"
> >  #include "btio/btio.h"
> > +#include "src/missing.h"
> >  #include "src/log.h"
> >  #include "src/shared/timeout.h"
> >
> > diff --git a/src/missing.h b/src/missing.h
> > new file mode 100644
> > index 000000000..df8bd980a
> > --- /dev/null
> > +++ b/src/missing.h
> > @@ -0,0 +1,30 @@
> > +// SPDX-License-Identifier: MIT
> > +/*
> > + *
> > + *  BlueZ - Bluetooth protocol stack for Linux
> > + *
> > + *  Copyright (C) 2018 Wim Taymans
> > + *
> > + *
> > + */
> > +
> > +#ifdef HAVE_CONFIG_H
> > +#include <config.h>
> > +#endif
> > +
> > +#ifndef HAVE_GETRANDOM
> > +ssize_t getrandom(void *buf, size_t buflen, unsigned int flags)
> > +{
> > +       ssize_t bytes;
> > +       int fd;
> > +
> > +       fd =3D open("/dev/urandom", O_CLOEXEC);
> > +       if (fd < 0)
> > +               return -1;
> > +
> > +       bytes =3D read(fd, buf, buflen);
> > +       close(fd);
> > +
> > +       return bytes;
> > +}
> > +#endif
>
> How about having this under src/shared/util.h, name it util_getrandom
> and don't bother with glibc otherwise this really gets messy
> maintaining it over time

OK, I'll send a v3 that adds util_getrandom in src/shared/util.h.
However, I'll keep calling getrandom if it is available as the
fallback is ignoring the flags argument.
As a result, the fallback is always using /dev/urandom.
This is probably more future proof even if all getrandom calls in
BlueZ are currently setting the flags to 0.

>
> > diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
> > index 15d49a464..30314f4ac 100644
> > --- a/tools/btgatt-server.c
> > +++ b/tools/btgatt-server.c
> > @@ -20,7 +20,9 @@
> >  #include <getopt.h>
> >  #include <unistd.h>
> >  #include <errno.h>
> > +#ifdef HAVE_SYS_RANDOM_H
> >  #include <sys/random.h>
> > +#endif
> >
> >  #include "lib/bluetooth.h"
> >  #include "lib/hci.h"
> > @@ -28,6 +30,7 @@
> >  #include "lib/l2cap.h"
> >  #include "lib/uuid.h"
> >
> > +#include "src/missing.h"
> >  #include "src/shared/mainloop.h"
> >  #include "src/shared/util.h"
> >  #include "src/shared/att.h"
> > --
> > 2.34.1
> >
>
>
> --
> Luiz Augusto von Dentz
Best Regards,

Fabrice
