Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74025C433E6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Jan 2021 05:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 258A1229C6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Jan 2021 05:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbhASFSn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Jan 2021 00:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732835AbhASFC3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Jan 2021 00:02:29 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10EBC061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Jan 2021 21:01:35 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id j17so4829156vso.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Jan 2021 21:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K48d6OJ7hZl6DWNfl+Fg+iS/dXT+Vc4INwzaNEk8nec=;
        b=CmgX7EoGRGgQUyiD+xLPmhf1uS/CBN+EqH3FTIvaJLnVOlxZlXqgLMWryQdQR8zjbj
         oYdF24eZMOejKGbMfznnCC7V74B+9udkoOBenl4hSpC78kynlR8QokWKBKZ2k+6wqvzB
         Hks9vifLz1Km4k/c+lQH7aEE+vKu+/YXZbK6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K48d6OJ7hZl6DWNfl+Fg+iS/dXT+Vc4INwzaNEk8nec=;
        b=rnudr18BnXxiMCQy1O0PE4tLvuYEvSyBYGqSX2kULL+Do8pgncwnczYssVc3iK59x7
         l2SsTCax7r+hOW88MryCdz/MYk2vfPhbV0Cdt0HhcX4j0QVJURaynww5dolOE+ejzvP4
         Clt01l+Vs2Cvjav7TTiXGY0aNr7di81P92+3VFsj4hsx7tWwwOKFVLT2MLKSlLDo3yed
         cBw1gdb+uljAi02T82eZ4Pf48zmXd/gmR2H9DaYYiOYAF0vuBdbxpLg18IPv5hi+sUjL
         deM+HVw71j+Y/+hJs1WAnXoYoGrdGvdJg11oG69b2vNLDe/5euk7TYuYEMtzyGsoEMt2
         4kgg==
X-Gm-Message-State: AOAM530nkXN0K5FFsrQ1nECuniSVQCuQuM5ywO78TpVFSyA82GI2OFGB
        YvNVmhOeuv18TL/KB3KYtmUGeX+b/OpZRJPEiLq0Nx4EY1INCQ==
X-Google-Smtp-Source: ABdhPJy+3mw76QW18GZbI48/xTrsvNRfVg/pyH+F6s1p1KBnyFv4v7hbIsBNfrc8z5S5+dqQ1tv/VnmfxN4lVpaZTyI=
X-Received: by 2002:a67:7102:: with SMTP id m2mr1509935vsc.30.1611032494061;
 Mon, 18 Jan 2021 21:01:34 -0800 (PST)
MIME-Version: 1.0
References: <VI1PR04MB496003E449FB10B12959ADC292D00@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <CANFp7mXtX4H=tQ5usRiOXRBzfuQORc6-MCznbjmsMBRAQMo36w@mail.gmail.com>
 <VI1PR04MB4960E51607240EC6B681526492AF0@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <CANFp7mUWv1=SW_CL8YZgBP-emXC9aRXTeteE1+Ds7qrP3jWcBw@mail.gmail.com> <VI1PR04MB4960FFA7AB29E413CF7C8A3292AA0@VI1PR04MB4960.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB4960FFA7AB29E413CF7C8A3292AA0@VI1PR04MB4960.eurprd04.prod.outlook.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Mon, 18 Jan 2021 21:01:23 -0800
Message-ID: <CANFp7mXeFOSGWLqPRoCGcH95u=m_W=HVn8Ey34u9SOqi31Xj7Q@mail.gmail.com>
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

