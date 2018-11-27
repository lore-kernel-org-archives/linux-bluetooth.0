Return-Path: <SRS0=erFC=OG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E82C04EBA
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Nov 2018 15:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D0E208E4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Nov 2018 15:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYIqEb3U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D0E208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbeK1CSP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Nov 2018 21:18:15 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41926 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbeK1CSP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Nov 2018 21:18:15 -0500
Received: by mail-ot1-f65.google.com with SMTP id u16so20419178otk.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Nov 2018 07:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Pm6Z4U1oXx4kdkiBIYuvqQrWfEUi4qM69CamUz09rkM=;
        b=TYIqEb3UWlB9bEV2xIMOK3j7i4rqWi9Qc79oKZ0ILskPRCAdNb/B1jvfV3Lh+IxE7p
         y2ar4LFUap/YJt2Ng8c5+Ln0MwKS2D/R/zVAQuqBUq5Yf//9W5HXuxI0wJOamDVkt5AM
         Yr4GgctZYxf7VapFEJKTayy2amYWE54MzGDbgdDyZu9VZtnMfyfAevvBZaTN5F6GxSp4
         RU+3MlwfniPEzoEoHvG3BLtZu9pZhwGt8gnvBVdxGv7+ohTYOykRXqCOPC+xkQ2n3k6p
         sgsslFtvyDKYEBqCorhGlC1fL6EzBtlFAfcp2GipigqkzN9erAFfE9r9HSfV/H4CGgXQ
         Rg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Pm6Z4U1oXx4kdkiBIYuvqQrWfEUi4qM69CamUz09rkM=;
        b=LWxEUHEOwZwF2gTzY9sQweskmRrsuRnYD1Vq1Bd/bCi8daWPf5DhLZsPg6Iqg5xQg3
         eJzqJ84YHZ9AEw/LumuLvbzzkXVY1GwsQr0EvJMMKmtAu6TdOBXDgC+VJNdI7n/DktJn
         vft4lQr0ORZ8RYypCvSRrDV8FnF8/9gfobS8phfeiVTL9n1P4In2I8vLcN7OE15cbPj6
         FbM05TkP++rmBKLSz/cDQ0C3YSKelQRdIuHw66h0mMuYby5kBsdfbFRN2uCqFipY5mbE
         l/3KqBMXQRS5ykOakoQiMELJ/WWCkcJJgRgwj0yi7PnFNFO8cHY1X6dHrSOjvl0ubYVc
         uCEg==
X-Gm-Message-State: AA+aEWaGZdM7A1zvT8XWe5xgnwT2PLVdaJQ66nXVwQFTmeNIvha128Qo
        ipu0HGxlBbbgC7yoUf+PFJsW93kmbFQbbZ1mg1tDICOn
X-Google-Smtp-Source: AFSGD/UF8oibiJLbMQW70abNnKCjVdQEZNhqUUrhS/fWHxExlHx/pnSq8fn/EM7zevzNqX9w1Sza3JejnFnymDH8SNw=
X-Received: by 2002:a9d:4c01:: with SMTP id l1mr18727396otf.242.1543331999708;
 Tue, 27 Nov 2018 07:19:59 -0800 (PST)
MIME-Version: 1.0
References: <20181126162438.27872-1-luiz.dentz@gmail.com> <27978B59-0DF8-42D9-90F6-086FF3FFA386@holtmann.org>
 <CABBYNZJ8zNu6Ub1Zo4ms0nX8CfgWjnXfR5d_My77VsC2q5Z1_g@mail.gmail.com> <1663DCEA-9B2E-4B2E-BE32-568A7D6CDA3E@holtmann.org>
