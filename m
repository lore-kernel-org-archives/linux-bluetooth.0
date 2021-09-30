Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBDEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Sep 2021 08:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33199615A7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Sep 2021 08:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349210AbhI3IeJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Sep 2021 04:34:09 -0400
Received: from mail.flinny.org ([145.239.104.49]:58311 "EHLO mail.flinny.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349240AbhI3IeB (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Sep 2021 04:34:01 -0400
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Sep 2021 04:34:00 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.flinny.org (Postfix) with ESMTP id 8D27C210BD;
        Thu, 30 Sep 2021 08:23:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at flinny.org
Received: from mail.flinny.org ([127.0.0.1])
        by localhost (mail.flinny.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vG642tgy5d62; Thu, 30 Sep 2021 08:23:08 +0000 (UTC)
Received: from rampage.fritz.box (overkill.flinny.org [62.3.65.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mail.flinny.org (Postfix) with ESMTPSA id 03DD92105D;
        Thu, 30 Sep 2021 08:23:06 +0000 (UTC)
From:   Nicholas Flintham <nick@flinny.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-bluetooth@vger.kernel.org,
        Nicholas Flintham <nick@flinny.org>
Subject: [PATCH] Bluetooth: btusb: Add support for TP-Link UB500 Adapter
Date:   Thu, 30 Sep 2021 09:22:39 +0100
Message-Id: <20210930082239.3699395-1-nick@flinny.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add support for TP-Link UB500 Adapter (RTL8761B)

* /sys/kernel/debug/usb/devices
T:  Bus=01 Lev=02 Prnt=05 Port=01 Cnt=01 Dev#= 78 Spd=12   MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=2357 ProdID=0604 Rev= 2.00
S:  Manufacturer=
S:  Product=TP-Link UB500 Adapter
S:  SerialNumber=E848B8C82000
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

Signed-off-by: Nicholas Flintham <nick@flinny.org>
---
 drivers/bluetooth/btusb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 60d2fce59a71..79d0db542da3 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -433,6 +433,10 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0bda, 0xb009), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x2ff8, 0xb011), .driver_info = BTUSB_REALTEK },
 
+	/* Additional Realtek 8761B Bluetooth devices */
+	{ USB_DEVICE(0x2357, 0x0604), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+
 	/* Additional Realtek 8761BU Bluetooth devices */
 	{ USB_DEVICE(0x0b05, 0x190e), .driver_info = BTUSB_REALTEK |
 	  					     BTUSB_WIDEBAND_SPEECH },
-- 
2.32.0