On Tue, Jan 12, 2021 at 3:07 AM Sherry Sun <sherry.sun@nxp.com> wrote:
>
> Hi Abhishek,
>
> > -----Original Message-----
> > From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > Sent: 2021=E5=B9=B41=E6=9C=8812=E6=97=A5 7:55
> > To: Sherry Sun <sherry.sun@nxp.com>
> > Cc: linux-bluetooth@vger.kernel.org; marcel@holtmann.org;
> > johan.hedberg@gmail.com
> > Subject: Re: BT large file transfer failed when do suspend/resume test
> >
> > Hi Sherry,
> >
> > On Wed, Jan 6, 2021 at 7:12 PM Sherry Sun <sherry.sun@nxp.com> wrote:
> > >
> > > Hi Abhishek, thanks for you answer, please see my reply below.
> > >
> > > > -----Original Message-----
> > > > From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > > > Sent: 2021=E5=B9=B41=E6=9C=887=E6=97=A5 3:02
> > > > To: Sherry Sun <sherry.sun@nxp.com>
> > > > Cc: linux-bluetooth@vger.kernel.org; marcel@holtmann.org;
> > > > johan.hedberg@gmail.com
> > > > Subject: Re: BT large file transfer failed when do suspend/resume
> > > > test
> > > >
> > > > Hi Sherry,
> > > >
> > > > On Wed, Jan 6, 2021 at 5:40 AM Sherry Sun <sherry.sun@nxp.com>
> > wrote:
> > > > >
> > > > > Hi Abhishek,
> > > > >
> > > > > I want to ask you some questions about your patch: Bluetooth:
> > > > > Handle BR/EDR devices during suspend.
> > > > > (https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2
> > > > > Fpat
> > > > >
> > > >
> > chwork.kernel.org%2Fproject%2Fbluetooth%2Fpatch%2F20200311085359.RF
> > > > C.v
> > > > >
> > > >
> > 6.2.Icc7c35e1cabf10f8a383a009694987520f1d1b35%40changeid%2F&amp;da
> > > > ta=3D0
> > > > >
> > > >
> > 4%7C01%7Csherry.sun%40nxp.com%7C9d41a6725ac1432355c408d8b275970
> > > > 0%7C686
> > > > >
> > > >
> > ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637455565422685536%7CU
> > > > nknown%7
> > > > >
> > > >
> > CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi
> > > > LCJXV
> > > > >
> > > >
> > CI6Mn0%3D%7C1000&amp;sdata=3D56h1%2BfVflqDZsx%2FcIbtUfa6kcPjV4p2n
> > > > cxPf1uA
> > > > > a7iY%3D&amp;reserved=3D0)
> > > > >
> > > > > Platform: L5.10 + Bluez5.55 + Marvell BT chip
> > > > >
> > > > > Background: Our test team usually try suspend/resume test when
> > > > > transferring large file through BT, to see if the file transfer
> > > > > can be continued
> > > > after suspend/resume. It can works well before L5.10 But we found o=
n
> > > > L5.10, the BT connection lost if we try to suspend/resume, so the
> > > > file transfer(through OBEX Object Push) shows failed. Then we found
> > > > your patches when debugging.
> > > > >
> > > > > Questions:
> > > > > 1. Before L5.10, kernel always keep BT connected during
> > suspend/resume.
> > > > So why we need to disconnect all the BT devices when system suspend
> > now?
> > > >
> > > > Bluetooth has often been a source of spurious wakes in the past.
> > > > Using rfkill or masking the wake interrupt were used in the past to
> > > > make this more reliable but this was resulting in instability on th=
e
> > > > controller (controller needs to drop traffic if host is asleep and =
there's no
> > clean way to do that).
> > > >
> > > > The new suspend behavior is the following:
> > > > - All devices get disconnected during suspend.
> > > > - Only HID devices can wake the device from suspend (i.e. Remote Wa=
ke).
> > > > The BT controller will be configured to scan (page scan and/or LE
> > > > passive
> > > > scan) based on currently paired devices. If the device is not
> > > > configured for wakeup (i.e. power/wakeup in sysfs is "disabled"), w=
e
> > > > will not configure this scanning either (see the hdev->prevent_wake
> > > > implementation in btusb for an
> > > > example)
> > >
> > > So for HID devices, they also been disconnected when suspend and auto
> > reconnected when resume, right?
> >
> > HID will not be auto-reconnected because the peripheral is responsible =
for
> > reconnecting. Most HID devices do not page scan unless they are pairing=
 (or
> > at least that's what I've found in practice).
>
> What's the peripheral mean here?
>

