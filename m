Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69859C001B2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Dec 2022 20:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiLPUNB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Dec 2022 15:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiLPUM7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Dec 2022 15:12:59 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A97835FBA8
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Dec 2022 12:12:53 -0800 (PST)
Received: from fedora.. (p4fefca0f.dip0.t-ipconnect.de [79.239.202.15])
        by mail.holtmann.org (Postfix) with ESMTPSA id CA11DCECCA
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Dec 2022 21:12:52 +0100 (CET)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix issue with Actions Semi ATS2851 based devices
Date:   Fri, 16 Dec 2022 21:12:47 +0100
Message-Id: <20221216201247.297210-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Their devices claim to support the erroneous data reporting, but don't
actually support the required commands. So blacklist them and add a
quirk.

  < HCI Command: Read Default Erroneous Data Reporting (0x03|0x005a) plen 0
  > HCI Event: Command Status (0x0f) plen 4
        Read Default Erroneous Data Reporting (0x03|0x005a) ncmd 1
          Status: Unknown HCI Command (0x01)

T:  Bus=02 Lev=02 Prnt=08 Port=02 Cnt=01 Dev#= 10 Spd=12   MxCh= 0
D:  Ver= 2.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=10d7 ProdID=b012 Rev=88.91
S:  Manufacturer=Actions
S:  Product=general adapter
S:  SerialNumber=ACTIONS1234
C:* #Ifs= 2 Cfg#= 1 Atr=c0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=01(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=01(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=01(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=01(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=01(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=01(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2ad4efdd9e40..afd2f08ffe30 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -64,6 +64,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_INTEL_BROKEN_SHUTDOWN_LED	BIT(24)
 #define BTUSB_INTEL_BROKEN_INITIAL_NCMD BIT(25)
 #define BTUSB_INTEL_NO_WBS_SUPPORT	BIT(26)
+#define BTUSB_ACTIONS_SEMI		BIT(27)
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -677,6 +678,9 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0cb5, 0xc547), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 
+	/* Actions Semiconductor ATS2851 based devices */
+	{ USB_DEVICE(0x10d7, 0xb012), .driver_info = BTUSB_ACTIONS_SEMI },
+
 	/* Silicon Wave based devices */
 	{ USB_DEVICE(0x0c10, 0x0000), .driver_info = BTUSB_SWAVE },
 
@@ -4098,6 +4102,11 @@ static int btusb_probe(struct usb_interface *intf,
 		set_bit(BTUSB_USE_ALT3_FOR_WBS, &data->flags);
 	}
 
+	if (id->driver_info & BTUSB_ACTIONS_SEMI) {
+		/* Support is advertised, but not implemented */
+		set_bit(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING, &hdev->quirks);
+	}
+
 	if (!reset)
 		set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
 
-- 
2.38.1

