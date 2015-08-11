Return-Path: <cyrus@holtmann.org>
From: Dmitry Tunin <hanipouspilot@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Dmitry Tunin <hanipouspilot@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ath3k: Revert 7e730c7f3d1f39c25cf5f7cf70c0ff4c28d7bec7
Date: Tue, 11 Aug 2015 13:50:29 +0300
Message-Id: <1439290229-6937-1-git-send-email-hanipouspilot@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

This patch causes infinite loop on loading firmware on Acer Aspire
V3è371-31KW and probably other laptops.

This is a serious regression, because system becomes unresponsive.

This should be reverted until the firmware loading issue is sorted out.

Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/bluetooth/ath3k.c | 2 --
 drivers/bluetooth/btusb.c | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index e527a3e..2fa6588 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -89,7 +89,6 @@ static const struct usb_device_id ath3k_table[] = {
 	{ USB_DEVICE(0x04CA, 0x3007) },
 	{ USB_DEVICE(0x04CA, 0x3008) },
 	{ USB_DEVICE(0x04CA, 0x300b) },
-	{ USB_DEVICE(0x04CA, 0x300d) },
 	{ USB_DEVICE(0x04CA, 0x300f) },
 	{ USB_DEVICE(0x04CA, 0x3010) },
 	{ USB_DEVICE(0x0930, 0x0219) },
@@ -149,7 +148,6 @@ static const struct usb_device_id ath3k_blist_tbl[] = {
 	{ USB_DEVICE(0x04ca, 0x3007), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x04ca, 0x3008), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x04ca, 0x300b), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x04ca, 0x300d), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x04ca, 0x300f), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x04ca, 0x3010), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0930, 0x0219), .driver_info = BTUSB_ATH3012 },
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index cc92b0f..73e3b7c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -191,7 +191,6 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x04ca, 0x3007), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x04ca, 0x3008), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x04ca, 0x300b), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x04ca, 0x300d), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x04ca, 0x300f), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x04ca, 0x3010), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0930, 0x0219), .driver_info = BTUSB_ATH3012 },
-- 
1.9.1
