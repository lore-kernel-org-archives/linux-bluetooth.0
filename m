Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C43AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Mar 2022 23:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238067AbiCVXLP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Mar 2022 19:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236936AbiCVXLO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Mar 2022 19:11:14 -0400
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248D95E77D
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 16:09:45 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id h7so14840378lfl.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 16:09:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E/Rq/UlZ2RgZtCtrcAdkuE1ZEngt/TO5p6WsxHVsyIo=;
        b=iROcWkJvH4bmAsqratJQ+0DmZKMfbPIIZCBuwViKBbPH+QYeUs2sfsK+zq2mRoNfzi
         qcPn7+l/sBVkZkol8wBm0T0jFqt0UKBD0gZdoAwhOnAiCbCcoJsWa6OVlUR+ZxF5ONaq
         3RigX0XVJJ3ly9oMT8mQeC7/Gox/c2OibmNneR8h4CBhgJ8BCwviJJtijU2Fkhu0YE4J
         gPteZB3LRsWYHKAsIAGThUuY2jFlPddGxKk4gTrj37rCrURUyUa8lO+s/mXYDzIdo5wL
         8ctW24HkWCPYOdtlZswLhrQi2hSQKPETN32TINjv4eGnbauIy3iNhdeyX1pFV2CbV157
         4aog==
X-Gm-Message-State: AOAM533JAs7gzGMXCZNIc4OoSPMbq1bibP3k8qGBFBEoVmq2BikEaE8h
        GLAGNV9OZePNXw3fLHt9C6vGjhkpJm7QAtBCY0mTPyGTOLsIK0FP
X-Google-Smtp-Source: ABdhPJwY8nStG/qi53Xc5hHvcktCVQTPuaLgFuZJQJMvLjUp3HzdDFWb2ZWFJawUaOErKwr9Ash1oSbDj8ELCTcp+Zw=
X-Received: by 2002:a05:6512:2011:b0:44a:247a:82ab with SMTP id
 a17-20020a056512201100b0044a247a82abmr10570899lfb.127.1647990583267; Tue, 22
 Mar 2022 16:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <CANFkB1ydGuwKRjusy3U0HCQo8E88XbZTh_UdPZ8wujt7P5KKnQ@mail.gmail.com>
 <CABBYNZLjV3PQ7Hm3PJZcTcs64aLzWLBNfooSYuZmSywv0RJG0g@mail.gmail.com>
 <CANFkB1yr3N_Twac=ocxBRst79-gmdu8=6VTD6oPgdGT0rb_HaQ@mail.gmail.com>
 <CANFkB1xEesP1cMmK4VGi5cH-v80ho00wT24q=+4QQSdyPegPQQ@mail.gmail.com> <CABBYNZKSsyqfiWYjpuZNYtKAZb4C2q73YwOj=KoUFq71gLs7Hg@mail.gmail.com>
In-Reply-To: <CABBYNZKSsyqfiWYjpuZNYtKAZb4C2q73YwOj=KoUFq71gLs7Hg@mail.gmail.com>
From:   Adam Pigg <adam@piggz.co.uk>
Date:   Tue, 22 Mar 2022 23:09:31 +0000
Message-ID: <CANFkB1zHTZF3Mcgn5GPBA0km+BNyL3bb9=MJFuSNFe6x5zgimQ@mail.gmail.com>
Subject: Re: GATT issue, possible bluez bug?
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks Luiz

