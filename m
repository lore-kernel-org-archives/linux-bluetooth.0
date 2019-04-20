Return-Path: <SRS0=jtTj=SW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D15C282DD
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 Apr 2019 06:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19DC3208C0
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 Apr 2019 06:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wne4eoJi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbfDTGsU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 20 Apr 2019 02:48:20 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46863 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfDTGsU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 20 Apr 2019 02:48:20 -0400
Received: by mail-oi1-f194.google.com with SMTP id x188so5303169oia.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2019 23:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AJlSu1mXQI9AWz45oOaNv56cPD2JmTkcyI/skk2jrbk=;
        b=Wne4eoJioCu/8ofVzg1BoXyvIkz25fTbTq5vwrh/wOgyoYA8LR9yeTObJi28pCQPtz
         KDhQfgu3NhMYuHENWPprXTOEGRyXnqmUS3jbwp8CGVocf7enNWerMySz59nGcYJ+5ZVq
         yfHU5ks92N0RnwWiK7zOGdGkqFDgEICF16KziyPoDQucokv7xtlUd9lnnWB5Fbbo3uui
         HQn63xgpdMN2YftjdmgWaF8fXbEPofowF/YgUZ2qcJoKI4ucRHu1Tcen+CTS/m4/f2wr
         wzmKp6cucGHUQQjEfmR65cMNvx/m0JFXbsHvN0t3WKU++N6XNHKbqQQSOtVHKJFIQd9J
         CtGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AJlSu1mXQI9AWz45oOaNv56cPD2JmTkcyI/skk2jrbk=;
        b=KjV43dxCBnIBZ+5gCsM38hNknoRVd0w456kJQys09/a82OhrYm/C3mgnUp0yx+UENC
         ToNHeUvXECpZXIG8VY4jDcubQyBtuNsaVncX+VdwQ6FZSp3+MQFuJDuv7o6VP9qCjOLB
         qWW7Ndp6fKejHByfsCjY4WSF0sLiaWaTGrScl8hBzeeTX26Oh7P1pbRetp4nvu3bXL4C
         Y2aLrzDIOekOGM9Ag6ngb2xbuCBWv0MFF+tAxhbDjhWVfTcW71tZsDzEkd9yFbXACer0
         64gJUovDvIwSVNPnUMY+BFyCAx0pkBn37bAakBAduChGrUSI15kspcMheVmZjp7LZIpd
         Z7IQ==
X-Gm-Message-State: APjAAAVHu1KsIpLTaqoBEkTF9f/QE6QrmvMgkSgni4/wFOQsrERmnmVM
        mw7pm8RTvs5SXmXjHfCZg/XNOnk0yocXSlIZb/+BplhI
X-Google-Smtp-Source: APXvYqyxRz4QvYtl2CF/RmI9KqY+kErTarKKkfayIN/lT8fvzqhAN3dot8yAJn7EAEoOZbSrLxZI9M2uVoND24TmjlA=
X-Received: by 2002:aca:4a0a:: with SMTP id x10mr3922486oia.82.1555742899512;
 Fri, 19 Apr 2019 23:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190419105146.29272-1-szymon.janc@codecoup.pl>
In-Reply-To: <20190419105146.29272-1-szymon.janc@codecoup.pl>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sat, 20 Apr 2019 09:48:10 +0300
Message-ID: <CABBYNZKM4jFa=e=A3PWmvtJpQznW3rLJ172eU7GBW6ekZd2u1Q@mail.gmail.com>
Subject: Re: [PATCH] build: Bump glib dependency to 2.32
To:     Szymon Janc <szymon.janc@codecoup.pl>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Szymon,

On Fri, Apr 19, 2019 at 10:48 PM Szymon Janc <szymon.janc@codecoup.pl> wrot=
e:
>
> make --no-print-directory all-am
>   CC       client/main.o
> In file included from /usr/include/glib-2.0/glib/gasyncqueue.h:32,
>                  from /usr/include/glib-2.0/glib.h:32,
>                  from client/main.c:36:

Weird it seems to be triggering the use of a deprecated API on its
own? That would be a bug in glib, also weird it did not trigger to
other tools only for client.

> /usr/include/glib-2.0/glib/gthread.h: In function =E2=80=98g_rec_mutex_lo=
cker_new=E2=80=99:
> /usr/include/glib-2.0/glib/gthread.h:390:3: error: =E2=80=98g_rec_mutex_l=
ock=E2=80=99 is deprecated: Not available before 2.32 [-Werror=3Ddeprecated=
-declarations]
>    g_rec_mutex_lock (rec_mutex);
>    ^~~~~~~~~~~~~~~~
> /usr/include/glib-2.0/glib/gthread.h:196:17: note: declared here
>  void            g_rec_mutex_lock                (GRecMutex      *rec_mut=
ex);
>                  ^~~~~~~~~~~~~~~~
> /usr/include/glib-2.0/glib/gthread.h: In function =E2=80=98g_rec_mutex_lo=
cker_free=E2=80=99:
> /usr/include/glib-2.0/glib/gthread.h:405:3: error: =E2=80=98g_rec_mutex_u=
nlock=E2=80=99 is deprecated: Not available before 2.32 [-Werror=3Ddeprecat=
ed-declarations]
>    g_rec_mutex_unlock ((GRecMutex *) locker);
>    ^~~~~~~~~~~~~~~~~~
> /usr/include/glib-2.0/glib/gthread.h:200:17: note: declared here
>  void            g_rec_mutex_unlock              (GRecMutex      *rec_mut=
ex);
>                  ^~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[1]: *** [Makefile:6579: client/main.o] Error 1
> ---
>  acinclude.m4 | 4 ++--
>  configure.ac | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/acinclude.m4 b/acinclude.m4
> index bc39c6d73..4565f77e3 100644
> --- a/acinclude.m4
> +++ b/acinclude.m4
> @@ -23,8 +23,8 @@ AC_DEFUN([COMPILER_FLAGS], [
>                 with_cflags=3D"$with_cflags -Wswitch-enum"
>                 with_cflags=3D"$with_cflags -Wformat -Wformat-security"
>                 with_cflags=3D"$with_cflags -DG_DISABLE_DEPRECATED"
> -               with_cflags=3D"$with_cflags -DGLIB_VERSION_MIN_REQUIRED=
=3DGLIB_VERSION_2_28"
> -               with_cflags=3D"$with_cflags -DGLIB_VERSION_MAX_ALLOWED=3D=
GLIB_VERSION_2_28"
> +               with_cflags=3D"$with_cflags -DGLIB_VERSION_MIN_REQUIRED=
=3DGLIB_VERSION_2_32"
> +               with_cflags=3D"$with_cflags -DGLIB_VERSION_MAX_ALLOWED=3D=
GLIB_VERSION_2_32"
>         fi
>         AC_SUBST([WARNING_CFLAGS], $with_cflags)
>  ])
> diff --git a/configure.ac b/configure.ac
> index 0afe1e6db..1b4ef77f7 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -62,8 +62,8 @@ AC_CHECK_LIB(dl, dlopen, dummy=3Dyes,
>
>  AC_CHECK_HEADERS(linux/types.h linux/if_alg.h)
>
> -PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.28, dummy=3Dyes,
> -                               AC_MSG_ERROR(GLib >=3D 2.28 is required))
> +PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.32, dummy=3Dyes,
> +                               AC_MSG_ERROR(GLib >=3D 2.32 is required))
>  AC_SUBST(GLIB_CFLAGS)
>  AC_SUBST(GLIB_LIBS)
>
> --
> 2.20.1
>


--=20
Luiz Augusto von Dentz
