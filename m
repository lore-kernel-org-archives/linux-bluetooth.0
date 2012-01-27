Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com,
	marcel@holtmann.org,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH] Bluetooth: btusb: Remove device lock on release
Date: Fri, 27 Jan 2012 17:37:22 +0100
Message-Id: <1327682242-2988-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Recently we changed the way how we release driver-data. A driver is now
responsible of destroying the data so we no longer need the device lock
on deinitialization in btusb driver.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/bluetooth/btusb.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 0de3f5e..0a06d75 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1078,9 +1078,6 @@ static void btusb_disconnect(struct usb_interface *intf)
 		return;
 
 	hdev = data->hdev;
-
-	hci_dev_hold(hdev);
-
 	usb_set_intfdata(data->intf, NULL);
 
 	if (data->isoc)
@@ -1093,8 +1090,6 @@ static void btusb_disconnect(struct usb_interface *intf)
 	else if (data->isoc)
 		usb_driver_release_interface(&btusb_driver, data->isoc);
 
-	hci_dev_put(hdev);
-
 	hci_free_dev(hdev);
 	kfree(data);
 }
-- 
1.7.8.4