On Tue, 22 Mar 2022 at 21:35, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Adam,
>
> On Tue, Mar 22, 2022 at 3:40 AM Adam Pigg <adam@piggz.co.uk> wrote:
> >
> > Hi Luiz
> >
> >
> > On Tue, 22 Mar 2022 at 07:55, Adam Pigg <adam@piggz.co.uk> wrote:
> > >
> > > Hi Luiz
> > >
> > > On Tue, 22 Mar 2022 at 00:44, Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Adam,
> > > >
> > > > On Mon, Mar 21, 2022 at 4:03 PM Adam Pigg <adam@piggz.co.uk> wrote:
> > > > >
> > > > > Hi
> > > > >
> > > > > A bit of background, I write a linux desktop/mobile app called
> > > > > Amazfish which interfaces with several watches over BLE using their
> > > > > GATT services.  To do this, I use the bluez dbus api (technically a
> > > > > thin wrapper around it I wrote called qble
> > > > > https://github.com/piggz/qble)
> > > > >
> > > > > All has been good so far, I support several generations of
> > > > > Huami/Amazfit watches, as well as the open source Pinetime and
> > > > > Bangle.js.  For the Amazfit watches, i have implementations for older
> > > > > devies such as the Bip, and newer ones such as the GTS.
> > > > >
> > > > > Much of the reverse engineering comes from the Android Gadget Bridge
> > > > > project, which supports many more devices.
> > > > >
> > > > > My community of users donated to buy me a newer device called a GTR2,
> > > > > which, according to the GB devs uses the same protocol as the slightly
> > > > > older GTS, and the packet captures I have from Android would support
> > > > > this.
> > > > >
> > > > > But this is where my trouble starts with Bluez, my existing
> > > > > implementation doesnt work at all.  Normally, after a connection, I
> > > > > would wait for the ServicesResolved signal, which happens pretty fast
> > > > > on all other devices, but on the GTR2, it takes about 30 seconds, by
> > > > > which time, the watch has disconnected. (i get a disconnected signal
> > > > > immediately after the ServicesResolved signal)
> > > > >
> > > > > To rule out my code, I have tried several things:
> > > > > Gatttool
> > > > > With gattool, i can connect, get the services, enable a notification,
> > > > > write a value and get the expected results seemingly fine
> > > > >
> > > > > Python-gatt (using the bluez dbus api)
> > > > > Im unable to iterate the services, like my app, it takes 30 seconds to
> > > > > get the signal and then swiftly disconnects
> > > > >
> > > > > Gattlib (https://github.com/labapart/gattlib)
> > > > > Gattlib is interesting as it appears to have "borrowed" much of its
> > > > > code directly from bluez.  When built against the system bluez, if the
> > > > > version is > 5.42, it will use the dbus api.  When I do this, again im
> > > > > unable to list services on the watch.  However, if I edit the build to
> > > > > force it to use its internal gatt implementation, which appears to be
> > > > > the same one used by gatttool, then, it IS able to interrogate the
> > > > > watch.
> > > > >
> > > > > I have attached 3 files
> > > > > 1. test python program which should print services, and associated btmon
> > > > > 2. btmon output while using gatttool
> > > > > 3. btmon output running gattlib discover example
> > > > >
> > > > > Note, other than discovery, I havnt been able to get gattlib to
> > > > > read/write/notify!
> > > > >
> > > > > It seems as though I may be triggering a bug in the bluez dbus api?
> > > > > Can anyone suggest anything?
> > > >
> > > > What version are you using? I would first try with the latest to see
> > > > if that something already fixed.
> > > >
> > > >
> > > Im using 5.63 already, which is the latest tag (on opensuse tumbleweed)
> > >
> > > I'll also try bluetoothctl and attach logs using that, though I
> > > suspect it will behave the same as the python library and my own
> > > library.
> > >
> >
> > Attached is the output of btmon while using bluetoothctl
> >
> > bluetoothctl behaves the same as my lib and python, it is unable to
> > list services, and after a while, emits the ServicesResolved and
> > disconnected messages at the same time.  Im sure it should be able to
> > list the services immediately after connect just like gatttool can.
>
> Looks like there is multiple rounds of MTU Exchange, not sure if that
> is actually a problem but the spec does say it shall only be sent once
> per client:
>
> BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 3, Part F
> page 1424:
>
> This request shall only be sent once during a connection by the client.
>
> There is also no response to frame #30:
> < ACL Data TX: Handle 3585 flags 0x00 dlen 7
>
>                            #30 [hci0] 26.641557
>       ATT: Read Request (0x0a) len 2
>         Handle: 0x0018
>
> So after 30 seconds (ATT timeout) without receiving any response it disconnects:
>

So, the verdict is that the watch isnt acting to spec right?

Why does gatttool work ok, is it a completely different implementation?

I understand if wouldnt be to spec, but would it be possible to make
bluez more resilient to devices not acting to spec?  Android and iOS
work just fine in this regard, so could bluez handle mis-behaving
devices more flexibly?

Do you have any suggestions for things I could try? I looked for
similar lines in the working gatttool log, and it doesnt have anything
like that, seems to send flags 0x00 dlen 9 (instead of 7?)  ... how is
it behaving differently?


> < HCI Command: Disconnect (0x01|0x0006) plen 3
>
>                            #48 [hci0] 58.673128
>         Handle: 3585
>         Reason: Remote User Terminated Connection (0x13)
>
> > Thanks
> >
> >
> > > > --
> > > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
