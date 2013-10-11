Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: Declare ath3k_table[] and ath3k_blist_tbl[] as const
Date: Fri, 11 Oct 2013 07:46:21 -0700
Message-Id: <1381502781-42826-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The ath3k_table[] and ath3k_blist_tbl[] USB device tables can be
declared as const.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/ath3k.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 0a327f4..6bfc1bb 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -57,7 +57,7 @@ struct ath3k_version {
 	unsigned char	reserved[0x07];
 };
 
-static struct usb_device_id ath3k_table[] = {
+static const struct usb_device_id ath3k_table[] = {
 	/* Atheros AR3011 */
 	{ USB_DEVICE(0x0CF3, 0x3000) },
 
@@ -112,7 +112,7 @@ MODULE_DEVICE_TABLE(usb, ath3k_table);
 #define BTUSB_ATH3012		0x80
 /* This table is to load patch and sysconfig files
  * for AR3012 */
-static struct usb_device_id ath3k_blist_tbl[] = {
+static const struct usb_device_id ath3k_blist_tbl[] = {
 
 	/* Atheros AR3012 with sflash firmware*/
 	{ USB_DEVICE(0x0CF3, 0x0036), .driver_info = BTUSB_ATH3012 },
-- 
1.8.3.1

