Return-Path: <SRS0=0zex=D6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA0EC388F9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Oct 2020 23:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A9D22168B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Oct 2020 23:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pidancet.net header.i=@pidancet.net header.b="HJVomx8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758717AbgJWX0F (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Oct 2020 19:26:05 -0400
Received: from mail.pidancet.net ([163.172.153.181]:50691 "EHLO
        mail.pidancet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754902AbgJWX0E (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Oct 2020 19:26:04 -0400
X-Greylist: delayed 458 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Oct 2020 19:26:04 EDT
Received: from authenticated-user (mail.pidancet.net [163.172.153.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.pidancet.net (Postfix) with ESMTPSA id 902049F36E;
        Fri, 23 Oct 2020 23:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pidancet.net; s=mail;
        t=1603495104; bh=Zi7ZEtbeXm3wibd69GIFBp2N7FvIRaZpMNEAE1zfZV4=;
        h=From:To:Cc:Subject:Date:From;
        b=HJVomx8+FwOJnUACNjvrlSw74QGPkrP1PvS5WdwQOmI9ZOese2s2bbrp7EzRk5CMO
         rESUdCSpF9I0588QD9Ou8kAzZb0gAnUQMs0tNoEM+mNs+klxMjOKPY+uMJNDFSctrn
         Fe2R7RZBuUCwDt+4giRv1jbemQYtjhR+HwrKL0+RpAKwoPm1k3HYGz3LKJSRFEzxW4
         zaTbSGfzIRcfwOkT3KLjcey6Emfrs3JESvf5MAExp2NDpum7M1ZR6knTIfsSioLIQ1
         AE+s9BOwrJ4YNwgf0K3B1AmZIt6IqWpxN9VktU5wLYrpC+82WBrDsnQA0IUgNloS3h
         X6PeOpgxIvTWQ==
From:   julian@pidancet.net
To:     linux-bluetooth@vger.kernel.org
Cc:     Julian Pidancet <julian@pidancet.net>
Subject: [PATCH] Bluetooth: btusb: Add support for 1358:c123 Realtek 8822CE device
Date:   Sat, 24 Oct 2020 01:17:48 +0200
Message-Id: <20201023231748.56519-1-julian@pidancet.net>
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
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1005b6e8f..0f40d185d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -427,6 +427,7 @@ static const struct usb_device_id blacklist_table[] = {
 	/* Additional Realtek 8822CE Bluetooth devices */
 	{ USB_DEVICE(0x04ca, 0x4005), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3548), .driver_info = BTUSB_REALTEK },
+	{ USB_DEVICE(0x1358, 0xc123), .driver_info = BTUSB_REALTEK },
 
 	/* Silicon Wave based devices */
 	{ USB_DEVICE(0x0c10, 0x0000), .driver_info = BTUSB_SWAVE },
-- 
Julian Pidancet

