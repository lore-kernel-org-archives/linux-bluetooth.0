Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: Declare bpa10x_table[] as const
Date: Fri, 11 Oct 2013 07:46:20 -0700
Message-Id: <1381502781-42826-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The bpa10x_table[] device table can be declared as const

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/bpa10x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
index b9e4e62..8a31991 100644
--- a/drivers/bluetooth/bpa10x.c
+++ b/drivers/bluetooth/bpa10x.c
@@ -37,7 +37,7 @@
 
 #define VERSION "0.10"
 
-static struct usb_device_id bpa10x_table[] = {
+static const struct usb_device_id bpa10x_table[] = {
 	/* Tektronix BPA 100/105 (Digianswer) */
 	{ USB_DEVICE(0x08fd, 0x0002) },
 
-- 
1.8.3.1