In-Reply-To: <1663DCEA-9B2E-4B2E-BE32-568A7D6CDA3E@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 27 Nov 2018 17:19:47 +0200
Message-ID: <CABBYNZLfh2T3rUmoXyHkoxn-M4nm3uvS78wcRQdjM8j0d-Tktg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/6] share/mainloop: Add handling of NOTIFY_SOCKET
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Tue, Nov 27, 2018 at 3:30 PM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Luiz,
>
> >>> This adds handling of systemd NOTIFY_SOCKET so application using
> >>> mainloop instance do properly notify systemd what is their state.
> >>> ---
> >>> Makefile.am                  |   8 ++-
> >>> src/shared/mainloop-glib.c   |   8 +++
> >>> src/shared/mainloop-notify.c | 104 ++++++++++++++++++++++++++++++++++=
+
> >>> src/shared/mainloop-notify.h |  25 +++++++++
> >>> src/shared/mainloop.c        |  12 ++++
> >>> src/shared/mainloop.h        |   1 +
> >>> 6 files changed, 156 insertions(+), 2 deletions(-)
> >>> create mode 100644 src/shared/mainloop-notify.c
> >>> create mode 100644 src/shared/mainloop-notify.h
> >>>
> >>> diff --git a/Makefile.am b/Makefile.am
> >>> index 0b26ccc3e..124c32482 100644
> >>> --- a/Makefile.am
> >>> +++ b/Makefile.am
> >>> @@ -130,12 +130,16 @@ endif
> >>> src_libshared_glib_la_SOURCES =3D $(shared_sources) \
> >>>                              src/shared/io-glib.c \
> >>>                              src/shared/timeout-glib.c \
> >>> -                             src/shared/mainloop-glib.c
> >>> +                             src/shared/mainloop-glib.c \
> >>> +                             src/shared/mainloop-notify.h \
> >>> +                             src/shared/mainloop-notify.c
> >>>
> >>> src_libshared_mainloop_la_SOURCES =3D $(shared_sources) \
> >>>                              src/shared/io-mainloop.c \
> >>>                              src/shared/timeout-mainloop.c \
> >>> -                             src/shared/mainloop.h src/shared/mainlo=
op.c
> >>> +                             src/shared/mainloop.h src/shared/mainlo=
op.c \
> >>> +                             src/shared/mainloop-notify.h \
> >>> +                             src/shared/mainloop-notify.c
> >>>
> >>> if ELL
> >>> src_libshared_ell_la_SOURCES =3D $(shared_sources) \
> >>> diff --git a/src/shared/mainloop-glib.c b/src/shared/mainloop-glib.c
> >>> index 8436969bb..9d588e8c5 100644
> >>> --- a/src/shared/mainloop-glib.c
> >>> +++ b/src/shared/mainloop-glib.c
> >>> @@ -36,6 +36,7 @@
> >>> #include <glib.h>
> >>>
> >>> #include "mainloop.h"
> >>> +#include "mainloop-notify.h"
> >>>
> >>> static GMainLoop *main_loop;
> >>> static int exit_status;
> >>> @@ -43,6 +44,7 @@ static int exit_status;
> >>> void mainloop_init(void)
> >>> {
> >>>      main_loop =3D g_main_loop_new(NULL, FALSE);
> >>> +     mainloop_notify_init();
> >>> }
> >>>
> >>> void mainloop_quit(void)
> >>> @@ -70,11 +72,17 @@ int mainloop_run(void)
> >>>      if (!main_loop)
> >>>              return -EINVAL;
> >>>
> >>> +     mainloop_notify("READY=3D1");
> >>> +
> >>>      g_main_loop_run(main_loop);
> >>>
> >>> +     mainloop_notify("STOPPING=3D1");
> >>> +
> >>
> >> I actually think this is too simple. Frankly what we want is some gene=
ric code that runs the mainloops and handles the terminations signals and a=
lso brings you onto D-Bus. And only then signal READY=3D1.
> >
> > That was the intention, though things like btmon-logger does not need
> > to be on D-Bus beside mainloop_run is normally called after D-Bus
> > setup since we want to confirm we can claim the name.
>
> I think it is fine to have a version that does not connect to D-Bus, but =
the name claiming in case of D-Bus based application needs to be handled co=
rrectly as well. The background is that we want to start other activities l=
ike connecting to mgmt socket etc. only _after_ we successfully claimed the=
 name. Claiming the name is an asynchronous operation (at least in ELL D-Bu=
s) so the mainloop needs to be running.

As I said Im fine not triggering the READY=3D1 directly at mainloop_run,
the name claim is done blocking in gdbus/libdbus but Id understand
this may change once we switch over to ELL.

> >> If you look at iwd and wired/dbus.c then I have started something in t=
hat direction with dbus_app_run. That needs to be a bit more unified and tu=
rned into l_dbus_run or some similar name.
> >
> > Right, Im not sure if that applies to our internal g_dbus though but
> > for meshd it definitely makes sense.
>
> Our internal gdbus is something that needs to move towards ELL D-Bus real=
ly quickly. We have to remove the dependency on libdbus even if we keep gdb=
us API in place for a while.
>
> >> My thinking really is that the main() function should be just deal wit=
h argument parsing and then getting you on the system or session bus. It sh=
ould not be bothered with all the signal setup or the duplicated code for h=
andling the asynchronous shutdown. And if you have that, then you do a nice=
 integration with NOTIFY_SOCKET.
> >
> > I just wanted to tackle READY=3D1 and STOPPING=3D1 when the mainloop st=
art
> > and stop respectively, those I think make sense regardless of what
> > type of service (D-Bus daemon, btproxy, btattach, etc) but perhaps you
> > are saying that those things may actually need to be notified in
> > different places depending on the service.
> >
> > For READY=3D1 I can see the point if the service does require do to
> > something asynchronous before it is considered ready, bluetoothd
> > currently don't require that but maybe in ell we are doing something
> > different, for STOPPING=3D1 that only indicates we are starting to
> > shutdown so that doesn't rule out doing it asynchronously:
> >
> > https://www.freedesktop.org/software/systemd/man/sd_notify.html
> >
> > STATUS=3D is free format and given the example I was assuming if would
> > notify things asynchronously if we have to, thus why I created
> > mainloop_notify, perhaps we should rename it to
> > mainloop_notify_status?
> >
> > Watchdog I guess it is pretty safe to do the handling along with the
> > mainloop since timeout handling is already done there anyway, anyway
> > notifying READY or STOPPING multiple times probably don't make any
> > sense, they cannot be undone, we could perhaps have a flag indicating
> > if the mainloop shall handle those, maybe via an option like
> > -s/--service=3D[ready, stopping, watchdog] passed to mainloop_init(int
> > argc, char *argv[]) that way the user can inform that he wants to run
> > the tool as a service and optionally include what states it should
> > control (by default it would be all).
>
> The watchdog needs to be done within the mainloop since you have to have =
timeout handling active.
>
> We can argue about if certain things are useful as a short term quick sol=
ution, but in the end we want a proper solution and not just hack it into t=
he codebase. I rather have no systemd integration than a half-baked one.

Well Im trying to agree here on the API so we can have it similar in
ELL thus making the transition a bit simpler, I was already intending
to switch everything to mainloop abstraction, since I suppose the
problem with ELL is not exactly the API but the dependency which may
not be available in many distros. Some people already experience this
on the likes of rpi when attempting to use meshd, though we hope that
makes distro guys attempt to create packages for it once we have the
D-Bus APIs implemented.

> Regards
>
> Marcel
>


--=20
Luiz Augusto von Dentz
