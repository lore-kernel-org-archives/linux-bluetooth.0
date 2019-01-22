Return-Path: <SRS0=wtFT=P6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF86C282C3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 07:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBB620861
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 07:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8pa0uy7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfAVHd0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Jan 2019 02:33:26 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:40904 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfAVHd0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Jan 2019 02:33:26 -0500
Received: by mail-it1-f196.google.com with SMTP id h193so18804593ita.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jan 2019 23:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=JymwwGqI9+O9tsHzNv9CCxv8BfDehjcmsopRCVDmYKg=;
        b=Y8pa0uy7ws3Pvm6dm3Hwc9eNK2qFRQyZcD1tLDI9bsauE/Z7xhQoD5BNLYrs7iw7g9
         fCK/1WQViiVd0jsfcZbo/00DkC220rYfb+lfssSnPoYnbhXdwXvXRxJMSIwkyadhUO6V
         +brEvLvJc6/WYgModEZu/m/0m6KW0K7VxB4R2Vzjnn3iZOcKjRyWcffSxaf4PJw3sHLJ
         RhT0HXmW91POOurT13c3sSUCWHC3u5aOd6ukYX+hKTlrBimP2YlwYcG/yIXv9SwyhLuy
         CEJBcrOps0CJ+hERxhuVA2zLByJqJJHO/L/l8Sb5hcE1LZbEcBtaXwA1uKUkLn9Gl2lD
         pKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=JymwwGqI9+O9tsHzNv9CCxv8BfDehjcmsopRCVDmYKg=;
        b=h6ys7Ey0WCZ17Wl94+5sIuSAquxeoLVp4PVqA4N6aV8ahvKi5iCzYw9ijumGOi6LJT
         887hJ8DEpSVRONvHIfOI6i+JX5sOpwPDhQgMFqOK4gPlebdig3ZuZBvLhdCXC6XNmiLq
         amAjgOzxi3gnAuQkd+4Ps3g8OpTLgjSZ0RuC54LKdVFruIrQcUSpxV9rPVO+BMmOXY+a
         zVkKOF0LCEwXenZCibuHouI+HHyxiAvz+9DSpAduyeX6aovILaI9KtciwEMkEe7PwMT/
         OXm/EODoY4P+UX5QSjc/GbWx//kuybRviwNba7zHtbzqkjyue2L2L2AVaTx0xD7BHIO5
         D5Gw==
X-Gm-Message-State: AJcUuke9DNxUKM5ZydXhMyxqlSCdJ7wAmqgatXIs/y1X+6KcmU3UFbiI
        iXK0HXqm4C188GJAjts+g1ovsP7j31gbRNabEqnAuQ==
X-Google-Smtp-Source: ALg8bN6ZQ+dWoNXykBQTWfBisl4MGATtxQZkaDPjo0DJnvgwzo9YsUABh3LYGR1TgPWHMJ5+NAOXP4TppRZH1jQXPM0=
X-Received: by 2002:a02:8904:: with SMTP id o4mr19065444jaj.35.1548142404937;
 Mon, 21 Jan 2019 23:33:24 -0800 (PST)
MIME-Version: 1.0
References: <CAAOqupzadB0Nmo=WMRwD1AetRtuqGwA2OYryeVzyGgZT90KNYQ@mail.gmail.com>
In-Reply-To: <CAAOqupzadB0Nmo=WMRwD1AetRtuqGwA2OYryeVzyGgZT90KNYQ@mail.gmail.com>
From:   Grigory Fateyev <gfborn@gmail.com>
Date:   Tue, 22 Jan 2019 10:33:14 +0300
Message-ID: <CAAOqupwd9MRt8e9MA3FryCPx5obieqaWJt-ng8TBum4nqSgB3g@mail.gmail.com>
Subject: Re: Cannot pair and connect headset
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Maybe I need to provide more information, which one? Or it's a wrong
place to ask help?

