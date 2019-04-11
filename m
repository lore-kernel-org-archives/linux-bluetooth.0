Return-Path: <SRS0=EB+V=SN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D0AC10F13
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Apr 2019 22:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2CC2084D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Apr 2019 22:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nr7NM/8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfDKWDN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:03:13 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:45920 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfDKWDM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Apr 2019 18:03:12 -0400
Received: by mail-pf1-f173.google.com with SMTP id e24so4072074pfi.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2019 15:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oA9yr2hL5Hhdr3NbGkCEqbnPsOk6WqOQ5UQglOsDJ3s=;
        b=nr7NM/8sPq5m3WJwHTbcOL0NgVOlcbfEeh9HsV15cceTS8sQRWRzzF4Bfcoqp+5vYQ
         QQDFuPxk+X7G+6MgBqTtxDcO66iBa+MbXYmjt182niNjkJrUDkl3VhAZczqFzBxU4o6o
         CIOf9dZ8afu11D99VLexE6VptiiOycj0pnN1yFT8xEavFt0j16EoB16ywVwG5L7/t9T+
         J6PLxPMxT8GPFszketXeEcykc8t+uHClOulajOVVCIBVGY5WBpBH7ljXEo0+7jSy78VB
         yGtCQ4fWlw4OV9HfEy15khKv3grmnWVtfpHb+JzTtnLa56z1V/LzPsb1+K8PpAT5UKmK
         Lxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oA9yr2hL5Hhdr3NbGkCEqbnPsOk6WqOQ5UQglOsDJ3s=;
        b=UoQDoj5/VWEoceFgXJd+YTgXebX3pdy5yLHum6eILrrJpa4rUDwmp81OInpwko2uXB
         82KRHPvlGPQNShLYCqQlMg6PocCL+5BoOQUAgd0uY+QSSe20RjrXhwNT3PkkMg8xWjmi
         cMXlqxbq4+YgVQ2ypSsTh5JXBeJ9SHi/Rt0WrvrILjysub/jj690+0Yw/J9KN/u4p6Mu
         psEiY85TsxEB0LQZTCftFYHSfKEoiPByVUFkhLVR2jYc9e6nz6fT9ruxkEIXXss7gb3A
         UM+3Zsqsk4+uTlnAGEtsdhnaAGWkzlPoRioWixAvshRJmYpz6lXH2RLRKUWJWd5RMUJF
         KeuA==
X-Gm-Message-State: APjAAAVkZcposifZvRomM0hNw5E9fJzr0FYngD2AkiUWVTza/oFXaPnx
        NMf89h+JHWJ4ofK6UAy6g8k7ySYbMbFPyZUcoXt+Wk/2m64=
X-Google-Smtp-Source: APXvYqwWbtO1iF4kGv/qszQ3ZEWDQ1aZFHnhBBkFNYKsyQt3ku+PyQm2hN+dGxoof+FtgjI0n08mFBgtsh3pekC9Tmk=
X-Received: by 2002:a63:243:: with SMTP id 64mr49321333pgc.214.1555020191862;
 Thu, 11 Apr 2019 15:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <87ee5fc2175747e1a7cf5b50bad819d4@ausx13mpc124.AMER.DELL.COM>
 <CAO1O6seYhTMHrgCQ+9gPCo_UOtXfhh9mRCVoUosP_Eq0FXD=sw@mail.gmail.com> <bcaa44382c80428ba59b743678be0b18@ausx13mpc120.AMER.DELL.COM>
In-Reply-To: <bcaa44382c80428ba59b743678be0b18@ausx13mpc120.AMER.DELL.COM>
From:   Emil Lenngren <emil.lenngren@gmail.com>
Date:   Fri, 12 Apr 2019 00:03:00 +0200
Message-ID: <CAO1O6sebmS8P0EVVL=U+eFFq+u0NdtbHUP0dO1D+LPa4vXOWqg@mail.gmail.com>
Subject: Re: Pairing failure with BLE 4.0
To:     YouRen.Chen@dellteam.com,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Cc:     Jared.Dominguez@dell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi You Ren,

