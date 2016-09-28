Return-Path: <marvell@marvell.com>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, <gustavo@padovan.org>, <huxm@marvell.com>,
        Amitkumar Karwar <akarwar@marvell.com>
Subject: [PATCH] Bluetooth: btusb: add entry for Marvell 8997 chipset
Date: Wed, 28 Sep 2016 16:18:35 +0530
Message-ID: <1475059715-6174-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

btusb_set_bdaddr_marvell() configures BD address for Marvell chipsets.
This patch adds new chipset 8997 in the list so that BD address feature
would be available for it.

Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 6bd63b8..8896233 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -314,6 +314,7 @@ static const struct usb_device_id blacklist_table[] = {
 	/* Marvell Bluetooth devices */
 	{ USB_DEVICE(0x1286, 0x2044), .driver_info = BTUSB_MARVELL },
 	{ USB_DEVICE(0x1286, 0x2046), .driver_info = BTUSB_MARVELL },
+	{ USB_DEVICE(0x1286, 0x204e), .driver_info = BTUSB_MARVELL },
 
 	/* Intel Bluetooth devices */
 	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
-- 
1.8.1.4
