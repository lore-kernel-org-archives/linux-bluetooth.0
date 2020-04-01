Return-Path: <SRS0=i/J9=5R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8FEC18E5B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 15:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27E120B1F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 15:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733186AbgDAP7c (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Apr 2020 11:59:32 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:59063 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733088AbgDAP7c (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Apr 2020 11:59:32 -0400
Received: from localhost.localdomain (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 0A4A3CECDF
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2020 18:09:03 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/3] Bluetooth: btusb: Enable MSFT extension for Intel ThunderPeak devices
Date:   Wed,  1 Apr 2020 17:59:23 +0200
Message-Id: <20200401155923.485359-3-marcel@holtmann.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Miao-chen Chou <mcchou@chromium.org>

The Intel ThundePeak BT controllers support the Microsoft vendor
extension and they are using 0xFC1E for VsMsftOpCode.

< HCI Command: Vendor (0x3f|0x001e) plen 1
        00
> HCI Event: Command Complete (0x0e) plen 15
      Vendor (0x3f|0x001e) ncmd 1
        Status: Success (0x00)
        00 3f 00 00 00 00 00 00 00 01 50

Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3bdec42c9612..87603145e4bd 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -58,6 +58,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_CW6622		0x100000
 #define BTUSB_MEDIATEK		0x200000
 #define BTUSB_WIDEBAND_SPEECH	0x400000
+#define BTUSB_MSFT_VND_EXT	0x800000
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -335,7 +336,8 @@ static const struct usb_device_id blacklist_table[] = {
 
 	/* Intel Bluetooth devices */
 	{ USB_DEVICE(0x8087, 0x0025), .driver_info = BTUSB_INTEL_NEW |
-						     BTUSB_WIDEBAND_SPEECH },
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_MSFT_VND_EXT },
 	{ USB_DEVICE(0x8087, 0x0026), .driver_info = BTUSB_INTEL_NEW |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x8087, 0x0029), .driver_info = BTUSB_INTEL_NEW |
@@ -3800,6 +3802,12 @@ static int btusb_probe(struct usb_interface *intf,
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
+
+		/* All Intel controllers that support the Microsoft
+		 * vendor extension are using 0xFC1E for VsMsftOpCode.
+		 */
+		if (id->driver_info & BTUSB_MSFT_VND_EXT)
+			hci_set_msft_opcode(hdev, 0xFC1E);
 	}
 
 	if (id->driver_info & BTUSB_MARVELL)
-- 
2.25.1

