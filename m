Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336A0C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Mar 2022 07:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiCVH5d (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Mar 2022 03:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiCVH5c (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Mar 2022 03:57:32 -0400
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011CB5A08E
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 00:56:02 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id bn33so22872157ljb.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 00:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C1We4UvL4QPwmGDLrWjVNOB5JOzUc+sQhEdjrrL1tto=;
        b=UduC406sTPHRqfV+CfJWRn3/a+wVqk5rlx4kAQa2Ecy8XAeQ/2DqUvMv3sMbv63TFL
         Yf+CItIJXSurRpFqB3zrarqe4/E09frMVkcn7h2dWxeYUlKZGBEBiABEpth0J7FQvIv9
         HQooIUEY9HXBy3amRjeTxU8H/LrTrCYiyuCrlywFIFP6w9OMKzahY3+xXzRLwqCbFi9O
         8pPAtMoaLObKF19Iy4E7kT57WjqK4jDOZFNgSjo/L2QNy48HTX24H2fHkKmtrWruql74
         qDAL8/EoC8MBMixaUp6C7FKTIfRhTpHcI06U51irjG22soaptSlaIYPIDWfZEZwHZ1Ng
         N+Jw==
X-Gm-Message-State: AOAM5314Bh8aCz7APEavGUtvjtUHoxDGRFf2/NL/KncbXiDPfrtO/v+G
        /5Q/dwo0tkHD2VfYe0iLbzjPfjZ/uWc83Zd0iwx6J6wO8uk=
X-Google-Smtp-Source: ABdhPJySuShuNwf50FFycHEaDcFuRR7qMFgNJsfMH4fWjflBBkWoiIJ8t48dPrb1p2NXQEzVj9mXHgcIDnjZcEdnrH0=
X-Received: by 2002:a2e:8496:0:b0:249:7dbc:d81b with SMTP id
 b22-20020a2e8496000000b002497dbcd81bmr9221240ljh.332.1647935760248; Tue, 22
 Mar 2022 00:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <CANFkB1ydGuwKRjusy3U0HCQo8E88XbZTh_UdPZ8wujt7P5KKnQ@mail.gmail.com>
 <CABBYNZLjV3PQ7Hm3PJZcTcs64aLzWLBNfooSYuZmSywv0RJG0g@mail.gmail.com>
In-Reply-To: <CABBYNZLjV3PQ7Hm3PJZcTcs64aLzWLBNfooSYuZmSywv0RJG0g@mail.gmail.com>
From:   Adam Pigg <adam@piggz.co.uk>
Date:   Tue, 22 Mar 2022 07:55:48 +0000
Message-ID: <CANFkB1yr3N_Twac=ocxBRst79-gmdu8=6VTD6oPgdGT0rb_HaQ@mail.gmail.com>
Subject: Re: GATT issue, possible bluez bug?
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz

On Tue, 22 Mar 2022 at 00:44, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Adam,
>
> On Mon, Mar 21, 2022 at 4:03 PM Adam Pigg <adam@piggz.co.uk> wrote:
> >
> > Hi
> >
> > A bit of background, I write a linux desktop/mobile app called
> > Amazfish which interfaces with several watches over BLE using their
> > GATT services.  To do this, I use the bluez dbus api (technically a
> > thin wrapper around it I wrote called qble
> > https://github.com/piggz/qble)
> >
> > All has been good so far, I support several generations of
> > Huami/Amazfit watches, as well as the open source Pinetime and
> > Bangle.js.  For the Amazfit watches, i have implementations for older
> > devies such as the Bip, and newer ones such as the GTS.
> >
> > Much of the reverse engineering comes from the Android Gadget Bridge
> > project, which supports many more devices.
> >
> > My community of users donated to buy me a newer device called a GTR2,
> > which, according to the GB devs uses the same protocol as the slightly
> > older GTS, and the packet captures I have from Android would support
> > this.
> >
> > But this is where my trouble starts with Bluez, my existing
> > implementation doesnt work at all.  Normally, after a connection, I
> > would wait for the ServicesResolved signal, which happens pretty fast
> > on all other devices, but on the GTR2, it takes about 30 seconds, by
> > which time, the watch has disconnected. (i get a disconnected signal
> > immediately after the ServicesResolved signal)
> >
> > To rule out my code, I have tried several things:
> > Gatttool
> > With gattool, i can connect, get the services, enable a notification,
> > write a value and get the expected results seemingly fine
> >
> > Python-gatt (using the bluez dbus api)
> > Im unable to iterate the services, like my app, it takes 30 seconds to
> > get the signal and then swiftly disconnects
> >
> > Gattlib (https://github.com/labapart/gattlib)
> > Gattlib is interesting as it appears to have "borrowed" much of its
> > code directly from bluez.  When built against the system bluez, if the
> > version is > 5.42, it will use the dbus api.  When I do this, again im
> > unable to list services on the watch.  However, if I edit the build to
> > force it to use its internal gatt implementation, which appears to be
> > the same one used by gatttool, then, it IS able to interrogate the
> > watch.
> >
> > I have attached 3 files
> > 1. test python program which should print services, and associated btmon
> > 2. btmon output while using gatttool
> > 3. btmon output running gattlib discover example
> >
> > Note, other than discovery, I havnt been able to get gattlib to
> > read/write/notify!
> >
> > It seems as though I may be triggering a bug in the bluez dbus api?
> > Can anyone suggest anything?
>
> What version are you using? I would first try with the latest to see
> if that something already fixed.
>
>
Im using 5.63 already, which is the latest tag (on opensuse tumbleweed)

I'll also try bluetoothctl and attach logs using that, though I
suspect it will behave the same as the python library and my own
library.

> --
> Luiz Augusto von Dentz
