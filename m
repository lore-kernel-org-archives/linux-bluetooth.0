Return-Path: <SRS0=6lUD=BM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B501C433DF
	for <linux-bluetooth@archiver.kernel.org>; Sun,  2 Aug 2020 04:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FF062076B
	for <linux-bluetooth@archiver.kernel.org>; Sun,  2 Aug 2020 04:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgHBEVt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 2 Aug 2020 00:21:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49514 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgHBEVt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 2 Aug 2020 00:21:49 -0400
Received: from [114.252.213.24] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <hui.wang@canonical.com>)
        id 1k25VL-0002Xt-A0; Sun, 02 Aug 2020 04:21:48 +0000
From:   Hui Wang <hui.wang@canonical.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com
Subject: [PATCH] Bluetooth: btusb: Add a module parameter ignore_id for debugging
Date:   Sun,  2 Aug 2020 12:21:38 +0800
Message-Id: <20200802042138.9149-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

There is always an on-board usb bluetooth hci on the laptops, if
the bluetooth function doesn't work well like a bt headset can't work
with HSP/HFP mode, we often plug an external usb BT hci to verify if
that headset could work with the exteral BT hci or not, in this
situation, there will be 2 hcis (hci0 and hci1) in the system, and
so far, the gnome can't handle the hci1 well so we met lots of
problems when debugging with hci1 under gnome.

After adding this new module parameter, we could ban the on-board
usb hci by putting btusb.ignore_id=idVendor,idProduct to the bootargs,
then the external usb hci will be hci0 and there is only one hci
in the system. We could easily debug with the external usb bluetooth
hci after this change.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 drivers/bluetooth/btusb.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5f022e9cf667..f6ab0cb313ed 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -32,6 +32,7 @@ static bool force_scofix;
 static bool enable_autosuspend = IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTOSUSPEND);
 
 static bool reset = true;
+static u16 ignore_id[2];
 
 static struct usb_driver btusb_driver;
 
@@ -3714,11 +3715,17 @@ static int btusb_probe(struct usb_interface *intf,
 	struct gpio_desc *reset_gpio;
 	struct btusb_data *data;
 	struct hci_dev *hdev;
+	struct usb_device *dev;
 	unsigned ifnum_base;
 	int i, err;
 
 	BT_DBG("intf %p id %p", intf, id);
 
+	dev = interface_to_usbdev(intf);
+	if (ignore_id[0] == le16_to_cpu(dev->descriptor.idVendor) &&
+	    ignore_id[1] == le16_to_cpu(dev->descriptor.idProduct))
+		return -ENODEV;
+
 	/* interface numbers are hardcoded in the spec */
 	if (intf->cur_altsetting->desc.bInterfaceNumber != 0) {
 		if (!(id->driver_info & BTUSB_IFNUM_2))
@@ -4273,6 +4280,10 @@ MODULE_PARM_DESC(enable_autosuspend, "Enable USB autosuspend by default");
 module_param(reset, bool, 0644);
 MODULE_PARM_DESC(reset, "Send HCI reset command on initialization");
 
+module_param_array(ignore_id, ushort, NULL, 0644);
+MODULE_PARM_DESC(ignore_id, "btusb will ignore this device if the id matches."
+		 " e.g. ignore_id=idVendor,idProduct");
+
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Generic Bluetooth USB driver ver " VERSION);
 MODULE_VERSION(VERSION);
-- 
2.17.1

