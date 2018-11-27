Return-Path: <SRS0=erFC=OG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABA8C43441
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Nov 2018 13:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F4C208E4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Nov 2018 13:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3F4C208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbeK1A2u convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Nov 2018 19:28:50 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:36666 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeK1A2u (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Nov 2018 19:28:50 -0500
Received: from marcel-macbook.fritz.box (p4FEFC449.dip0.t-ipconnect.de [79.239.196.73])
        by mail.holtmann.org (Postfix) with ESMTPSA id 49AF1CEF8D;
        Tue, 27 Nov 2018 14:38:26 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH BlueZ 1/6] share/mainloop: Add handling of NOTIFY_SOCKET
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZJ8zNu6Ub1Zo4ms0nX8CfgWjnXfR5d_My77VsC2q5Z1_g@mail.gmail.com>
Date:   Tue, 27 Nov 2018 14:30:52 +0100
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <1663DCEA-9B2E-4B2E-BE32-568A7D6CDA3E@holtmann.org>
References: <20181126162438.27872-1-luiz.dentz@gmail.com>
 <27978B59-0DF8-42D9-90F6-086FF3FFA386@holtmann.org>
 <CABBYNZJ8zNu6Ub1Zo4ms0nX8CfgWjnXfR5d_My77VsC2q5Z1_g@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>>> This adds handling of systemd NOTIFY_SOCKET so application using
>>> mainloop instance do properly notify systemd what is their state.
>>> ---
>>> Makefile.am                  |   8 ++-
>>> src/shared/mainloop-glib.c   |   8 +++
>>> src/shared/mainloop-notify.c | 104 +++++++++++++++++++++++++++++++++++
>>> src/shared/mainloop-notify.h |  25 +++++++++
>>> src/shared/mainloop.c        |  12 ++++
>>> src/shared/mainloop.h        |   1 +
>>> 6 files changed, 156 insertions(+), 2 deletions(-)
>>> create mode 100644 src/shared/mainloop-notify.c
>>> create mode 100644 src/shared/mainloop-notify.h
>>> 
>>> diff --git a/Makefile.am b/Makefile.am
>>> index 0b26ccc3e..124c32482 100644
>>> --- a/Makefile.am
>>> +++ b/Makefile.am
>>> @@ -130,12 +130,16 @@ endif
>>> src_libshared_glib_la_SOURCES = $(shared_sources) \
>>>                              src/shared/io-glib.c \
>>>                              src/shared/timeout-glib.c \
>>> -                             src/shared/mainloop-glib.c
>>> +                             src/shared/mainloop-glib.c \
>>> +                             src/shared/mainloop-notify.h \
>>> +                             src/shared/mainloop-notify.c
>>> 
>>> src_libshared_mainloop_la_SOURCES = $(shared_sources) \
>>>                              src/shared/io-mainloop.c \
>>>                              src/shared/timeout-mainloop.c \
>>> -                             src/shared/mainloop.h src/shared/mainloop.c
>>> +                             src/shared/mainloop.h src/shared/mainloop.c \
>>> +                             src/shared/mainloop-notify.h \
>>> +                             src/shared/mainloop-notify.c
>>> 
>>> if ELL
>>> src_libshared_ell_la_SOURCES = $(shared_sources) \
>>> diff --git a/src/shared/mainloop-glib.c b/src/shared/mainloop-glib.c
>>> index 8436969bb..9d588e8c5 100644
>>> --- a/src/shared/mainloop-glib.c
>>> +++ b/src/shared/mainloop-glib.c
>>> @@ -36,6 +36,7 @@
>>> #include <glib.h>
>>> 
>>> #include "mainloop.h"
>>> +#include "mainloop-notify.h"
>>> 
>>> static GMainLoop *main_loop;
>>> static int exit_status;
>>> @@ -43,6 +44,7 @@ static int exit_status;
>>> void mainloop_init(void)
>>> {
>>>      main_loop = g_main_loop_new(NULL, FALSE);
>>> +     mainloop_notify_init();
>>> }
>>> 
>>> void mainloop_quit(void)
>>> @@ -70,11 +72,17 @@ int mainloop_run(void)
>>>      if (!main_loop)
>>>              return -EINVAL;
>>> 
>>> +     mainloop_notify("READY=1");
>>> +
>>>      g_main_loop_run(main_loop);
>>> 
>>> +     mainloop_notify("STOPPING=1");
>>> +
>> 
>> I actually think this is too simple. Frankly what we want is some generic code that runs the mainloops and handles the terminations signals and also brings you onto D-Bus. And only then signal READY=1.
> 
> That was the intention, though things like btmon-logger does not need
> to be on D-Bus beside mainloop_run is normally called after D-Bus
> setup since we want to confirm we can claim the name.

I think it is fine to have a version that does not connect to D-Bus, but the name claiming in case of D-Bus based application needs to be handled correctly as well. The background is that we want to start other activities like connecting to mgmt socket etc. only _after_ we successfully claimed the name. Claiming the name is an asynchronous operation (at least in ELL D-Bus) so the mainloop needs to be running.

>> If you look at iwd and wired/dbus.c then I have started something in that direction with dbus_app_run. That needs to be a bit more unified and turned into l_dbus_run or some similar name.
> 
> Right, Im not sure if that applies to our internal g_dbus though but
> for meshd it definitely makes sense.

Our internal gdbus is something that needs to move towards ELL D-Bus really quickly. We have to remove the dependency on libdbus even if we keep gdbus API in place for a while.

>> My thinking really is that the main() function should be just deal with argument parsing and then getting you on the system or session bus. It should not be bothered with all the signal setup or the duplicated code for handling the asynchronous shutdown. And if you have that, then you do a nice integration with NOTIFY_SOCKET.
> 
> I just wanted to tackle READY=1 and STOPPING=1 when the mainloop start
> and stop respectively, those I think make sense regardless of what
> type of service (D-Bus daemon, btproxy, btattach, etc) but perhaps you
> are saying that those things may actually need to be notified in
> different places depending on the service.
> 
> For READY=1 I can see the point if the service does require do to
> something asynchronous before it is considered ready, bluetoothd
> currently don't require that but maybe in ell we are doing something
> different, for STOPPING=1 that only indicates we are starting to
> shutdown so that doesn't rule out doing it asynchronously:
> 
> https://www.freedesktop.org/software/systemd/man/sd_notify.html
> 
> STATUS= is free format and given the example I was assuming if would
> notify things asynchronously if we have to, thus why I created
> mainloop_notify, perhaps we should rename it to
> mainloop_notify_status?
> 
> Watchdog I guess it is pretty safe to do the handling along with the
> mainloop since timeout handling is already done there anyway, anyway
> notifying READY or STOPPING multiple times probably don't make any
> sense, they cannot be undone, we could perhaps have a flag indicating
> if the mainloop shall handle those, maybe via an option like
> -s/--service=[ready, stopping, watchdog] passed to mainloop_init(int
> argc, char *argv[]) that way the user can inform that he wants to run
> the tool as a service and optionally include what states it should
> control (by default it would be all).

The watchdog needs to be done within the mainloop since you have to have timeout handling active.

We can argue about if certain things are useful as a short term quick solution, but in the end we want a proper solution and not just hack it into the codebase. I rather have no systemd integration than a half-baked one.

Regards

Marcel

