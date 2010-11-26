Return-Path: <cyrus@holtmann.org>
From: Bala Shanmugam <sbalashanmugam@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Bala Shanmugam <sbalashanmugam@atheros.com>
Subject: [PATCH v2] Bluetooth: Add new PID for Atheros 3011
Date: Fri, 26 Nov 2010 17:15:49 +0530
Message-ID: <1290771949-4363-1-git-send-email-sbalashanmugam@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Atheros 3011 has small sflash firmware and needs to be
blacklisted in transport driver to load actual firmware
in DFU driver.

Signed-off-by: Bala Shanmugam <sbalashanmugam@atheros.com>
---
 drivers/bluetooth/ath3k.c |    2 ++
 drivers/bluetooth/btusb.c |    3 +++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 128cae4..c70fb0b 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -35,6 +35,8 @@
 static struct usb_device_id ath3k_table[] = {
 	/* Atheros AR3011 */
 	{ USB_DEVICE(0x0CF3, 0x3000) },
+	/* Atheros AR3011 with sflash firmware*/
+	{ USB_DEVICE(0x0CF3, 0x3002) },
 	{ }	/* Terminating entry */
 };
 
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ab3894f..ca3fdc1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -99,6 +99,9 @@ static struct usb_device_id blacklist_table[] = {
 	/* Broadcom BCM2033 without firmware */
 	{ USB_DEVICE(0x0a5c, 0x2033), .driver_info = BTUSB_IGNORE },
 
+	/* Atheros 3011 with sflash firmware */
+	{ USB_DEVICE(0x0cf3, 0x3002), .driver_info = BTUSB_IGNORE },
+
 	/* Broadcom BCM2035 */
 	{ USB_DEVICE(0x0a5c, 0x2035), .driver_info = BTUSB_WRONG_SCO_MTU },
 	{ USB_DEVICE(0x0a5c, 0x200a), .driver_info = BTUSB_WRONG_SCO_MTU },
-- 
1.6.3.3