=D0=B2=D1=81, 20 =D1=8F=D0=BD=D0=B2. 2019 =D0=B3. =D0=B2 17:09, Grigory Fat=
eyev <gfborn@gmail.com>:
>
> Hello!
>
> I have a bluetooth headset SONY MDR-XB650BT and I cannot pair and connect=
 it.
>
> I got it several months ago and it worked well, I configured it using
> blueman-manager but now I cannot.
>
> Hardware:
> 02:00.0 Network controller: Intel Corporation Wireless 7265 (rev 59)
> Subsystem: Intel Corporation Dual Band Wireless-AC 7265
> Kernel driver in use: iwlwifi
> Kernel modules: iwlwifi
>
> Software:
> Debian Stretch 9.6
> Linux gregf 4.18.0-0.bpo.1-amd64 #1 SMP Debian 4.18.6-1~bpo9+1
> (2018-09-13) x86_64 GNU/Linux
> ii  blueman                               2.0.4-1
>      amd64        Graphical bluetooth manager
> ii  bluetooth                             5.43-2+deb9u1
>      all          Bluetooth support
> ii  bluez                                 5.43-2+deb9u1
>      amd64        Bluetooth tools and daemons
> ii  bluez-firmware                        1.2-3
>      all          Firmware for Bluetooth devices
> ii  bluez-hcidump                         5.43-2+deb9u1
>      amd64        Analyses Bluetooth HCI packets
> ii  bluez-obexd                           5.43-2+deb9u1
>      amd64        bluez obex daemon
> ii  bluez-tools                           0.2.0~20140808-5+b2
>      amd64        Set of tools to manage Bluetooth devices for linux
> ii  libbluetooth3:amd64                   5.43-2+deb9u1
>      amd64        Library to use the BlueZ Linux Bluetooth stack
> ii  pulseaudio-module-bluetooth           10.0-1+deb9u1
>      amd64        Bluetooth module for PulseAudio sound server
> ii  python-bluez                          0.22-1
>      amd64        Python wrappers around BlueZ for rapid bluetooth
> development
>
> This is part of my logs: https://pastebin.com/xPnm6SgW
>
> I'm trying to do it via `bluetoothctl` but get something like:
> [bluetooth]# info 00:18:09:C5:44:1E
> Device 00:18:09:C5:44:1E
> Name: MDR-XB650BT
> Alias: MDR-XB650BT
> Class: 0x240404
> Icon: audio-card
> Paired: no
> Trusted: no
> Blocked: no
> Connected: no
> LegacyPairing: no
> UUID: Headset                   (00001108-0000-1000-8000-00805f9b34fb)
> UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b34fb)
> UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
> UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
> UUID: Handsfree                 (0000111e-0000-1000-8000-00805f9b34fb)
> [bluetooth]# agent on
> Agent registered
> [bluetooth]# trust 00:18:09:C5:44:1E
> [CHG] Device 00:18:09:C5:44:1E Trusted: yes
> Changing 00:18:09:C5:44:1E trust succeeded
> [bluetooth]# pair 00:18:09:C5:44:1E
> Attempting to pair with 00:18:09:C5:44:1E
> [CHG] Device 00:18:09:C5:44:1E Connected: yes
> Failed to pair: org.bluez.Error.AuthenticationFailed
> [CHG] Device 00:18:09:C5:44:1E Connected: no
> [CHG] Device 00:18:09:C5:44:1E Connected: yes
> [CHG] Device 00:18:09:C5:44:1E Connected: no
> [bluetooth]# pair 00:18:09:C5:44:1E
> Attempting to pair with 00:18:09:C5:44:1E
> [CHG] Device 00:18:09:C5:44:1E Connected: yes
> Failed to pair: org.bluez.Error.AuthenticationFailed
> [CHG] Device 00:18:09:C5:44:1E Connected: no
>
> I'm sure it works but how to detect the reason why it cannot now, I
> got out of my hairs. Could you help me, please?
>
> Thank you!
