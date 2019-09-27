Return-Path: <SRS0=evP7=XW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF81C4360C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Sep 2019 06:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4716C20863
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Sep 2019 06:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbfI0GtE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Sep 2019 02:49:04 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:42779 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfI0GtE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Sep 2019 02:49:04 -0400
Received: from localhost.localdomain (p4FEFC197.dip0.t-ipconnect.de [79.239.193.151])
        by mail.holtmann.org (Postfix) with ESMTPSA id ABDEECECE9
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Sep 2019 08:57:56 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Use IS_ENABLED instead of #ifdef
Date:   Fri, 27 Sep 2019 08:48:58 +0200
Message-Id: <20190927064858.121461-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

For the different hardware support options, it is better to use
IS_ENABLED check. Let the compiler do the needed optimizations.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 0f1b99ff5aec..5d7bc3410104 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2496,8 +2496,6 @@ static int btusb_shutdown_intel_new(struct hci_dev *hdev)
 	return 0;
 }
 
-#ifdef CONFIG_BT_HCIBTUSB_MTK
-
 #define FIRMWARE_MT7663		"mediatek/mt7663pr2h.bin"
 #define FIRMWARE_MT7668		"mediatek/mt7668pr2h.bin"
 
@@ -3058,7 +3056,6 @@ static int btusb_mtk_shutdown(struct hci_dev *hdev)
 
 MODULE_FIRMWARE(FIRMWARE_MT7663);
 MODULE_FIRMWARE(FIRMWARE_MT7668);
-#endif
 
 #ifdef CONFIG_PM
 /* Configure an out-of-band gpio as wake-up pin, if specified in device tree */
@@ -3418,7 +3415,6 @@ static int btusb_setup_qca(struct hci_dev *hdev)
 	return 0;
 }
 
-#ifdef CONFIG_BT_HCIBTUSB_BCM
 static inline int __set_diag_interface(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -3505,7 +3501,6 @@ static int btusb_bcm_set_diag(struct hci_dev *hdev, bool enable)
 
 	return submit_or_queue_tx_urb(hdev, urb);
 }
-#endif
 
 #ifdef CONFIG_PM
 static irqreturn_t btusb_oob_wake_handler(int irq, void *priv)
@@ -3731,8 +3726,8 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_BCM92035)
 		hdev->setup = btusb_setup_bcm92035;
 
-#ifdef CONFIG_BT_HCIBTUSB_BCM
-	if (id->driver_info & BTUSB_BCM_PATCHRAM) {
+	if (IS_ENABLED(CONFIG_BT_HCIBTUSB_BCM) &&
+	    (id->driver_info & BTUSB_BCM_PATCHRAM)) {
 		hdev->manufacturer = 15;
 		hdev->setup = btbcm_setup_patchram;
 		hdev->set_diag = btusb_bcm_set_diag;
@@ -3742,7 +3737,8 @@ static int btusb_probe(struct usb_interface *intf,
 		data->diag = usb_ifnum_to_if(data->udev, ifnum_base + 2);
 	}
 
-	if (id->driver_info & BTUSB_BCM_APPLE) {
+	if (IS_ENABLED(CONFIG_BT_HCIBTUSB_BCM) &&
+	    (id->driver_info & BTUSB_BCM_APPLE)) {
 		hdev->manufacturer = 15;
 		hdev->setup = btbcm_setup_apple;
 		hdev->set_diag = btusb_bcm_set_diag;
@@ -3750,7 +3746,6 @@ static int btusb_probe(struct usb_interface *intf,
 		/* Broadcom LM_DIAG Interface numbers are hardcoded */
 		data->diag = usb_ifnum_to_if(data->udev, ifnum_base + 2);
 	}
-#endif
 
 	if (id->driver_info & BTUSB_INTEL) {
 		hdev->manufacturer = 2;
@@ -3781,14 +3776,13 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_MARVELL)
 		hdev->set_bdaddr = btusb_set_bdaddr_marvell;
 
-#ifdef CONFIG_BT_HCIBTUSB_MTK
-	if (id->driver_info & BTUSB_MEDIATEK) {
+	if (IS_ENABLED(CONFIG_BT_HCIBTUSB_MTK) &&
+	    (id->driver_info & BTUSB_MEDIATEK)) {
 		hdev->setup = btusb_mtk_setup;
 		hdev->shutdown = btusb_mtk_shutdown;
 		hdev->manufacturer = 70;
 		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
 	}
-#endif
 
 	if (id->driver_info & BTUSB_SWAVE) {
 		set_bit(HCI_QUIRK_FIXUP_INQUIRY_MODE, &hdev->quirks);
@@ -3893,15 +3887,13 @@ static int btusb_probe(struct usb_interface *intf,
 			goto out_free_dev;
 	}
 
-#ifdef CONFIG_BT_HCIBTUSB_BCM
-	if (data->diag) {
+	if (IS_ENABLED(CONFIG_BT_HCIBTUSB_BCM) && data->diag) {
 		if (!usb_driver_claim_interface(&btusb_driver,
 						data->diag, data))
 			__set_diag_interface(hdev);
 		else
 			data->diag = NULL;
 	}
-#endif
 
 	if (enable_autosuspend)
 		usb_enable_autosuspend(data->udev);
-- 
2.20.1

