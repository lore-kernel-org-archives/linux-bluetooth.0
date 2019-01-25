Return-Path: <SRS0=pNHN=QB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314B8C282C0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Jan 2019 14:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5EE0218D0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Jan 2019 14:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hm+efKeJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfAYOlW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:41:22 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:37799 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfAYOlW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Jan 2019 09:41:22 -0500
Received: by mail-oi1-f174.google.com with SMTP id y23so7817060oia.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jan 2019 06:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zkwjuzu/UEKpmkjFauairkz2xJGPfJcFw7WQ01oT7fM=;
        b=hm+efKeJx76zpncufMIDoS7XbQ/pH6APfSa4+uwdfozG2x1ps5u32dhGrx2XLCmo68
         azTMJHcziVpOtMoibvaz7k48lORBsRDz1HzIiQjmNf0E47pRnqW/ILSAMby1cHvciQeo
         hvjzQS+HYr19JPFrKABPeXCX2lX3kRXnvS+FwnC8sjp5LX2hkoPglFNXKuc8KSM8IjVB
         NBiQ49LQduBsiLoJURFLCIRh/cMdrmPKKdxYet4IAuMZQF0SX+4ACkvS/XRJOfocxU9D
         HwVdLtjYWCscK44qjQ/vuWHoxzDbfqcDtMnJ8N9ZZBnsLxNV3EIcquLjCfuVqXOV9j88
         rK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zkwjuzu/UEKpmkjFauairkz2xJGPfJcFw7WQ01oT7fM=;
        b=RdHaulB7YSt37x7wRQKZ5KOQluORz75tYUhAPnVEJx+YZQ2T6/+5nJ4nDXA7mwWE0g
         aPrXQqsdwfFzJz77V59jDMb8VD44e/Ql5RFNQVNURijGJNKI2Mkau+gOLzj3vMsJJy4A
         0iwkoWgAKK+o2ykcMI+nT7tgiKMwOVcPTM93zQjp7+oSAgm9TP4zt+sgJLZsuzw8I3/V
         EdtapqO2cCYmiG7p1bOU4l05fQ79cezFcevAxsvaIuxdP1Bng2Wr1D62FeXd/bdI0RJk
         sKNZJCvOFeTpOOrD0J23df+ODngxmnVH4TsDM7c9DTMpIa6bcCICj+oA3b5lJhSfFWGM
         WlZQ==
X-Gm-Message-State: AHQUAubBmCKGhvGZS4pnGq7fYXDaiL0r91T+jv64mIKV6Y7pN93LtYRf
        WxcQ76YNOOJgibaE/FpS+p9kPcKBqYeFd03nLcA=
X-Google-Smtp-Source: AHgI3IYtwVo4arF6M6SkpIWl9UDSgwB5+0wcQImCFDZhJW4Nus31EUuDtOXAHlmHCA+xkpp7kzddIlMv4RiiCB8J5ac=
X-Received: by 2002:aca:d509:: with SMTP id m9mr1485462oig.82.1548427280131;
 Fri, 25 Jan 2019 06:41:20 -0800 (PST)
MIME-Version: 1.0
References: <CA+T8qpa+qHK7O6zr+a7CUysPzzR4jce7peCCcuOVN4J9TP6teQ@mail.gmail.com>
 <CABBYNZKGS=AcqtgfFffLBWZX6pxOHmkpnXgW4ddr4hO58a_pHQ@mail.gmail.com>
 <CA+T8qpb=w5gnYMWh2fv6Q61ssHs1hrvJ=0gh0murxQZsvbt5vA@mail.gmail.com>
 <CABBYNZ+p_BLtLvWYm3A1gzYY8uo8F2S1evuYTfkg8SST8zfD=Q@mail.gmail.com> <CA+T8qpbbi+7=8bNdiJFstFTWHAUXmUYtcL6x4=PVLKsppb9GrQ@mail.gmail.com>
In-Reply-To: <CA+T8qpbbi+7=8bNdiJFstFTWHAUXmUYtcL6x4=PVLKsppb9GrQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 25 Jan 2019 16:41:07 +0200
Message-ID: <CABBYNZK3X6NM38qG20dGMJAjpUdD-nqyzLf+T1RYtsOxW=XLUQ@mail.gmail.com>
Subject: Re: BlueZ 5.50: Browsing local GATT table
To:     Youssif Saeed <youssif.am.saeed@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Youssif,