The connected Bluetooth device (i.e. mouse, keyboard, etc).

> >
> > >
> > > > - On resume, devices that support a2dp-sink will be automatically
> > > > reconnected
> > > >
> > >
> > > I just tried a2dp-sink devices(BT headphones), and it wasn't reconnec=
ted
> > after system resume.
> > > I checked your patches which to supported a2dp-sink auto reconnect, a=
nd
> > found them may didn't been included in bluez5.55,  can you help confirm
> > that?
> >
> > It looks like bluez5.55 was released on Sep 06
> > (https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
t.ke
> > rnel.org%2Fpub%2Fscm%2Fbluetooth%2Fbluez.git%2Ftag%2F%3Fh%3D5.55&
> > amp;data=3D04%7C01%7Csherry.sun%40nxp.com%7C1f3ec177fe974c90e1a508
> > d8b68c4584%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637460
> > 060872077285%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ
> > QIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DEDn
> > MnLjPIN29nQpmH1%2Fk%2BBnhMq5IZ3xG7BXIEq0xs6A%3D&amp;reserved
> > =3D0) and my change was merged Sep 14
> > (https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
t.ke
> > rnel.org%2Fpub%2Fscm%2Fbluetooth%2Fbluez.git%2Fcommit%2F%3Fid%3D
> > 6611b72600c370ec31795ab48a222594c4afb7ee&amp;data=3D04%7C01%7Cshe
> > rry.sun%40nxp.com%7C1f3ec177fe974c90e1a508d8b68c4584%7C686ea1d3b
> > c2b4c6fa92cd99c5c301635%7C0%7C0%7C637460060872077285%7CUnknown
> > %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW
> > wiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D2jYeDwzoy87GA2V2SqilgdA502jeI
> > ZdGd4aeyXH125M%3D&amp;reserved=3D0).
> >
>
> Okay, got it, so you patches don't been included in bluez5.55.
>
> > >
> > > > This results in more reliable behavior from Bluetooth around suspen=
d
> > > > while allowing Remote Wake to work properly.
> > > >
> > >
> > > Yes, it' reasonable, but I think it may need to reconnect all the dev=
ices
> > which are disconnected due to suspend, right?
> > > Otherwise for the user, when we connect the BT, which means we do wan=
t
> > > to use the BT device, but every time when system get into suspend, we=
 will
> > need to reconnect the device manually, it's really inconvenient.
> >
> > Depending on the profile implemented, not all peer devices will page sc=
an
> > once disconnected. HID devices at least will not page scan and are expe=
cted
> > to initiate the reconnect themselves (i.e. suspend, resume and then cli=
ck your
> > mouse; the mouse will reconnect).
> >
> > If reconnecting to arbitrary profiles is desirable, you can merge this =
patch
> > (https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa=
tch
> > work.kernel.org%2Fproject%2Fbluetooth%2Fpatch%2F20201207154903.blue
> > z.1.I3e043a481273442748bcff0728b2f0e208017cd2%40changeid%2F&amp;d
> > ata=3D04%7C01%7Csherry.sun%40nxp.com%7C1f3ec177fe974c90e1a508d8b68
> > c4584%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637460060872
> > 077285%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2l
> > uMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DaNXOfCTXs%
> > 2BISAbYBH2die47qfpqXRmqehSnW1mC8M7U%3D&amp;reserved=3D0).
> >
>
> But for the most Bluetooth profile, like A2DP-sink/A2DP-source/OPP/HFP/HS=
P, I think it is necessary to re-connect it, right?
> So I think it's better to add the auto reconnect support for all those pr=
ofiles instead of the A2DP a2dp-sink only here.
> Please correct me if I'm wrong.
>

