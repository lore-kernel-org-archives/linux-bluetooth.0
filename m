Return-Path: <SRS0=X26K=P7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E522AC282C2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jan 2019 06:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51F621726
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jan 2019 06:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ollcTRI2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfAWGt7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Jan 2019 01:49:59 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36820 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfAWGtz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Jan 2019 01:49:55 -0500
Received: by mail-it1-f195.google.com with SMTP id c9so1582273itj.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jan 2019 22:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=MhUGm5/06Xr89mB58L93QJT1HkcTtBkbKJW+BWy7eqg=;
        b=ollcTRI2N/Nri5t6VeEVCs0Fqx8D1FAHUotzgQpFFlXIiq4yvJihoPCPC4NBbc2TsS
         h7TTwOGfWDka5w/jSPAJIKeZbv00DxzPhx5bLyQ99shv8uZQIgh8+ta9dPuymtoE0TVD
         brATqDttM/BTnvM71s4Q+i9p03oxhk3JFtd5utstQqBaOFrdCiL5SeY0JHr19GiiiX42
         8bhBszjrpg+keiNDWs3tXAFdg/oi8ttMKmgxXceLfZvCcVt6z5ZZdT7Hhpq1pfaO9j0G
         FBFKNv4B6Nl2Qy7gOmbP/SlaP71DfTcmbyDiZFT/uKI5WPSKqnOkmMSs9yu4VFFXr1oc
         L69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=MhUGm5/06Xr89mB58L93QJT1HkcTtBkbKJW+BWy7eqg=;
        b=BUSbaffUAtjfuS3jl22dk+CjeB5bvzYmHmD02y1k2dueSYKSDM33z0vlg52QZJMvol
         XFc92PLitWG/mSx7+DogovmrJIiF2QRMzZ0GPSXVyoW/t3XT3FJqUNIZ8tNuLIakgdUG
         39dxc/4Hz8ila0+YQpUXmZkcJZc3/rZDJP4LqE8cyoj1rvSdGNYkSc9RjPX3E/acIlUO
         4zICM6MYF8gkERk06iLgyoR5G5uXEcjmsMQhRPTpt1F5rJy/IHuxIA5bbGP6Abgzr2Tg
         gy5XGrEeZj+FaCuZTnCrfHcxeX1Ch+A5mI1cHPCHPvF0k1i9NJNpGAQxo+81y5YtQXyc
         R3NA==
X-Gm-Message-State: AJcUukdz5ZCdB+vcmkcQ7JmzMtzV1tk+Fxkal4D5/wuJ24HqqA+dsaqV
        ysyasKiaWO5DQZomNFAUGyIlTMWxrf6/g4JydFv2nVy4
X-Google-Smtp-Source: ALg8bN6dNUrVItz8/ydU9L8RdxpSByuVGpyRE6/TJaSTK2XftKKq1H3WKM9nlAIzO4/69k3GDPPqmCgVx45PWnjOgXw=
X-Received: by 2002:a24:9b87:: with SMTP id o129mr972832itd.128.1548226194216;
 Tue, 22 Jan 2019 22:49:54 -0800 (PST)
MIME-Version: 1.0
References: <CAAOqupzadB0Nmo=WMRwD1AetRtuqGwA2OYryeVzyGgZT90KNYQ@mail.gmail.com>
 <CAAOqupwd9MRt8e9MA3FryCPx5obieqaWJt-ng8TBum4nqSgB3g@mail.gmail.com>
In-Reply-To: <CAAOqupwd9MRt8e9MA3FryCPx5obieqaWJt-ng8TBum4nqSgB3g@mail.gmail.com>
From:   Grigory Fateyev <gfborn@gmail.com>
Date:   Wed, 23 Jan 2019 09:49:43 +0300
Message-ID: <CAAOqupx4hqhbYKyDyirgHWScrNSeFw-4z4OC7oRKDx9-yNbtAQ@mail.gmail.com>
Subject: Re: Cannot pair and connect headset
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

There are some `btmon` logs, when I try to pair https://pastebin.com/4j7LzD=
2N

PS. Sorry for top quoting!

