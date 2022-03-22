Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7C8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Mar 2022 21:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbiCVVgx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Mar 2022 17:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235678AbiCVVgw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Mar 2022 17:36:52 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57F2238
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 14:35:23 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id j2so36179868ybu.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 14:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Ql1UW7kb+dY7XxMygQ/ftVXYkoUpGIDtsnaZmElvcs=;
        b=G/HoWEXnGQXEtf2yKNtEnsXWg5R6NcckddVQlavJk03JI53mzDbEfCw7Jy6mbBY0kE
         8slO03n5IyG/88V9eP2QrD9pdEwwM6eeQFxioXfEiP61YimxPYtNpy6dF/rlrhNMKGxw
         vjqZeYWdYJ0Q83zkrJGmoCTN1M3IBDVveB1a/doaSd46+bsnhZS7FDrCraSlNHeW9e4I
         dP2x3ia4Hm91mBZXEtB5pjEIXJWZ4EyusQwUxIcNTbvM24rtGfz+4cKjYZE/B3o8UrCh
         qWiXN9HWZ6YZWYryLtm7GbMRpn4QN8XCg3hnXQNBqwx61dg8vW/Doglfxltw+Qr0JQNo
         pfpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Ql1UW7kb+dY7XxMygQ/ftVXYkoUpGIDtsnaZmElvcs=;
        b=o1MKoMUGSquMRZBsTRhkWLwsx8Z2B/533Da/6cBtUYhOaypIQpOh1AIvQMiRPGWD8f
         ErLTDUlG9qWRiC4Csyo4ubh4JWUp/Xx0VXZctk+WIncEGKqT+wAPMQxO0EKYbeae6nis
         4MTuGQ+twFIpXChXok+773I3/siE8RTYERtCS77sjCvgFiIKYwwKolr5MQbSr8our/S1
         8M+aqCVqcU15nc9lcznB8W39KZNfT7AryAbn/yDkRWAr92GCVclgpop9QDoTa9pp3nA8
         oB3sFvYt7azZOLk1rWw5zlpWlA2iyeff8iAsFWdRuU0+kuIPaJrJKK+grw6+EduvpmT7
         Nauw==
X-Gm-Message-State: AOAM532lWGP0IHDxuleXa+V+KuyhDcVmO076jwisy8NWDAwNIoci6ZCE
        wdyZw7eYBAaC5kVrMiBRJaf7hc2p3Ex4syFLWiqcUR2FMZE=
X-Google-Smtp-Source: ABdhPJxJXbAH93ThOpZPenbJvnZVk3v92z6qOzH7gwrwgsTm8OLXISAdWEUnjuwm4bcMi6Lk5CnBsg/Qi8SqclzieDs=
X-Received: by 2002:a25:9742:0:b0:61d:9526:ebc3 with SMTP id
 h2-20020a259742000000b0061d9526ebc3mr28600427ybo.578.1647984922795; Tue, 22
 Mar 2022 14:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <CANFkB1ydGuwKRjusy3U0HCQo8E88XbZTh_UdPZ8wujt7P5KKnQ@mail.gmail.com>
 <CABBYNZLjV3PQ7Hm3PJZcTcs64aLzWLBNfooSYuZmSywv0RJG0g@mail.gmail.com>
 <CANFkB1yr3N_Twac=ocxBRst79-gmdu8=6VTD6oPgdGT0rb_HaQ@mail.gmail.com> <CANFkB1xEesP1cMmK4VGi5cH-v80ho00wT24q=+4QQSdyPegPQQ@mail.gmail.com>
In-Reply-To: <CANFkB1xEesP1cMmK4VGi5cH-v80ho00wT24q=+4QQSdyPegPQQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 22 Mar 2022 14:35:11 -0700
Message-ID: <CABBYNZKSsyqfiWYjpuZNYtKAZb4C2q73YwOj=KoUFq71gLs7Hg@mail.gmail.com>
Subject: Re: GATT issue, possible bluez bug?
To:     Adam Pigg <adam@piggz.co.uk>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Adam,