Den ons 10 apr. 2019 kl 20:43 skrev <YouRen.Chen@dellteam.com>:
>
> Hello Emil,
>
> > Hi YouRen,
> >
> > Den tis 9 apr. 2019 kl 22:31 skrev <YouRen.Chen@dellteam.com>:
> > >
> > > Hello,
> > >
> > > Recently, I posted a bug report regarding authentication failures when
> > > pairing with BLE 4.0 devices. I was told to raise this issued to the
> > > Bluetooth mailing lists and I hope this is the correct email to contact.
> > > Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1822633
> >
> > Could you please also post the HCI log?
> > In a terminal window, execute "sudo btmon" to start logging. Then try to pair
> > your device (reproduce the issue). The btmon tool should now have printed
> > the HCI packets to stdout.
> >
> > /Emil
>
> I have attached a .snoop file from when I attempted to pair the BLE device, would this be acceptable?

I looked at the log in Wireshark. To summarise it, BlueZ sends a
Pairing Request SMP packet (opcode 0x01):

IO Capability: Keyboard, Display (0x04)
OOB Data Flags: OOB Auth. Data Not Present (0x00)
AuthReq: 0x2d, CT2 Flag, Secure Connection Flag, MITM Flag, Bonding
Flags: Bonding
Max Encryption Key Size: 16
Initiator Key Distribution: 0x0d, Link Key, Signature Key (CSRK),
Encryption Key (LTK)
Responder Key Distribution: 0x0f, Link Key, Signature Key (CSRK),
Encryption Key (LTK)

The peripheral device then sends a Pairing Failed SMP packet (opcode
0x05) containing "Invalid Parameters (0x0a)" as result. The link is
then disconnected due to the failure.

It's clear that the pen misbehaves since it sends Invalid Parameters
as response even though BlueZ indeed sends valid parameters.

Anyway, looking at
https://launchstudio.bluetooth.com/ListingDetails/490, it's clear that
the pen PN557W uses a DA14580 chip, which has a Riviera Waves
Bluetooth stack. Unfortunately I know that this stack contains a bug.
Since it was made for a Bluetooth spec earlier than 4.2, there are
five bits in the Key Distribution fields that are reserved for future
use. Per the 4.0 spec, "Reserved is a 5-bit field that shall be set to
zero and ignored on reception." This bluetooth stack does not follow
this but instead sends a Pairing Failed result with Invalid Parameters
as error code when any bit is nonzero. One of those bits got used in
the 4.2 spec and it's called LinkKey which is a bitfield that's set to
1 if the Link Key (used for Bluetooth classic pairing) should be
derived from the BLE key if the two devices some time in the future
would communicate using Bluetooth Classic. Now of course the pen
doesn't support Bluetooth Classic (that can be seen by looking at the
flags in the advertising data). I reported this bug to the company
making DA14580 more than three years ago and they released a patch
short time thereafter which is included in their latest SDKs.

It seems like Dell neither used the latest DA14580 SDK when the
firmware was written (looking at the publish date of 2016-08-31 in the
Bluetooth listings) nor has released a firmware update for it (since I
assume you have installed it if you there was a newer one?).

Could you try remove these two lines at
https://github.com/torvalds/linux/blob/v5.0/net/bluetooth/smp.c#L693
to see if it works (also make sure by looking at the log later that
those bits were not set in the Key Distribution field)?:
local_dist |= SMP_DIST_LINK_KEY;
remote_dist |= SMP_DIST_LINK_KEY;

We have seen the exact same problem when Android 6 was released.
However they have a workaround that they don't set the LinkKey bit if
they suspect the device doesn't support it. I think they look at the
advertising data which indicates in the flags that it doesn't support
BR/EDR. I think BlueZ should do the same to workaround these
incompatibility issues.

/Emil
