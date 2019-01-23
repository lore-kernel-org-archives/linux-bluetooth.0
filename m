Return-Path: <SRS0=X26K=P7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D020C282C0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jan 2019 13:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25BE520870
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jan 2019 13:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUnnNLhE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfAWNff (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Jan 2019 08:35:35 -0500
Received: from mail-io1-f49.google.com ([209.85.166.49]:46591 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfAWNff (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Jan 2019 08:35:35 -0500
Received: by mail-io1-f49.google.com with SMTP id s8so1626903iob.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jan 2019 05:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=3a0QUeN0G/N8ZvIwRTKf+J6Ex9PPoPdvyMYfytUc7Fo=;
        b=HUnnNLhEuVZ+iYMFJX9jKDDb/dju+eIJ+/JA+8BUBIgQj1S7ILJdvomEJGodU+P2qQ
         WUJ7d2/V7Pb5eUglA1GUuxsXEzuvQgkJx+rq6G1rbkSdscjC2+sktTBrlQ5a1ebymAfj
         KDLLiWiPVJA4w+1N7xDr/AKyOmfyaNcjkufNYUjpFo39XVQFVdHLMOWajfVv4+lbH9gl
         +9+gL4FEETbrY1Y1KhRhbBFqyw5J70Vrg7JKcF5MaPbSB/TmBpStWPHtulE3aox4LLWu
         944k2Mx/Zm0DaVzJAhPGC/0mnrrllbO02IQ0RSmPnbGpv0aNCb3F5XDqSTMKDYVNXnJA
         Hz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=3a0QUeN0G/N8ZvIwRTKf+J6Ex9PPoPdvyMYfytUc7Fo=;
        b=OoTt4juwGWxKqt32AUmfUHSLBYMsb5QnLJNc3KONLQjkZecS5m6WqwtNgRBoknUTdQ
         2Og2dIG2nb7CAgIoxCsxD96L6Wt5p9uzqgQwL4DepO21m77nXFuAdq+8SJ8ruwNA/cpZ
         G98zmWqXkQxwPGPdsTcwDiAQteHHofhaoj4T2HAmOQw2Bu6vcy1S+4gSx3Dxn+iS+VVg
         dVNiMydUqnGIFUjkAD9DoPmDJ1IVQ43vmCb9uZb/G/Y1Z9AV77Dd5WxyPfyH0w5gmV0Z
         ddGeTpldnjOxICSSb+abYxVcWcvSl/ox5PzZprWxrzAp2VYSapMpyBzdI7Vqi2+iC2mX
         RwEw==
X-Gm-Message-State: AJcUukccKrcky2xzA+GY24FjOZ19jUsk6CA73J6f+faOlobw0Q5AsQ/g
        iOwZjtoM/zUxz8K6ZYHAowKeevnj993pSMz4Tx78zvWf
X-Google-Smtp-Source: AHgI3IaWnGxYK0nE6nL5oqVmZ3SwQWfI9gOI9Fayy/eSykhhy6Hy+PP77oh7Skgwe3v19QlSSeJ1JsQJzfth3EE9Gy8=
X-Received: by 2002:a6b:b589:: with SMTP id e131mr1094995iof.41.1548250533493;
 Wed, 23 Jan 2019 05:35:33 -0800 (PST)
MIME-Version: 1.0
References: <CAAOqupzadB0Nmo=WMRwD1AetRtuqGwA2OYryeVzyGgZT90KNYQ@mail.gmail.com>
 <CAAOqupwd9MRt8e9MA3FryCPx5obieqaWJt-ng8TBum4nqSgB3g@mail.gmail.com>
 <CAAOqupx4hqhbYKyDyirgHWScrNSeFw-4z4OC7oRKDx9-yNbtAQ@mail.gmail.com> <CABBYNZJ-7j_F5w-fso=V--w-G4kN+5Mc-MufHUfeP_jUT0bM+g@mail.gmail.com>
In-Reply-To: <CABBYNZJ-7j_F5w-fso=V--w-G4kN+5Mc-MufHUfeP_jUT0bM+g@mail.gmail.com>
From:   Grigory Fateyev <gfborn@gmail.com>
Date:   Wed, 23 Jan 2019 16:35:22 +0300
Message-ID: <CAAOqupyE9i8qFpRfvDkHQ4TbJky+04v1k-387+ALRJ6RA+U5dg@mail.gmail.com>
Subject: Re: Cannot pair and connect headset
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Luiz, thank you very much!

Yes, I did a lot of time, but without luck.

[bluetooth]# info 00:18:09:C5:44:1E
Device 00:18:09:C5:44:1E
Name: MDR-XB650BT
Alias: MDR-XB650BT
Class: 0x240404
Icon: audio-card
Paired: no
Trusted: yes
Blocked: no
Connected: no
LegacyPairing: no
UUID: Headset                   (00001108-0000-1000-8000-00805f9b34fb)
UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b34fb)
UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
UUID: Handsfree                 (0000111e-0000-1000-8000-00805f9b34fb)

[...]
> ACL Data RX: Handle 256 flags 0x02 dlen 12                               =
 [hci0] 439.668085
      L2CAP: Disconnection Response (0x07) ident 5 len 4
        Destination CID: 576
        Source CID: 64
> HCI Event: Simple Pairing Complete (0x36) plen 7                         =
 [hci0] 439.672100
        Status: Authentication Failure (0x05)
        Address: 00:18:09:C5:44:1E (CRESYN)
> HCI Event: Auth Complete (0x06) plen 3                                   =
 [hci0] 439.673066
        Status: Authentication Failure (0x05)
        Handle: 256
@ MGMT Event: Authentication Failed (0x0011) plen 8
{0x0002} [hci0] 439.673127
        BR/EDR Address: 00:18:09:C5:44:1E (CRESYN)
        Status: Authentication Failed (0x05)
@ MGMT Event: Authentication Failed (0x0011) plen 8
{0x0001} [hci0] 439.673127
        BR/EDR Address: 00:18:09:C5:44:1E (CRESYN)
        Status: Authentication Failed (0x05)
=3D bluetoothd: connect error: Connection refused (111)
            439.774156
< HCI Command: Disconnect (0x01|0x0006) plen 3
     [hci0] 441.809823
        Handle: 256
        Reason: Remote User Terminated Connection (0x13)
> HCI Event: Command Status (0x0f) plen 4                                  =
 [hci0] 441.812119
      Disconnect (0x01|0x0006) ncmd 1
        Status: Success (0x00)
> HCI Event: Disconnect Complete (0x05) plen 4                             =
 [hci0] 441.829130
        Status: Success (0x00)
        Handle: 256
        Reason: Connection Terminated By Local Host (0x16)
@ MGMT Event: Device Disconnected (0x000c) plen 8

=D1=81=D1=80, 23 =D1=8F=D0=BD=D0=B2. 2019 =D0=B3. =D0=B2 15:56, Luiz August=
o von Dentz <luiz.dentz@gmail.com>:
>
> Hi Grigory,
>
> Looks like the headset is refusing to pair, perhaps because it
> believes it has already been paired, did you remove the device
> locally? Perhaps you will need to enter into pairing mode or something
> to clear the previous pairing, or you already tried that?
>
> On Wed, Jan 23, 2019 at 8:53 AM Grigory Fateyev <gfborn@gmail.com> wrote:
> >
> > There are some `btmon` logs, when I try to pair https://pastebin.com/4j=
7LzD2N
> >
> > PS. Sorry for top quoting!
> >
> > =D0=B2=D1=82, 22 =D1=8F=D0=BD=D0=B2. 2019 =D0=B3. =D0=B2 10:33, Grigory=
 Fateyev <gfborn@gmail.com>:
> > >
> > > Maybe I need to provide more information, which one? Or it's a wrong
> > > place to ask help?
> > >
> > > =D0=B2=D1=81, 20 =D1=8F=D0=BD=D0=B2. 2019 =D0=B3. =D0=B2 17:09, Grigo=
ry Fateyev <gfborn@gmail.com>:
> > > >
> > > > Hello!
> > > >
> > > > I have a bluetooth headset SONY MDR-XB650BT and I cannot pair and c=
onnect it.
> > > >
> > > > I got it several months ago and it worked well, I configured it usi=
ng
> > > > blueman-manager but now I cannot.
> > > >
> > > > Hardware:
> > > > 02:00.0 Network controller: Intel Corporation Wireless 7265 (rev 59=
)
> > > > Subsystem: Intel Corporation Dual Band Wireless-AC 7265
> > > > Kernel driver in use: iwlwifi
> > > > Kernel modules: iwlwifi
> > > >
> > > > Software:
> > > > Debian Stretch 9.6
> > > > Linux gregf 4.18.0-0.bpo.1-amd64 #1 SMP Debian 4.18.6-1~bpo9+1
> > > > (2018-09-13) x86_64 GNU/Linux
> > > > ii  blueman                               2.0.4-1
> > > >      amd64        Graphical bluetooth manager
> > > > ii  bluetooth                             5.43-2+deb9u1
> > > >      all          Bluetooth support
> > > > ii  bluez                                 5.43-2+deb9u1
> > > >      amd64        Bluetooth tools and daemons
> > > > ii  bluez-firmware                        1.2-3
> > > >      all          Firmware for Bluetooth devices
> > > > ii  bluez-hcidump                         5.43-2+deb9u1
> > > >      amd64        Analyses Bluetooth HCI packets
> > > > ii  bluez-obexd                           5.43-2+deb9u1
> > > >      amd64        bluez obex daemon
> > > > ii  bluez-tools                           0.2.0~20140808-5+b2
> > > >      amd64        Set of tools to manage Bluetooth devices for linu=
x
> > > > ii  libbluetooth3:amd64                   5.43-2+deb9u1
> > > >      amd64        Library to use the BlueZ Linux Bluetooth stack
> > > > ii  pulseaudio-module-bluetooth           10.0-1+deb9u1
> > > >      amd64        Bluetooth module for PulseAudio sound server
> > > > ii  python-bluez                          0.22-1
> > > >      amd64        Python wrappers around BlueZ for rapid bluetooth
> > > > development
> > > >
> > > > This is part of my logs: https://pastebin.com/xPnm6SgW
> > > >
> > > > I'm trying to do it via `bluetoothctl` but get something like:
> > > > [bluetooth]# info 00:18:09:C5:44:1E
> > > > Device 00:18:09:C5:44:1E
> > > > Name: MDR-XB650BT
> > > > Alias: MDR-XB650BT
> > > > Class: 0x240404
> > > > Icon: audio-card
> > > > Paired: no
> > > > Trusted: no
> > > > Blocked: no
> > > > Connected: no
> > > > LegacyPairing: no
> > > > UUID: Headset                   (00001108-0000-1000-8000-00805f9b34=
fb)
> > > > UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b34=
fb)
> > > > UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34=
fb)
> > > > UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34=
fb)
> > > > UUID: Handsfree                 (0000111e-0000-1000-8000-00805f9b34=
fb)
> > > > [bluetooth]# agent on
> > > > Agent registered
> > > > [bluetooth]# trust 00:18:09:C5:44:1E
> > > > [CHG] Device 00:18:09:C5:44:1E Trusted: yes
> > > > Changing 00:18:09:C5:44:1E trust succeeded
> > > > [bluetooth]# pair 00:18:09:C5:44:1E
> > > > Attempting to pair with 00:18:09:C5:44:1E
> > > > [CHG] Device 00:18:09:C5:44:1E Connected: yes
> > > > Failed to pair: org.bluez.Error.AuthenticationFailed
> > > > [CHG] Device 00:18:09:C5:44:1E Connected: no
> > > > [CHG] Device 00:18:09:C5:44:1E Connected: yes
> > > > [CHG] Device 00:18:09:C5:44:1E Connected: no
> > > > [bluetooth]# pair 00:18:09:C5:44:1E
> > > > Attempting to pair with 00:18:09:C5:44:1E
> > > > [CHG] Device 00:18:09:C5:44:1E Connected: yes
> > > > Failed to pair: org.bluez.Error.AuthenticationFailed
> > > > [CHG] Device 00:18:09:C5:44:1E Connected: no
> > > >
> > > > I'm sure it works but how to detect the reason why it cannot now, I
> > > > got out of my hairs. Could you help me, please?
> > > >
> > > > Thank you!
> >
> >
> >
> > --
> > --
> > Grigory
>
>
>
> --
> Luiz Augusto von Dentz



--=20
--=20
Grigory
