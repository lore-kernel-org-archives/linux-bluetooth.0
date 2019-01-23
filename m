Return-Path: <SRS0=X26K=P7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBE1C282C0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jan 2019 12:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D76B22183F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jan 2019 12:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsXJEQo2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfAWM4X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:56:23 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33389 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfAWM4W (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Jan 2019 07:56:22 -0500
Received: by mail-ot1-f67.google.com with SMTP id i20so1824234otl.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jan 2019 04:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cbFHhVk88/X+tW0xO6NsSA2swrG5h2LkDhWdIfrgF7A=;
        b=RsXJEQo2Tx98Fw/CGKIwfPPehucgR2kxUdavAAQJIyFX4Mls8nC58eWTe9oWAGhuWd
         TJIRz0Acb0ZMRqZqNd5JT5j2jbyOkHmW0gqO19ZiFSOZ7ekDiUZxHedFCu+gE/85tPZj
         HLhJmX/7YfyRYANj2hJbCWLz2NjULTytl/yzXE0WNvHNfY3hsH7u/beMkFsZqEGffQeS
         WibyAPeTw0NCjuImK3lqn2EkLgsiMjFqiTHrL7vcizo7DNSsOJDEuTtJwlviyJgmtroG
         2dFIRnFo1+3mt4xnH4Dva5kBe6QVzMiaugKd2yQwZVQ5mSehweZXeFySP8sv0CNqv5SX
         4OxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cbFHhVk88/X+tW0xO6NsSA2swrG5h2LkDhWdIfrgF7A=;
        b=IPHafWXa+7jrBQDkpHpyh9wLRsn/0Ak6e2GKMGMEjK7YgdTc7/Hc6obRdFjfx21Yn3
         fyAEXyFcbVZKO+JbfRcRiQNjWPvVsLfw2kOkjWmDg8MSM1O+BuZgxkEereTOfoJEhGDf
         00Cg5zBshoVTmaDpoZNNJ9GB14ruvNSU005G+TUjLtUTgc6ACzZNhE2VCYtdzhU6b642
         Y3CUxZpybLbrpKQXsiWyLZ1N3RFlYBvgTlx9p7Azbn6n5rz7LclChIJ61/55/RDqK9uM
         K+2cLvTBwieV5HWu42n/mFkKCPddRZUPgD9Ho4eaAKLdMy4qopHG11zbdT2Om1XVTIs+
         Cycg==
X-Gm-Message-State: AJcUuke041Lb9t7Zy52Cdj2+JX7xqGRhfp70u4LT0mw5SZ9hoRFiHZT/
        dwpzlHNeBI5re6R5uOCzcpbyM7EqFcsIrkgWcE0=
X-Google-Smtp-Source: ALg8bN6tfvosc8uJq1A+l0dx3rCDwcVxE0gvcsPguASPOi5+5yfgZ6LOG0pefHRz3briJ0+VTBKYW1zcqwta9abeRjI=
X-Received: by 2002:a9d:3d0:: with SMTP id f74mr1325597otf.52.1548248181555;
 Wed, 23 Jan 2019 04:56:21 -0800 (PST)
MIME-Version: 1.0
References: <CAAOqupzadB0Nmo=WMRwD1AetRtuqGwA2OYryeVzyGgZT90KNYQ@mail.gmail.com>
 <CAAOqupwd9MRt8e9MA3FryCPx5obieqaWJt-ng8TBum4nqSgB3g@mail.gmail.com> <CAAOqupx4hqhbYKyDyirgHWScrNSeFw-4z4OC7oRKDx9-yNbtAQ@mail.gmail.com>
In-Reply-To: <CAAOqupx4hqhbYKyDyirgHWScrNSeFw-4z4OC7oRKDx9-yNbtAQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 23 Jan 2019 14:56:07 +0200
Message-ID: <CABBYNZJ-7j_F5w-fso=V--w-G4kN+5Mc-MufHUfeP_jUT0bM+g@mail.gmail.com>
Subject: Re: Cannot pair and connect headset
To:     Grigory Fateyev <gfborn@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Grigory,

Looks like the headset is refusing to pair, perhaps because it
believes it has already been paired, did you remove the device
locally? Perhaps you will need to enter into pairing mode or something
to clear the previous pairing, or you already tried that?

On Wed, Jan 23, 2019 at 8:53 AM Grigory Fateyev <gfborn@gmail.com> wrote:
>
> There are some `btmon` logs, when I try to pair https://pastebin.com/4j7L=
zD2N
>
> PS. Sorry for top quoting!
>
> =D0=B2=D1=82, 22 =D1=8F=D0=BD=D0=B2. 2019 =D0=B3. =D0=B2 10:33, Grigory F=
ateyev <gfborn@gmail.com>:
> >
> > Maybe I need to provide more information, which one? Or it's a wrong
> > place to ask help?
> >
> > =D0=B2=D1=81, 20 =D1=8F=D0=BD=D0=B2. 2019 =D0=B3. =D0=B2 17:09, Grigory=
 Fateyev <gfborn@gmail.com>:
> > >
> > > Hello!
> > >
> > > I have a bluetooth headset SONY MDR-XB650BT and I cannot pair and con=
nect it.
> > >
> > > I got it several months ago and it worked well, I configured it using
> > > blueman-manager but now I cannot.
> > >
> > > Hardware:
> > > 02:00.0 Network controller: Intel Corporation Wireless 7265 (rev 59)
> > > Subsystem: Intel Corporation Dual Band Wireless-AC 7265
> > > Kernel driver in use: iwlwifi
> > > Kernel modules: iwlwifi
> > >
> > > Software:
> > > Debian Stretch 9.6
> > > Linux gregf 4.18.0-0.bpo.1-amd64 #1 SMP Debian 4.18.6-1~bpo9+1
> > > (2018-09-13) x86_64 GNU/Linux
> > > ii  blueman                               2.0.4-1
> > >      amd64        Graphical bluetooth manager
> > > ii  bluetooth                             5.43-2+deb9u1
> > >      all          Bluetooth support
> > > ii  bluez                                 5.43-2+deb9u1
> > >      amd64        Bluetooth tools and daemons
> > > ii  bluez-firmware                        1.2-3
> > >      all          Firmware for Bluetooth devices
> > > ii  bluez-hcidump                         5.43-2+deb9u1
> > >      amd64        Analyses Bluetooth HCI packets
> > > ii  bluez-obexd                           5.43-2+deb9u1
> > >      amd64        bluez obex daemon
> > > ii  bluez-tools                           0.2.0~20140808-5+b2
> > >      amd64        Set of tools to manage Bluetooth devices for linux
> > > ii  libbluetooth3:amd64                   5.43-2+deb9u1
> > >      amd64        Library to use the BlueZ Linux Bluetooth stack
> > > ii  pulseaudio-module-bluetooth           10.0-1+deb9u1
> > >      amd64        Bluetooth module for PulseAudio sound server
> > > ii  python-bluez                          0.22-1
> > >      amd64        Python wrappers around BlueZ for rapid bluetooth
> > > development
> > >
> > > This is part of my logs: https://pastebin.com/xPnm6SgW
> > >
> > > I'm trying to do it via `bluetoothctl` but get something like:
> > > [bluetooth]# info 00:18:09:C5:44:1E
> > > Device 00:18:09:C5:44:1E
> > > Name: MDR-XB650BT
> > > Alias: MDR-XB650BT
> > > Class: 0x240404
> > > Icon: audio-card
> > > Paired: no
> > > Trusted: no
> > > Blocked: no
> > > Connected: no
> > > LegacyPairing: no
> > > UUID: Headset                   (00001108-0000-1000-8000-00805f9b34fb=
)
> > > UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b34fb=
)
> > > UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb=
)
> > > UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb=
)
> > > UUID: Handsfree                 (0000111e-0000-1000-8000-00805f9b34fb=
)
> > > [bluetooth]# agent on
> > > Agent registered
> > > [bluetooth]# trust 00:18:09:C5:44:1E
> > > [CHG] Device 00:18:09:C5:44:1E Trusted: yes
> > > Changing 00:18:09:C5:44:1E trust succeeded
> > > [bluetooth]# pair 00:18:09:C5:44:1E
> > > Attempting to pair with 00:18:09:C5:44:1E
> > > [CHG] Device 00:18:09:C5:44:1E Connected: yes
> > > Failed to pair: org.bluez.Error.AuthenticationFailed
> > > [CHG] Device 00:18:09:C5:44:1E Connected: no
> > > [CHG] Device 00:18:09:C5:44:1E Connected: yes
> > > [CHG] Device 00:18:09:C5:44:1E Connected: no
> > > [bluetooth]# pair 00:18:09:C5:44:1E
> > > Attempting to pair with 00:18:09:C5:44:1E
> > > [CHG] Device 00:18:09:C5:44:1E Connected: yes
> > > Failed to pair: org.bluez.Error.AuthenticationFailed
> > > [CHG] Device 00:18:09:C5:44:1E Connected: no
> > >
> > > I'm sure it works but how to detect the reason why it cannot now, I
> > > got out of my hairs. Could you help me, please?
> > >
> > > Thank you!
>
>
>
> --
> --
> Grigory



--=20
Luiz Augusto von Dentz
