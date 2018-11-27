Return-Path: <SRS0=erFC=OG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC870C43441
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Nov 2018 09:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A898208E7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Nov 2018 09:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYB4nTpZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A898208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbeK0Usl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:48:41 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34836 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730237AbeK0Usl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Nov 2018 15:48:41 -0500
Received: by mail-ot1-f68.google.com with SMTP id 81so19555606otj.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Nov 2018 01:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jrJV6qfVwsr46CxM9T7CftNBPTFdTWwh7dDal6r5ezI=;
        b=RYB4nTpZ+MG2AinPI/JNntL53VuBFL5KOMr8+0y3i33kfEmKPIO1XlJxdpB+ScuSh1
         349q9zQnzlYT1UYYIshjuToxYQOHMW81dEkPsJwzPcl8FDADZbJJIQzUq9+eosYDmdLa
         eJKQ2ilT/k2Ub6tJjPp+EWFnl4j6jiSGRCQK5otoudeAMHdUIYcpXspl+mPkZl/RywB6
         aZA/4URtRQZjuQ5sz26N+zykTW00A2qbzx5XRejK88xuBs3DJ1oYCnQHILmqCbo2NyON
         5mE7xockonB4ksv7Sb8h/WaQKhOJ6NXxda+hrjBv+UdIPDZWNLHEhkut3XfGsYBFUL+U
         fLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jrJV6qfVwsr46CxM9T7CftNBPTFdTWwh7dDal6r5ezI=;
        b=gd/0bSXyWCOuhqFborc5AwWwvOWSMxdEcwEyHRe2WYBjXNaSZjuXuIsl+ehymn+Qd2
         zE0CvBvYQsraRswB08IMtht4PdIocfvNhSGB/rQMzhCmZ0l3Ws5NJ7chm6OZmGzcJx0N
         wvzeZsLWFM5O/XoZjQ4EBiXpnWeSugwHQnkDe44j1YuDP0CD+HWjh88wF+6AN6l992OZ
         7+JHmnhz1E69nO6eAa/Ewy8FlN8ty7pTvQ6QbZhOjrhUHhxUvwlXPrnmqTrcdBj1gCxd
         HRTyXI4D5aj66qzLWRgSx88ZuASMZOMWdW3a0/9/DFOrX1xEZkfnll/RMyQpWAEc2UER
         9pkA==
X-Gm-Message-State: AA+aEWY7oQ54C+EJr+HKObOUnkmic4qHXvhHmLLjA85Ur3iJ5s0w+tWR
        MAVlKU7Ca9pLE3x8jVVmP/g+MZriC63mheBpo3VDm8le7Mg=
X-Google-Smtp-Source: AFSGD/Vrg63xfHHN5D7rSTRJA3BUyxYWIv3FbONTqb0crve+OCvbv+aOMlm73TeB6UOFANkbZWB1bpHC2iMMTwh5zj4=
X-Received: by 2002:a9d:18f:: with SMTP id e15mr15021568ote.84.1543312279630;
 Tue, 27 Nov 2018 01:51:19 -0800 (PST)
