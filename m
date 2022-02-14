Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE78EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Feb 2022 15:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355800AbiBNPVM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Feb 2022 10:21:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355791AbiBNPVL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Feb 2022 10:21:11 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF465BD24
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 07:21:00 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id o128-20020a4a4486000000b003181707ed40so19585285ooa.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 07:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+rsm9s8bwH8CU3oPrz8RWEhjK76fepMw0nT+6ayXOTY=;
        b=Vmaqs70B7ZJwt3tYFAG6NiHv9RN4aP4EbUUztomh+C1mxGQIb5PB3d+YWuUnYyn5Q5
         Iz7pf/+p4y2mDwXb/77ckBY4JLiaX1NHvcW/5M3U8rAhEqU+lY3IUVqfzMKjrpaPefWC
         k/lfAa4H5Db9k4vU0jiqmhOEQixg/prQxabG1rVA7ybtmPEDX78qz8CiCvp66cTRvqSX
         SPE/j3cNCeUnEER/Pwa1PuHDnfyMjHijWyZoo9+IqzgaJw2CDs5T0pC6YYHYCLyQ+pKx
         oBOv7h8i0xIn3qDdhLQGLA4Vxmdc/m6CgjvgW0KPi/RuvH0ht4uHSuv48WytTAkUEB1j
         A/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+rsm9s8bwH8CU3oPrz8RWEhjK76fepMw0nT+6ayXOTY=;
        b=faVBTZ6+h/Bcpr6igzEWGrsZREzis0K7cuobhDRu8NQ/qhoF6iCanCOJm6+X7qFK10
         rBC6Rka4LOc5C+mEKzUc2KyW6ruuBunGV97gX34c0YHycjYj8CklqW2X2PYPmrliK/ZX
         RoG3Odqpq5HSK2HLO+9gPPMBM53oy0disNO3O2bke3XD6rH8oU59RQ1gU6t03l509QFB
         liYL4ZIhQHzFvS1qc1O6L0vUD4pTadDFr1XLT1F98sCtCKDYbJ8M4GO7aCQVgYF4LT4K
         kFo/8TWVcRO4Ws7YcYMW86PRTnofXv4YHgFXtFqQk5EROc/+bXyXISYNP/Fd10wR8SXx
         rmWg==
X-Gm-Message-State: AOAM531Ubcm8sv9AKhAFBcOOlWXStQAEIOuriva1ltlgjAvALD1Su4nh
        uLLm8DDA1wgccLK2ybNFAAaghRejy6pdM7CNIwizqx7FD6E=
X-Google-Smtp-Source: ABdhPJwdqz38e7lpQfPQmS02nMYpAc+WQhBIcxB33KVN9/hvNf86ye3tzCx6GjkBq+T0kecxGYNoqRc1dHFKQ9Lx334=
X-Received: by 2002:a4a:8f14:: with SMTP id e20mr73099ool.0.1644852059477;
 Mon, 14 Feb 2022 07:20:59 -0800 (PST)
MIME-Version: 1.0
References: <20220214131451.2397549-1-fontaine.fabrice@gmail.com> <562900D8-1A46-46E4-B31E-FD3FBE9BE2D8@holtmann.org>
In-Reply-To: <562900D8-1A46-46E4-B31E-FD3FBE9BE2D8@holtmann.org>
From:   Fabrice Fontaine <fontaine.fabrice@gmail.com>
Date:   Mon, 14 Feb 2022 16:21:13 +0100
Message-ID: <CAPi7W81q86a1dOm+K+tiOQNhqYa3FKRj_K+TSyfJgsXazMjLPQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] fix build with glibc < 2.25
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

Le lun. 14 f=C3=A9vr. 2022 =C3=A0 15:14, Marcel Holtmann <marcel@holtmann.o=
rg> a =C3=A9crit :
>
> Hi Fabrice,
>
> > getrandom and sys/random.h are only available since glibc 2.25:
> > https://www.gnu.org/software/gnulib/manual/html_node/sys_002frandom_002=
eh.html
> > resulting in the following build failures since version 5.63 and
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/log/?qt=3Dgrep&q=3Dg=
etrandom
> > so put back rand() as a fallback:
> >
> > plugins/autopair.c:20:24: fatal error: sys/random.h: No such file or di=
rectory
> > #include <sys/random.h>
> >                        ^
> >
> > Fixes:
> > - http://autobuild.buildroot.org/results/6b8870d12e0804d6154230a7322c49=
416c1dc0e2
> >
> > Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
> > ---
> > configure.ac           |  2 ++
> > emulator/le.c          |  7 +++++++
> > emulator/phy.c         |  7 +++++++
> > peripheral/main.c      | 10 ++++++++++
> > plugins/autopair.c     |  6 ++++++
> > profiles/health/hdp.c  | 11 +++++++++++
> > profiles/health/mcap.c | 10 ++++++++++
> > tools/btgatt-server.c  |  6 ++++++
> > 8 files changed, 59 insertions(+)
> >
> > diff --git a/configure.ac b/configure.ac
> > index 07d068a4d..cdd693da3 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -54,6 +54,8 @@ AC_ARG_ENABLE(threads, AS_HELP_STRING([--enable-threa=
ds],
> >
> > AC_CHECK_FUNCS(explicit_bzero)
> >
> > +AC_CHECK_FUNCS(getrandom)
> > +
> > AC_CHECK_FUNCS(rawmemchr)
> >
> > AC_CHECK_FUNC(signalfd, dummy=3Dyes,
> > diff --git a/emulator/le.c b/emulator/le.c
> > index f8f313f2c..9ef0636d0 100644
> > --- a/emulator/le.c
> > +++ b/emulator/le.c
> > @@ -20,7 +20,9 @@
> > #include <sys/socket.h>
> > #include <sys/un.h>
> > #include <sys/uio.h>
> > +#ifdef HAVE_GETRANDOM
> > #include <sys/random.h>
> > +#endif
> > #include <time.h>
> >
> > #include "lib/bluetooth.h"
> > @@ -509,10 +511,15 @@ static unsigned int get_adv_delay(void)
> >       /* The advertising delay is a pseudo-random value with a range
> >        * of 0 ms to 10 ms generated for each advertising event.
> >        */
> > +#ifdef HAVE_GETRANDOM
> >       if (getrandom(&val, sizeof(val), 0) < 0) {
> >               /* If it fails to get the random number, use a static val=
ue */
> >               val =3D 5;
> >       }
> > +#else
> > +     srand(time(NULL));
> > +     val =3D rand();
> > +#endif
>
> you need to introduce a src/missing.h and provide a getrandom fallback. I=
 am not allowing to spread #ifdef around the code for some old glibc compat=
ibility.
OK, I'll send a v2.
>
> Regards
>
> Marcel
>
Best Regards,

Fabrice