On Tue, Mar 22, 2022 at 3:40 AM Adam Pigg <adam@piggz.co.uk> wrote:
>
> Hi Luiz
>
>
> On Tue, 22 Mar 2022 at 07:55, Adam Pigg <adam@piggz.co.uk> wrote:
> >
> > Hi Luiz
> >
> > On Tue, 22 Mar 2022 at 00:44, Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Adam,
> > >
> > > On Mon, Mar 21, 2022 at 4:03 PM Adam Pigg <adam@piggz.co.uk> wrote:
> > > >
> > > > Hi
> > > >
> > > > A bit of background, I write a linux desktop/mobile app called
> > > > Amazfish which interfaces with several watches over BLE using their
> > > > GATT services.  To do this, I use the bluez dbus api (technically a
> > > > thin wrapper around it I wrote called qble
> > > > https://github.com/piggz/qble)
> > > >
> > > > All has been good so far, I support several generations of
> > > > Huami/Amazfit watches, as well as the open source Pinetime and
> > > > Bangle.js.  For the Amazfit watches, i have implementations for older
> > > > devies such as the Bip, and newer ones such as the GTS.
> > > >
> > > > Much of the reverse engineering comes from the Android Gadget Bridge
> > > > project, which supports many more devices.
> > > >
> > > > My community of users donated to buy me a newer device called a GTR2,
> > > > which, according to the GB devs uses the same protocol as the slightly
> > > > older GTS, and the packet captures I have from Android would support
> > > > this.
> > > >
> > > > But this is where my trouble starts with Bluez, my existing
> > > > implementation doesnt work at all.  Normally, after a connection, I
> > > > would wait for the ServicesResolved signal, which happens pretty fast
> > > > on all other devices, but on the GTR2, it takes about 30 seconds, by
> > > > which time, the watch has disconnected. (i get a disconnected signal
> > > > immediately after the ServicesResolved signal)
> > > >
> > > > To rule out my code, I have tried several things:
> > > > Gatttool
> > > > With gattool, i can connect, get the services, enable a notification,
> > > > write a value and get the expected results seemingly fine
> > > >
> > > > Python-gatt (using the bluez dbus api)
> > > > Im unable to iterate the services, like my app, it takes 30 seconds to
> > > > get the signal and then swiftly disconnects
> > > >
> > > > Gattlib (https://github.com/labapart/gattlib)
> > > > Gattlib is interesting as it appears to have "borrowed" much of its
> > > > code directly from bluez.  When built against the system bluez, if the
> > > > version is > 5.42, it will use the dbus api.  When I do this, again im
> > > > unable to list services on the watch.  However, if I edit the build to
> > > > force it to use its internal gatt implementation, which appears to be
> > > > the same one used by gatttool, then, it IS able to interrogate the
> > > > watch.
> > > >
> > > > I have attached 3 files
> > > > 1. test python program which should print services, and associated btmon
> > > > 2. btmon output while using gatttool
> > > > 3. btmon output running gattlib discover example
> > > >
> > > > Note, other than discovery, I havnt been able to get gattlib to
> > > > read/write/notify!
> > > >
> > > > It seems as though I may be triggering a bug in the bluez dbus api?
> > > > Can anyone suggest anything?
> > >
> > > What version are you using? I would first try with the latest to see
> > > if that something already fixed.
> > >
> > >
> > Im using 5.63 already, which is the latest tag (on opensuse tumbleweed)
> >
> > I'll also try bluetoothctl and attach logs using that, though I
> > suspect it will behave the same as the python library and my own
> > library.
> >
>
> Attached is the output of btmon while using bluetoothctl
>
> bluetoothctl behaves the same as my lib and python, it is unable to
> list services, and after a while, emits the ServicesResolved and
> disconnected messages at the same time.  Im sure it should be able to
> list the services immediately after connect just like gatttool can.

Looks like there is multiple rounds of MTU Exchange, not sure if that
is actually a problem but the spec does say it shall only be sent once
per client:

BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 3, Part F
page 1424:

This request shall only be sent once during a connection by the client.

There is also no response to frame #30:
< ACL Data TX: Handle 3585 flags 0x00 dlen 7

                           #30 [hci0] 26.641557
      ATT: Read Request (0x0a) len 2
        Handle: 0x0018

So after 30 seconds (ATT timeout) without receiving any response it disconnects:

< HCI Command: Disconnect (0x01|0x0006) plen 3

                           #48 [hci0] 58.673128
        Handle: 3585
        Reason: Remote User Terminated Connection (0x13)

> Thanks
>
>
> > > --
> > > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
