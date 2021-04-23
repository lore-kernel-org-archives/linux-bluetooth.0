Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0396CC433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Apr 2021 09:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B91FE61352
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Apr 2021 09:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241859AbhDWJur (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Apr 2021 05:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhDWJuq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Apr 2021 05:50:46 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD55BC061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Apr 2021 02:50:09 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u17so73066785ejk.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Apr 2021 02:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=3vMwCGkj9sB7kGGeDCABF8ZqitXvhngnwPLiIaxlWfo=;
        b=IpXTnrKsO5s9Q0i6egOKWpGIRIrr+1mbx/MtXXJUQ8CzD3gNRor37sOiZic17TMb5h
         C15k2V9+3KiKTr5L7nU6jaPjRhKKj/Maz3S6Q0egwOUVPSCOhe8ZO6tCHO1YOw27er24
         pevCmYhnf/ZxOALjuEGQYA/eON1+m0b5/kMPmmidCWev/cGyBXpOlyQolrol+iY1y+1n
         V1eyMsyYPPzcNMIl4UNhVcFsEEKg3vX5S1rp7IBjNysF53z/8swqR3JlO8FzN0oN+0/1
         C5xw4tQUSYBrFNbLI1G+Fa2CAizb7oqQb3VLwpKC8tr9mCHBicdWYUfMk2QRY2AfRWsV
         Vf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3vMwCGkj9sB7kGGeDCABF8ZqitXvhngnwPLiIaxlWfo=;
        b=XbgZdnZLvYeJQv/tz507e3Qv2UFozluVnwGBmwdVaSPzjwzDyXoZIQ6pSZI8B9WXxv
         BQ8JOkW4U/Xec9Syp9eCbH4G4WBQlkiu2F00eSG7oQjCKaKUsDnLJjnjVep5URMw0SdU
         zMJSKWclZ7pBC9ZDr5/CNXuLv94OLGq/ayC7EnIP3ktK4VomOVTZgpcsrr/fw+/etb1J
         NvOv4bjOxnTVS0KCxqNOBZ2RR4KsI3LpBDimc0aYc+H99ZZbBcCg4n+P7QekAfB5TUF8
         Y9rrD22WA39kC1Dd7Ye9Aw09qT37UVDVvO7hayJ++N09siI98V9wp5235k3YeiXnLYYQ
         /4ZA==
X-Gm-Message-State: AOAM5337zOFbxhJzYZZWz9xfIUg0+9EPU52x0F/mAVekVuSBB02Zfbru
        qYtPUI8h4KLoba3X08pC8V/2Co1P3VfYlPAobxp6mF3n3ONxzg==
X-Google-Smtp-Source: ABdhPJzUTgI1b9eJ6BYcxmfG939V96N6hih/Tiwws17U8HrjcDBrrlMRy2MVTndO7c3lv5vCAmk2m/CesMF+9W/QoWo=
X-Received: by 2002:a17:906:a20b:: with SMTP id r11mr3305092ejy.323.1619171408528;
 Fri, 23 Apr 2021 02:50:08 -0700 (PDT)
MIME-Version: 1.0
From:   Ian Mackinnon <imackinnon@gmail.com>
Date:   Fri, 23 Apr 2021 11:49:57 +0200
Message-ID: <CAK+oUyY+hnYjCmAO-ETRCyuZcNv0w=4oS5gbdgAu95ymJxHj5A@mail.gmail.com>
Subject: Load Broadcom firmware patch for 413c:8197
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

413c:8197 is a Dell-branded Broadcom BCM20702 device which requires
the patch `BCM20702A1-413c-8197.hcd`[1] to be loaded in order for
HSP/HFP functionality to work.

Currently this device is listed early on in `btusb_table` as not
requiring patchram. If that entry is removed the device is correctly
handled by the later `USB_VENDOR_AND_INTERFACE_INFO` entry marking all
Dell (413c) devices as requiring patchram.

Patch:

--
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5cbfbd948f6..2d24231f898 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -119,9 +119,6 @@ static const struct usb_device_id btusb_table[] = {
  /* Canyon CN-BTU1 with HID interfaces */
  { USB_DEVICE(0x0c10, 0x0000) },

- /* Broadcom BCM20702A0 */
- { USB_DEVICE(0x413c, 0x8197) },
-
  /* Broadcom BCM20702B0 (Dynex/Insignia) */
  { USB_DEVICE(0x19ff, 0x0239), .driver_info = BTUSB_BCM_PATCHRAM },

--

Relevant slice of `/sys/kernel/debug/usb/devices`:

--
T:  Bus=01 Lev=02 Prnt=02 Port=03 Cnt=02 Dev#=  4 Spd=12   MxCh= 0
D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=413c ProdID=8197 Rev= 1.12
S:  Manufacturer=Broadcom Corp
S:  Product=BCM20702A0
S:  SerialNumber=74E54354F609
C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=btusb
E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)
--


[1]: https://github.com/winterheart/broadcom-bt-firmware/blob/master/brcm/BCM20702A1-413c-8197.hcd
