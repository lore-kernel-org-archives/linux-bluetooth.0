Return-Path: <SRS0=7lkf=2P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01818C2D0DA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Dec 2019 13:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C765D2072A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Dec 2019 13:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8gmP8yt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfLYNDN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Dec 2019 08:03:13 -0500
Received: from mail-il1-f175.google.com ([209.85.166.175]:46172 "EHLO
        mail-il1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfLYNDM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Dec 2019 08:03:12 -0500
Received: by mail-il1-f175.google.com with SMTP id t17so18411431ilm.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Dec 2019 05:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7b08XDR+AbC+lQYeeWAZ3Z/WeAZB70qkpNf1wpnsJ0Y=;
        b=R8gmP8ytAPPd7uGgRXX3C8Z7JqkIKnsNqZ9qwqOBawqn0Pt8JexeacwiG07rbtd3Ct
         ywmW4IU+2VskxkoX+YTeH2rJ2BIZC6g5QGOBwYTAmFd6S8Um91khNKMw3Y03s/0TYjLY
         8h/Tz4QS/pNsxw5z3yetvanl52wr8AF56FBO1qMFAp3HaoctttIgg2v6v9pY8oicEdSD
         GZVqHM4xR+YOMGc0V3vnTH7horJ6tmRsCrOz5xs4ip4bRmDN0sx6a9fTtyyuH/ACuTjM
         LqIOr//K22SWt1Kr2W1/HtzlTofKRA5ePuCTzlial3POEkCn2AT7sdTwsDab7r/9VbtN
         h5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7b08XDR+AbC+lQYeeWAZ3Z/WeAZB70qkpNf1wpnsJ0Y=;
        b=ij9G8R2qQDj6XTffx1wTC7ajR612NOUYFm7dli0Mbl73pcbzuho/HjkTJIIHVScg2A
         HAygW1Yqov6dtg7YzxIkg+L1IHxYBlWsIP2sMDn7x8ARYjp03abFz+FgxPIMusKpM8gc
         jV3cizzd+HdBLLVxqHEZxeTkk/Kk91LctCZHDH6TDZFULzs+LLoxYu7ps/VdLnEWenC0
         9Vy3yyVxf/sS71Mc8VhUK8C0qrh0X55+EM3kcr272h60x/MIrzG9x1TIzqwiWfWbfKVe
         8g9aeDVi84a3lVObl/yS0wB7+kYEMjKdW9b5qkHEoIlFThj9RIDURNHMLB7zwF62oY3v
         1ktA==
X-Gm-Message-State: APjAAAUN0B7bIzdZbx5d5cMuKGC1NNqkxjSexhgRMic4lXAqEvRcfPIo
        qizhhGZ96AOpfJSyPkjs53iCDP7cQj2slnXG8PPByA==
X-Google-Smtp-Source: APXvYqwWaEOA+3USiXkdgDCdKsLaLTMuqHt4GY/VRZ5+hfh3jpAlGwUJRSiytpMeJ3UvktUGd22B4AcoBYiaqAUQsmM=
X-Received: by 2002:a92:8311:: with SMTP id f17mr35924368ild.82.1577278992077;
 Wed, 25 Dec 2019 05:03:12 -0800 (PST)
MIME-Version: 1.0
References: <CAD-V9V03cvgp_1W_vjV5GeAyXp+KxaG-8so++8bvSf-zyL07bA@mail.gmail.com>
In-Reply-To: <CAD-V9V03cvgp_1W_vjV5GeAyXp+KxaG-8so++8bvSf-zyL07bA@mail.gmail.com>
From:   Caio Vinicius Santesso <caiovss@gmail.com>
Date:   Wed, 25 Dec 2019 13:03:01 +0000
Message-ID: <CAD-V9V1XFROX-mgh9sPVGUZPArH_D5-b2T=qRXB87UrZnROqkg@mail.gmail.com>
Subject: Fwd: Bluetooth: btusb: Additional Realtek 8822CE Bluetooth device
To:     marcel@holtmann.org
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The ASUS TUF Gaming FX505DV_FX505DV laptop contains a Realtek RTL8822CE device.

lsusb output with relevant ID.
Bus 003 Device 002: ID 13d3:3548 IMC Networks Bluetooth Radio

The /sys/kernel/debug/usb/devices portion for this device is:

T:  Bus=03 Lev=01 Prnt=01 Port=03 Cnt=02 Dev#=  2 Spd=12   MxCh= 0
D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3548 Rev= 0.00
S:  Manufacturer=Realtek
S:  Product=Bluetooth Radio
S:  SerialNumber=00e04c000001
C:* #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms

The device was able to scan just some of the Bluetooth devices in
pairing mode while using Linux kernel 5.4.0-9-generic. Dualshock 4
wasn't being identified for instance.

So, I've added the following line (#389)  inside the blacklist_table[]
block to linux-5.4.6/drivers/bluetooth/btusb.c
{ USB_DEVICE(0x13d3, 0x3548), .driver_info = BTUSB_REALTEK },

built it, and copied to the following directory
make -C /lib/modules/5.4.0-9-generic/build M=$PWD modules
sudo cp btusb.ko /lib/modules/5.4.0-9-generic/kernel/drivers/bluetooth/

loaded and reloaded the relevant module.
sudo modprobe -r btusb
sudo modprobe btusb


Now it is working properly.
$ bluetoothctl devices
Device A4:53:85:F5:04:7C Wireless Controller


Caio V. S. Santesso