On Thu, 24 Jan 2019, 17:07 Youssif Saeed <youssif.am.saeed@gmail.com wrote:
>
> On Mon, Jan 21, 2019 at 3:02 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Youssif,
> > On Mon, Jan 21, 2019 at 3:57 PM Youssif Saeed
> > <youssif.am.saeed@gmail.com> wrote:
> > >
> > > Hi Luiz
> > >
> > > On Mon, Jan 21, 2019 at 12:12 PM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Youssif,
> > > >
> > > > On Mon, Jan 21, 2019 at 1:05 PM Youssif Saeed
> > > > <youssif.am.saeed@gmail.com> wrote:
> > > > >
> > > > > Hi
> > > > >
> > > > > Is there a tool/utility for browsing the local GATT table. I have so
> > > > > far used "bluetoothctl info" as follows:-
> > > > >
> > > > > [bluetooth]menu gatt
> > > > > [bluetooth]register-service 0xFFFF
> > > > > [bluetooth]register-characteristic 0xAAAA read,write
> > > > > [bluetooth]register-application
> > > > > [bluetooth]back
> > > > > [bluetooth]info
> > > > > Controller 00:16:A4:09:31:11 (public)
> > > > > Name: linuxvm
> > > > > Alias: linuxvm
> > > > > Class: 0x000c0000
> > > > > Powered: yes
> > > > > Discoverable: no
> > > > > Pairable: yes
> > > > > UUID: Headset AG                (00001112-0000-1000-8000-00805f9b34fb)
> > > > > UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
> > > > > UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
> > > > > UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
> > > > > UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
> > > > > UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
> > > > > UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)
> > > > > UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b34fb)
> > > > > UUID: Unknown                   (0000ffff-0000-1000-8000-00805f9b34fb)
> > > > > UUID: Headset                   (00001108-0000-1000-8000-00805f9b34fb)
> > > > > Modalias: usb:v1D6Bp0246d0532
> > > > > Discovering: no
> > > > >
> > > > > However, this does not show the list of characteristics/descriptors
> > > > > and their handles which is what I am after.
> > > > >
> > > > > I am using BlueZ 5.50 on an Ubuntu machine running Linux 4.15.0-43-generic.
> > > >
> > > > I guess you would be after the registered local attributes, command
> > > > info doesn't print that only the UUID of the services, we could have
> > > > then as part of list-attributes perhaps but it would only show the
> > > > attributes register by that instance of bluetoothctl nothing else. As
> > > > for the handles that is currently not exposed to the application, do
> > > > you require them perhaps to restore them in the same location?
> > > >
> > > > --
> > > > Luiz Augusto von Dentz
> > >
> > > Thanks for getting back to me. Yes I am after the registered local
> > > attributes. We're working on PTS testing the BlueZ stack and a few
> > > tests require you to submit handles for the local GATT
> > > services/characteristics, which is why having this would be very
> > > useful. In my personal opinion the output to the deprecated "gatttool
> > > primary/characteristics/descriptors" is ideal for displaying all the
> > > necessary information. Something similar to this but for the local
> > > GATT table can be very beneficial for future users even outside the
> > > scope of PTS testing.
> >
> > I will need to look into that, we actually intend to have this all
> > automated with auto-pts:
> >
> > https://github.com/intel/auto-pts
> >
> > Though that is not complete for BlueZ, only Zephyr, and even in case
> > of Zephyr we hardcoded the handles, but I agree it is better to
> > somehow notify the handle back to the application. Also another thing
> > that we might have to improve in the future is a way to pin services
> > so even if one reboot the system, or just restart bluetoothd, the
> > application can have its services in the same region once again.
> >
> > --
> > Luiz Augusto von Dentz
>
> Thanks for the link. I've seen the auto-pts project and it's quite
> impressive. It's definitely helpful when doing PTS tests but as you
> said it is missing a big portion for the BlueZ stack.
>
> Is there a place where we can post feature requests and unconfirmed
> bugs, or is this mailing list the best location for that?
>

You can file issues in github direcly.

>
> I think it will be handy as well to report the handle back for remote
> services/characteristics. As an example, this is the response for
> "list-attributes":-
>
> Primary Service
>         /org/bluez/hci0/dev_00_1B_DC_08_0A_D4/service0014
>         00001801-0000-1000-8000-00805f9b34fb
>         Generic Attribute Profile
> Characteristic
>         /org/bluez/hci0/dev_00_1B_DC_08_0A_D4/service0014/char0015
>         00002a05-0000-1000-8000-00805f9b34fb
>         Service Changed
>
> Unfortunately there are many PTS tests that list multiple attributes
> with the same UUID but different handles. This is rare for everyday
> application but it is not impossible. Again, the output of the
> deprecated "gatttool primary/characteristics/descriptors" showed all
> the necessary information including the properties and permissions,
> and it would be extremely useful if something similar was implemented
> to bluetoothctl.

Ive send an RFC regarding that, please have a look if that makes sense.
