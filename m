Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF905C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Nov 2020 16:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 506E720789
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Nov 2020 16:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pidancet.net header.i=@pidancet.net header.b="dLtS/fu7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730632AbgKIQro (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Nov 2020 11:47:44 -0500
Received: from mail.pidancet.net ([163.172.153.181]:46571 "EHLO
        mail.pidancet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730450AbgKIQro (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Nov 2020 11:47:44 -0500
Received: from authenticated-user (mail.pidancet.net [163.172.153.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.pidancet.net (Postfix) with ESMTPSA id 65CD89F36E;
        Mon,  9 Nov 2020 16:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pidancet.net; s=mail;
        t=1604940461; bh=tgiECD+5E5yF8Qr0w7CpIbiFA6KS9yzSS+wQAVkuKgg=;
        h=From:To:Cc:Subject:Date:From;
        b=dLtS/fu7DgetFu/OHPw2aGVeKkAVc8AUlDH559wIB+B7UnQXW19IKqJMgfYA9XOiI
         FsHUmn1pU4LiATeCnmcleWlXmKmqTQa/iWqvFHZBfiMmKSXBhuK9blUjgtRRrcu6Nx
         XAXoZdRjecOUnVHNJ52qOSA+zmiV+etC5XUBKNO10VUVlASttxXfWUEe91KnZGU9g4
         ru1Ua+GvhoRXwYveLir0wfhmtR/Z8DnJ9qIQXxmTYrgyL30e+ZEn+/116/Hj9jvxxO
         z0Pu9yOcbdDJZ43KCD2OA4ojV3YAvkoHWBb6KJKmvnmct0Wrqgd8XHShRasEWGT99F
         vch0iWhHYDjwA==
From:   julian@pidancet.net
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     Julian Pidancet <julian@pidancet.net>
Subject: [PATCH v2] Bluetooth: btusb: Add support for 1358:c123 Realtek 8822CE device
Date:   Mon,  9 Nov 2020 17:47:22 +0100
Message-Id: <20201109164722.23501-1-julian@pidancet.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Julian Pidancet <julian@pidancet.net>

Huawei Matebook 13 2020 AMD laptops (and probably other Matebook models)
are equiped with a RTL8822CE chip using the 1358:c123 USB identifiers.
This patch adds firmware loading support for it.

T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=1358 ProdID=c123 Rev= 0.00
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
Signed-off-by: Julian Pidancet <julian@pidancet.net>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4a1f877616d6..8c04727dfb29 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -441,6 +441,8 @@ static const struct usb_device_id blacklist_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x2ff8, 0x3051), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x1358, 0xc123), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Silicon Wave based devices */
 	{ USB_DEVICE(0x0c10, 0x0000), .driver_info = BTUSB_SWAVE },
-- 
2.27.0

