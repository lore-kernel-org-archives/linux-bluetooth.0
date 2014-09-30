Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, Amitkumar Karwar <akarwar@marvell.com>
Subject: [PATCH] Bluetooth: btusb: remove redundant lock variable
Date: Tue, 30 Sep 2014 07:39:05 -0400
Message-ID: <1412077145-10313-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

This variable is nowhere used in the code.

Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
 drivers/bluetooth/btusb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a423b84..edfc17b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -268,8 +268,6 @@ struct btusb_data {
 	struct usb_interface *intf;
 	struct usb_interface *isoc;
 
-	spinlock_t lock;
-
 	unsigned long flags;
 
 	struct work_struct work;
@@ -2002,8 +2000,6 @@ static int btusb_probe(struct usb_interface *intf,
 	data->udev = interface_to_usbdev(intf);
 	data->intf = intf;
 
-	spin_lock_init(&data->lock);
-
 	INIT_WORK(&data->work, btusb_work);
 	INIT_WORK(&data->waker, btusb_waker);
 	init_usb_anchor(&data->deferred);
-- 
1.8.1.4
