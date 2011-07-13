Return-Path: <cyrus@holtmann.org>
From: Ricardo Mendoza <ricmm@gentoo.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org, Ricardo Mendoza <ricmm@gentoo.org>
Subject: [PATCH] Bluetooth: Add Toshiba laptops AR30XX device ID
Date: Wed, 13 Jul 2011 16:04:29 +0100
Message-Id: <1310569469-30717-1-git-send-email-ricmm@gentoo.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Blacklist Toshiba-branded AR3011 based AR5B195 [0930:0215] and add to
ath3k.c for firmware loading.

Signed-off-by: Ricardo Mendoza <ricmm@gentoo.org>
---
 drivers/bluetooth/ath3k.c |    1 +
 drivers/bluetooth/btusb.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index a585473..480f324 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -63,6 +63,7 @@ static struct usb_device_id ath3k_table[] = {
 	/* Atheros AR3011 with sflash firmware*/
 	{ USB_DEVICE(0x0CF3, 0x3002) },
 	{ USB_DEVICE(0x13d3, 0x3304) },
+	{ USB_DEVICE(0x0930, 0x0215) },
 
 	/* Atheros AR9285 Malbec with sflash firmware */
 	{ USB_DEVICE(0x03F0, 0x311D) },
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 91d13a9..6694d00 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -106,6 +106,7 @@ static struct usb_device_id blacklist_table[] = {
 	/* Atheros 3011 with sflash firmware */
 	{ USB_DEVICE(0x0cf3, 0x3002), .driver_info = BTUSB_IGNORE },
 	{ USB_DEVICE(0x13d3, 0x3304), .driver_info = BTUSB_IGNORE },
+	{ USB_DEVICE(0x0930, 0x0215), .driver_info = BTUSB_IGNORE },
 
 	/* Atheros AR9285 Malbec with sflash firmware */
 	{ USB_DEVICE(0x03f0, 0x311d), .driver_info = BTUSB_IGNORE },
-- 
1.7.3.4