=D0=B2=D1=82, 22 =D1=8F=D0=BD=D0=B2. 2019 =D0=B3. =D0=B2 10:33, Grigory Fat=
eyev <gfborn@gmail.com>:
>
> Maybe I need to provide more information, which one? Or it's a wrong
> place to ask help?
>
> =D0=B2=D1=81, 20 =D1=8F=D0=BD=D0=B2. 2019 =D0=B3. =D0=B2 17:09, Grigory F=
ateyev <gfborn@gmail.com>:
> >
> > Hello!
> >
> > I have a bluetooth headset SONY MDR-XB650BT and I cannot pair and conne=
ct it.
> >
> > I got it several months ago and it worked well, I configured it using
> > blueman-manager but now I cannot.
> >
> > Hardware:
> > 02:00.0 Network controller: Intel Corporation Wireless 7265 (rev 59)
> > Subsystem: Intel Corporation Dual Band Wireless-AC 7265
> > Kernel driver in use: iwlwifi
> > Kernel modules: iwlwifi
> >
> > Software:
> > Debian Stretch 9.6
> > Linux gregf 4.18.0-0.bpo.1-amd64 #1 SMP Debian 4.18.6-1~bpo9+1
> > (2018-09-13) x86_64 GNU/Linux
> > ii  blueman                               2.0.4-1
> >      amd64        Graphical bluetooth manager
> > ii  bluetooth                             5.43-2+deb9u1
> >      all          Bluetooth support
> > ii  bluez                                 5.43-2+deb9u1
> >      amd64        Bluetooth tools and daemons
> > ii  bluez-firmware                        1.2-3
> >      all          Firmware for Bluetooth devices
> > ii  bluez-hcidump                         5.43-2+deb9u1
> >      amd64        Analyses Bluetooth HCI packets
> > ii  bluez-obexd                           5.43-2+deb9u1
> >      amd64        bluez obex daemon
> > ii  bluez-tools                           0.2.0~20140808-5+b2
> >      amd64        Set of tools to manage Bluetooth devices for linux
> > ii  libbluetooth3:amd64                   5.43-2+deb9u1
> >      amd64        Library to use the BlueZ Linux Bluetooth stack
> > ii  pulseaudio-module-bluetooth           10.0-1+deb9u1
> >      amd64        Bluetooth module for PulseAudio sound server
> > ii  python-bluez                          0.22-1
> >      amd64        Python wrappers around BlueZ for rapid bluetooth
> > development
> >
> > This is part of my logs: https://pastebin.com/xPnm6SgW
> >
> > I'm trying to do it via `bluetoothctl` but get something like:
> > [bluetooth]# info 00:18:09:C5:44:1E
> > Device 00:18:09:C5:44:1E
> > Name: MDR-XB650BT
> > Alias: MDR-XB650BT
> > Class: 0x240404
> > Icon: audio-card
> > Paired: no
> > Trusted: no
> > Blocked: no
> > Connected: no
> > LegacyPairing: no
> > UUID: Headset                   (00001108-0000-1000-8000-00805f9b34fb)
> > UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b34fb)
> > UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
> > UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
> > UUID: Handsfree                 (0000111e-0000-1000-8000-00805f9b34fb)
> > [bluetooth]# agent on
> > Agent registered
> > [bluetooth]# trust 00:18:09:C5:44:1E
> > [CHG] Device 00:18:09:C5:44:1E Trusted: yes
> > Changing 00:18:09:C5:44:1E trust succeeded
> > [bluetooth]# pair 00:18:09:C5:44:1E
> > Attempting to pair with 00:18:09:C5:44:1E
> > [CHG] Device 00:18:09:C5:44:1E Connected: yes
> > Failed to pair: org.bluez.Error.AuthenticationFailed
> > [CHG] Device 00:18:09:C5:44:1E Connected: no
> > [CHG] Device 00:18:09:C5:44:1E Connected: yes
> > [CHG] Device 00:18:09:C5:44:1E Connected: no
> > [bluetooth]# pair 00:18:09:C5:44:1E
> > Attempting to pair with 00:18:09:C5:44:1E
> > [CHG] Device 00:18:09:C5:44:1E Connected: yes
> > Failed to pair: org.bluez.Error.AuthenticationFailed
> > [CHG] Device 00:18:09:C5:44:1E Connected: no
> >
> > I'm sure it works but how to detect the reason why it cannot now, I
> > got out of my hairs. Could you help me, please?
> >
> > Thank you!



--=20
--=20
Grigory
