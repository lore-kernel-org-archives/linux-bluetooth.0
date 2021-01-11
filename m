Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D06EC4332B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Jan 2021 00:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59CC422D57
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Jan 2021 00:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404136AbhALA0F (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Jan 2021 19:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404215AbhAKXzY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Jan 2021 18:55:24 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BACFC061786
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Jan 2021 15:54:44 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id q10so475588vsr.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Jan 2021 15:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sFe4FxXAqnntsHYx+FqrRb20amduyHI/l1kwWdZJ3bY=;
        b=jzLlBu0izXIPOomJTuUBeAcEoiUHc5q7uDP/8tdoaXNy3a/SYz4iJKWJP9/KLBRfC5
         QrFkGyWm18i0irlwXBAKkhFWQhJL3IdQ3VsJcOLczpDmxfP5DJbYkckBtDu859XhW0rl
         I7SoqWTZQWVmHw4ns11O8OW7fNTXcOsBW7FGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sFe4FxXAqnntsHYx+FqrRb20amduyHI/l1kwWdZJ3bY=;
        b=WYVwkMOqrEn2K8Ct1pU5n22BzK5V7RZhdT0D8mmrzba/cpkakvyWscOJ9E/dsDJ615
         mBuIcCheyBNrDlSpQL6oi5a/Nn6wsRGuPd2J/2aJ4nzjuZQEQ+2pzZu6Vn21t4bA9Enq
         RpognEX6/aEynpPN6vkB5DqkmLk6hcr+FKfCnp/DqdvyERE0hTtzSKgteRTyf7qkkkje
         U7jC0+qRQTTLGKkNJ4VO31YMFU4Up6UTsjFoLKYbn90wm0TfPxEA0g83woDc7mWw2JR/
         2RTN1PjT22HpoFVOkCdMZnYb9228UaBoMUy+OHwfGbkff/baGkDt3Obv3D6fJ8jYhiQJ
         XY2Q==
X-Gm-Message-State: AOAM5310NEGuNxDkysuLIrOrxG7zrOjBD0OUT10bZXbro5Nfli6P/QyX
        lZHMVFB59Dhc/IpTKfi/9AywmPmxf3yTYZZXb0ICcA==
X-Google-Smtp-Source: ABdhPJxK5yFIndDM9XVCAsMPWRlpIXyTcFfC6MvT2KWaT5veBmyDiZ9aY2+6/FTtqA2aKUEoV1rGaRdebdAYWhx0fdA=
X-Received: by 2002:a05:6102:66a:: with SMTP id z10mr1776004vsf.53.1610409283496;
 Mon, 11 Jan 2021 15:54:43 -0800 (PST)
MIME-Version: 1.0
References: <VI1PR04MB496003E449FB10B12959ADC292D00@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <CANFp7mXtX4H=tQ5usRiOXRBzfuQORc6-MCznbjmsMBRAQMo36w@mail.gmail.com> <VI1PR04MB4960E51607240EC6B681526492AF0@VI1PR04MB4960.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB4960E51607240EC6B681526492AF0@VI1PR04MB4960.eurprd04.prod.outlook.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Mon, 11 Jan 2021 15:54:33 -0800
Message-ID: <CANFp7mUWv1=SW_CL8YZgBP-emXC9aRXTeteE1+Ds7qrP3jWcBw@mail.gmail.com>
Subject: Re: BT large file transfer failed when do suspend/resume test
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sherry,

On Wed, Jan 6, 2021 at 7:12 PM Sherry Sun <sherry.sun@nxp.com> wrote:
>
> Hi Abhishek, thanks for you answer, please see my reply below.
>
> > -----Original Message-----
> > From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > Sent: 2021=E5=B9=B41=E6=9C=887=E6=97=A5 3:02
> > To: Sherry Sun <sherry.sun@nxp.com>
> > Cc: linux-bluetooth@vger.kernel.org; marcel@holtmann.org;
> > johan.hedberg@gmail.com
> > Subject: Re: BT large file transfer failed when do suspend/resume test
> >
> > Hi Sherry,
> >
> > On Wed, Jan 6, 2021 at 5:40 AM Sherry Sun <sherry.sun@nxp.com> wrote:
> > >
> > > Hi Abhishek,
> > >
> > > I want to ask you some questions about your patch: Bluetooth: Handle
> > > BR/EDR devices during suspend.
> > > (https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
pat
> > >
> > chwork.kernel.org%2Fproject%2Fbluetooth%2Fpatch%2F20200311085359.RF
> > C.v
> > >
> > 6.2.Icc7c35e1cabf10f8a383a009694987520f1d1b35%40changeid%2F&amp;da
> > ta=3D0
> > >
> > 4%7C01%7Csherry.sun%40nxp.com%7C9d41a6725ac1432355c408d8b275970
> > 0%7C686
> > >
> > ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637455565422685536%7CU
> > nknown%7
> > >
> > CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi
> > LCJXV
> > >
> > CI6Mn0%3D%7C1000&amp;sdata=3D56h1%2BfVflqDZsx%2FcIbtUfa6kcPjV4p2n
> > cxPf1uA
> > > a7iY%3D&amp;reserved=3D0)
> > >
> > > Platform: L5.10 + Bluez5.55 + Marvell BT chip
> > >
> > > Background: Our test team usually try suspend/resume test when
> > > transferring large file through BT, to see if the file transfer can b=
e continued
> > after suspend/resume. It can works well before L5.10 But we found on L5=
.10,
> > the BT connection lost if we try to suspend/resume, so the file
> > transfer(through OBEX Object Push) shows failed. Then we found your
> > patches when debugging.
> > >
> > > Questions:
> > > 1. Before L5.10, kernel always keep BT connected during suspend/resum=
e.
> > So why we need to disconnect all the BT devices when system suspend now=
?
> >
> > Bluetooth has often been a source of spurious wakes in the past. Using =
rfkill
> > or masking the wake interrupt were used in the past to make this more
> > reliable but this was resulting in instability on the controller (contr=
oller needs
> > to drop traffic if host is asleep and there's no clean way to do that).
> >
> > The new suspend behavior is the following:
> > - All devices get disconnected during suspend.
> > - Only HID devices can wake the device from suspend (i.e. Remote Wake).
> > The BT controller will be configured to scan (page scan and/or LE passi=
ve
> > scan) based on currently paired devices. If the device is not configure=
d for
> > wakeup (i.e. power/wakeup in sysfs is "disabled"), we will not configur=
e this
> > scanning either (see the hdev->prevent_wake implementation in btusb for=
 an
> > example)
>
> So for HID devices, they also been disconnected when suspend and auto rec=
onnected when resume, right?

HID will not be auto-reconnected because the peripheral is responsible
for reconnecting. Most HID devices do not page scan unless they are
pairing (or at least that's what I've found in practice).

>
> > - On resume, devices that support a2dp-sink will be automatically
> > reconnected
> >
>
> I just tried a2dp-sink devices(BT headphones), and it wasn't reconnected =
after system resume.
> I checked your patches which to supported a2dp-sink auto reconnect, and f=
ound them may didn't been included in bluez5.55,  can you help confirm that=
?

It looks like bluez5.55 was released on Sep 06
(https://git.kernel.org/pub/scm/bluetooth/bluez.git/tag/?h=3D5.55) and
my change was merged Sep 14
(https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=3D6611b72600=
c370ec31795ab48a222594c4afb7ee).

>
> > This results in more reliable behavior from Bluetooth around suspend wh=
ile
> > allowing Remote Wake to work properly.
> >
>
> Yes, it' reasonable, but I think it may need to reconnect all the devices=
 which are disconnected due to suspend, right?
> Otherwise for the user, when we connect the BT, which means we do want to=
 use the BT device,
> but every time when system get into suspend, we will need to reconnect th=
e device manually, it's really inconvenient.

Depending on the profile implemented, not all peer devices will page
scan once disconnected. HID devices at least will not page scan and
are expected to initiate the reconnect themselves (i.e. suspend,
resume and then click your mouse; the mouse will reconnect).

If reconnecting to arbitrary profiles is desirable, you can merge this
patch (https://patchwork.kernel.org/project/bluetooth/patch/20201207154903.=
bluez.1.I3e043a481273442748bcff0728b2f0e208017cd2@changeid/).

>
> > > 2. I found that the device been disconnected due to suspend won't bee=
n
> > auto-connected after resume, shouldn't we get the BT device auto-connec=
ted
> > after resume like wifi devices done?
> >
> > We do this currently only for Bluetooth headphones (reconnect on a2dp-s=
ink
> > service). I'm not familiar with Obex so I don't know if this would work=
 for
> > that as well. I did send up a patch making reconnect on resume configur=
able
> > based on service uuid that may be relevant to
> > this:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpat=
ch
> > work.kernel.org%2Fproject%2Fbluetooth%2Fpatch%2F20201207154903.blue
> > z.1.I3e043a481273442748bcff0728b2f0e208017cd2%40changeid%2F&amp;d
> > ata=3D04%7C01%7Csherry.sun%40nxp.com%7C9d41a6725ac1432355c408d8b2
> > 759700%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6374555654
> > 22685536%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> > V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D6zZda8Yu
> > RRbAMkwOxiSwjbJIpvi%2ByMSDWCzVkFkkpzs%3D&amp;reserved=3D0
> >
>
> Why here only add a2dp-sink device auto reconnect support?
> Why not add all the devices auto reconnect support which are disconnected=
 due to suspend?
>
> > > 3. For the large file transfer, if the BT been disconnected during su=
spend,
> > the transfer will fail, do we have any methods to avoid this issue?
> >
> > If you have an active transfer, does it make sense to be suspending?
> > Perhaps you should hold a wakelock while a transfer is ongoing.
> > I am not sure how Obex and other services should behave here so I will =
defer
> > to Luiz and Marcel's opinion on this topic.
>
> I'm not sure whether it's reasonable, our drivers seems can be suspended =
during transfer file and A2DP playing.
> Maybe we really need a wakelock here.
>
> Thanks and regards
> Sherry
>
> >
> > >
> > > I'm new to Bluetooth, there are many things I don't understand, looki=
ng
> > forward to your answer, and thanks for now!
> > >
> > > Best regards
> > > Sherry sun
> > >
> >
> > Thanks
> > Abhishek