I think it should be user configurable and I'm not sure what defaults
make sense for general Linux distributions. For ChromeOS, we only want
a2dp-sink.

I've linked the patch series making it more configurable in previous
emails (https://patchwork.kernel.org/project/bluetooth/patch/20201207154903=
.bluez.1.I3e043a481273442748bcff0728b2f0e208017cd2@changeid/).
If you agree that behavior is necessary, please make your case to the
bluez maintainer (Luiz).

> > >
> > > > > 2. I found that the device been disconnected due to suspend won't
> > > > > been
> > > > auto-connected after resume, shouldn't we get the BT device
> > > > auto-connected after resume like wifi devices done?
> > > >
> > > > We do this currently only for Bluetooth headphones (reconnect on
> > > > a2dp-sink service). I'm not familiar with Obex so I don't know if
> > > > this would work for that as well. I did send up a patch making
> > > > reconnect on resume configurable based on service uuid that may be
> > > > relevant to
> > > > this:
> > > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fpa
> > > > tch
> > > >
> > work.kernel.org%2Fproject%2Fbluetooth%2Fpatch%2F20201207154903.blue
> > > >
> > z.1.I3e043a481273442748bcff0728b2f0e208017cd2%40changeid%2F&amp;d
> > > >
> > ata=3D04%7C01%7Csherry.sun%40nxp.com%7C9d41a6725ac1432355c408d8b2
> > > >
> > 759700%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6374555654
> > > >
> > 22685536%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> > > >
> > V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D6zZda8Yu
> > > > RRbAMkwOxiSwjbJIpvi%2ByMSDWCzVkFkkpzs%3D&amp;reserved=3D0
> > > >
> > >
> > > Why here only add a2dp-sink device auto reconnect support?
> > > Why not add all the devices auto reconnect support which are
> > disconnected due to suspend?
> > >
> > > > > 3. For the large file transfer, if the BT been disconnected durin=
g
> > > > > suspend,
> > > > the transfer will fail, do we have any methods to avoid this issue?
> > > >
> > > > If you have an active transfer, does it make sense to be suspending=
?
> > > > Perhaps you should hold a wakelock while a transfer is ongoing.
> > > > I am not sure how Obex and other services should behave here so I
> > > > will defer to Luiz and Marcel's opinion on this topic.
> > >
> > > I'm not sure whether it's reasonable, our drivers seems can be suspen=
ded
> > during transfer file and A2DP playing.
> > > Maybe we really need a wakelock here.
> > >
>
> I checked the wakelock related code in kernel suspend steps, but it seems=
 that the wakelock cannot prevent the Bluetooth disconnect behavior.
> Because when we run echo mem > /sys/power/state command to put the system=
 get into suspend mode,
> it will call pm_notifier_call_chain_robust() in suspend_prepare(), the Bl=
uetooth will be disconnected here as you add the pm_notifier callback.
> In the next few steps, pm_wakeup_pending will be called to determine whet=
her the suspend operation should be continued, if we registered the wakeloc=
k, we will not enter the suspend state.
> But the Bluetooth has been disconnected already. Therefore, even if a wak=
elock is added, we will also meet this BT large file transfer fail issue. A=
m I right?
>

From what you've described, that seems to be the case. I would expect
wakelocks to prevent suspend notifiers as well so this seems like a
bug in the suspend code. You should submit a patch to check that there
isn't a pending wakeup in enter_state since that's the case:
https://github.com/torvalds/linux/blob/master/kernel/power/suspend.c#L562

> Best regards
> Sherry
> > > Thanks and regards
> > > Sherry
> > >
> > > >
> > > > >
> > > > > I'm new to Bluetooth, there are many things I don't understand,
> > > > > looking
> > > > forward to your answer, and thanks for now!
> > > > >
> > > > > Best regards
> > > > > Sherry sun
> > > > >
> > > >
> > > > Thanks
> > > > Abhishek