MIME-Version: 1.0
References: <20181126162438.27872-1-luiz.dentz@gmail.com> <27978B59-0DF8-42D9-90F6-086FF3FFA386@holtmann.org>
In-Reply-To: <27978B59-0DF8-42D9-90F6-086FF3FFA386@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 27 Nov 2018 11:51:07 +0200
Message-ID: <CABBYNZJ8zNu6Ub1Zo4ms0nX8CfgWjnXfR5d_My77VsC2q5Z1_g@mail.gmail.com>
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
On Mon, Nov 26, 2018 at 7:55 PM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Luiz,
>
> > This adds handling of systemd NOTIFY_SOCKET so application using
> > mainloop instance do properly notify systemd what is their state.
> > ---
> > Makefile.am                  |   8 ++-
> > src/shared/mainloop-glib.c   |   8 +++
> > src/shared/mainloop-notify.c | 104 +++++++++++++++++++++++++++++++++++
> > src/shared/mainloop-notify.h |  25 +++++++++
> > src/shared/mainloop.c        |  12 ++++
> > src/shared/mainloop.h        |   1 +
> > 6 files changed, 156 insertions(+), 2 deletions(-)
> > create mode 100644 src/shared/mainloop-notify.c
> > create mode 100644 src/shared/mainloop-notify.h
> >
> > diff --git a/Makefile.am b/Makefile.am
> > index 0b26ccc3e..124c32482 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -130,12 +130,16 @@ endif
> > src_libshared_glib_la_SOURCES =3D $(shared_sources) \
> >                               src/shared/io-glib.c \
> >                               src/shared/timeout-glib.c \
> > -                             src/shared/mainloop-glib.c
> > +                             src/shared/mainloop-glib.c \
> > +                             src/shared/mainloop-notify.h \
> > +                             src/shared/mainloop-notify.c
> >
> > src_libshared_mainloop_la_SOURCES =3D $(shared_sources) \
> >                               src/shared/io-mainloop.c \
> >                               src/shared/timeout-mainloop.c \
> > -                             src/shared/mainloop.h src/shared/mainloop=
.c
> > +                             src/shared/mainloop.h src/shared/mainloop=
.c \
> > +                             src/shared/mainloop-notify.h \
> > +                             src/shared/mainloop-notify.c
> >
> > if ELL
> > src_libshared_ell_la_SOURCES =3D $(shared_sources) \
> > diff --git a/src/shared/mainloop-glib.c b/src/shared/mainloop-glib.c
> > index 8436969bb..9d588e8c5 100644
> > --- a/src/shared/mainloop-glib.c
> > +++ b/src/shared/mainloop-glib.c
> > @@ -36,6 +36,7 @@
> > #include <glib.h>
> >
> > #include "mainloop.h"
> > +#include "mainloop-notify.h"
> >
> > static GMainLoop *main_loop;
> > static int exit_status;
> > @@ -43,6 +44,7 @@ static int exit_status;
> > void mainloop_init(void)
> > {
> >       main_loop =3D g_main_loop_new(NULL, FALSE);
> > +     mainloop_notify_init();
> > }
> >
> > void mainloop_quit(void)
> > @@ -70,11 +72,17 @@ int mainloop_run(void)
> >       if (!main_loop)
> >               return -EINVAL;
> >
> > +     mainloop_notify("READY=3D1");
> > +
> >       g_main_loop_run(main_loop);
> >
> > +     mainloop_notify("STOPPING=3D1");
> > +
>
> I actually think this is too simple. Frankly what we want is some generic=
 code that runs the mainloops and handles the terminations signals and also=
 brings you onto D-Bus. And only then signal READY=3D1.

That was the intention, though things like btmon-logger does not need
to be on D-Bus beside mainloop_run is normally called after D-Bus
setup since we want to confirm we can claim the name.

> If you look at iwd and wired/dbus.c then I have started something in that=
 direction with dbus_app_run. That needs to be a bit more unified and turne=
d into l_dbus_run or some similar name.

Right, Im not sure if that applies to our internal g_dbus though but
for meshd it definitely makes sense.

> My thinking really is that the main() function should be just deal with a=
rgument parsing and then getting you on the system or session bus. It shoul=
d not be bothered with all the signal setup or the duplicated code for hand=
ling the asynchronous shutdown. And if you have that, then you do a nice in=
tegration with NOTIFY_SOCKET.

I just wanted to tackle READY=3D1 and STOPPING=3D1 when the mainloop start
and stop respectively, those I think make sense regardless of what
type of service (D-Bus daemon, btproxy, btattach, etc) but perhaps you
are saying that those things may actually need to be notified in
different places depending on the service.

For READY=3D1 I can see the point if the service does require do to
something asynchronous before it is considered ready, bluetoothd
currently don't require that but maybe in ell we are doing something
different, for STOPPING=3D1 that only indicates we are starting to
shutdown so that doesn't rule out doing it asynchronously:

https://www.freedesktop.org/software/systemd/man/sd_notify.html

STATUS=3D is free format and given the example I was assuming if would
notify things asynchronously if we have to, thus why I created
mainloop_notify, perhaps we should rename it to
mainloop_notify_status?

Watchdog I guess it is pretty safe to do the handling along with the
mainloop since timeout handling is already done there anyway, anyway
notifying READY or STOPPING multiple times probably don't make any
sense, they cannot be undone, we could perhaps have a flag indicating
if the mainloop shall handle those, maybe via an option like
-s/--service=3D[ready, stopping, watchdog] passed to mainloop_init(int
argc, char *argv[]) that way the user can inform that he wants to run
the tool as a service and optionally include what states it should
control (by default it would be all).

> Regards
>
> Marcel
>


--=20
Luiz Augusto von Dentz
