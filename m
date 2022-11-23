Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDA0C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Nov 2022 08:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236460AbiKWIRz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Nov 2022 03:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236472AbiKWIRx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Nov 2022 03:17:53 -0500
X-Greylist: delayed 460 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Nov 2022 00:17:51 PST
Received: from forward104o.mail.yandex.net (forward104o.mail.yandex.net [37.140.190.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEEA13F72
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Nov 2022 00:17:49 -0800 (PST)
Received: from iva8-56bd2512c3ca.qloud-c.yandex.net (iva8-56bd2512c3ca.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:a8a6:0:640:56bd:2512])
        by forward104o.mail.yandex.net (Yandex) with ESMTP id 1D03965D3A09
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Nov 2022 11:10:06 +0300 (MSK)
Received: by iva8-56bd2512c3ca.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id 5AitUF1VA4Y1-QFWlsy1l;
        Wed, 23 Nov 2022 11:10:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1669191005;
        bh=5ltUlEkZ0pW7LNo462g3rAM6u1xeRrzl2sP+R2/dYJ0=;
        h=Message-Id:Date:Subject:To:From;
        b=rSnhw/WCALQ4FJhOiAAofPcnfkSG37cHHT7nqpaKzEaJ/nqPlUqGKcMGtxkCBw3ub
         X4NMTwL/brvhoEsHDw1xI14ZhQTQnF0vFaskF2zvW6OHy+lgmxzStvVLrK6+R9+Oum
         YnqIHY2LmEGcAr54qPKWwgScHqTEZASSErGf8hkA=
Authentication-Results: iva8-56bd2512c3ca.qloud-c.yandex.net; dkim=pass header.i=@ya.ru
From:   Artem Lukyanov <dukzcry@ya.ru>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x0cb8:0xc559
Date:   Wed, 23 Nov 2022 11:10:05 +0300
Message-Id: <20221123081005.70536-1-dukzcry@ya.ru>
X-Mailer: git-send-email 2.36.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add the support ID(0x0cb8, 0xc559) to usb_device_id table for
Realtek RTL8852BE.

The device info from /sys/kernel/debug/usb/devices as below.

T:  Bus=03 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0cb8 ProdID=c559 Rev= 0.00
S:  Manufacturer=Realtek
S:  Product=Bluetooth Radio
S:  SerialNumber=00e04c000001
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
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

Signed-off-by: Artem Lukyanov <dukzcry@ya.ru>
---
 drivers/bluetooth/btusb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 271963805..f10d73d5b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -443,6 +443,10 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x13d3, 0x3592), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 
+	/* Realtek 8852BE Bluetooth devices */
+	{ USB_DEVICE(0x0cb8, 0xc559), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+
 	/* Realtek Bluetooth devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
 	  .driver_info = BTUSB_REALTEK },
-- 
2.36.2

