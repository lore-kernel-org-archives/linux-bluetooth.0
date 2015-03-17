Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Fix minor whitespace issue in QCA ROME device entries
Date: Mon, 16 Mar 2015 23:56:04 -0700
Message-Id: <1426575364-8673-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 6fa9338745cf..f6ef75f4d7cc 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -215,8 +215,8 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0489, 0xe03c), .driver_info = BTUSB_ATH3012 },
 
 	/* QCA ROME chipset */
-	{ USB_DEVICE(0x0cf3, 0xe300), .driver_info = BTUSB_QCA_ROME},
-	{ USB_DEVICE(0x0cf3, 0xe360), .driver_info = BTUSB_QCA_ROME},
+	{ USB_DEVICE(0x0cf3, 0xe300), .driver_info = BTUSB_QCA_ROME },
+	{ USB_DEVICE(0x0cf3, 0xe360), .driver_info = BTUSB_QCA_ROME },
 
 	/* Broadcom BCM2035 */
 	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },
-- 
2.1.0

