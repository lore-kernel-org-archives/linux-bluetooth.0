Return-Path: <velemas@gmail.com>
From: Artiom Vaskov <velemas@gmail.com>
To: 
Cc: honwchong@gmail.com,
	Larry.Finger@lwfinger.net,
	Artiom Vaskov <velemas@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Add additional device ID for RTL8822BE
Date: Mon, 28 May 2018 00:44:01 +0300
Message-Id: <20180527214402.12831-1-velemas@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The Asus ROG GL702ZC laptop contains a Realtek RTL8822BE device with
an associated BT chip using a USB ID of 13d3:3526. This ID is added
to the driver.

Signed-off-by: Artiom Vaskov <velemas@gmail.com>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b937cc1e2c07..34e5aedd4e27 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -379,6 +379,7 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x13d3, 0x3462), .driver_info = BTUSB_REALTEK },
 
 	/* Additional Realtek 8822BE Bluetooth devices */
+	{ USB_DEVICE(0x13d3, 0x3526), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x0b05, 0x185c), .driver_info = BTUSB_REALTEK },
 
 	/* Silicon Wave based devices */
-- 
2.17.0
