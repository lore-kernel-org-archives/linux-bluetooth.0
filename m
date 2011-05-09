Return-Path: <cyrus@holtmann.org>
Message-ID: <4DC87494.4070203@windriver.com>
Date: Mon, 09 May 2011 16:11:16 -0700
From: Andy Ross <andy.ross@windriver.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>,
 "Gustavo F. Padovan" <padovan@profusion.mobi>,
 linux-bluetooth@vger.kernel.org
Subject: [PATCH] btusb: Device ids for ath3k on Pegatron Lucid tablets
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

MeeGo has been carrying this patch for a while, and I'd forgotten
about it until it accidentally got dropped.  I think I remember
finding the IDs on a mailing list, but as of now they're still
unmerged and I can't find the original source.  Device IDs for ath3k
bluetooth on the WeTab/ExoPC.

Andy

>From ff4a4cdbbb847901bd5e64e2510f2c0cda11497b Mon Sep 17 00:00:00 2001
From: Andy Ross <andy.ross@windriver.com>
Date: Mon, 9 May 2011 15:59:49 -0700
Subject: [PATCH] btusb: Device ids for ath3k on Pegatron Lucid tablets

New ath3k device IDs used on the Pegatron Lucid (ExoPC and WeTab) units.

Signed-off-by: Andy Ross <andy.ross@windriver.com>
---
 drivers/bluetooth/ath3k.c |    1 +
 drivers/bluetooth/btusb.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 6dcd55a..c719935 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -38,6 +38,7 @@ static struct usb_device_id ath3k_table[] = {

 	/* Atheros AR3011 with sflash firmware*/
 	{ USB_DEVICE(0x0CF3, 0x3002) },
+	{ USB_DEVICE(0x13d3, 0x3304) },

 	/* Atheros AR9285 Malbec with sflash firmware */
 	{ USB_DEVICE(0x03F0, 0x311D) },
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 700a384..1d92c65 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -101,6 +101,7 @@ static struct usb_device_id blacklist_table[] = {

 	/* Atheros 3011 with sflash firmware */
 	{ USB_DEVICE(0x0cf3, 0x3002), .driver_info = BTUSB_IGNORE },
+	{ USB_DEVICE(0x13d3, 0x3304), .driver_info = BTUSB_IGNORE },

 	/* Atheros AR9285 Malbec with sflash firmware */
 	{ USB_DEVICE(0x03f0, 0x311d), .driver_info = BTUSB_IGNORE },
-- 
1.7.1
