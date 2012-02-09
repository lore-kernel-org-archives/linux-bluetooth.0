Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	johan.hedberg@gmail.com,
	marcel@holtmann.org,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [RESEND PATCH] Bluetooth: btusb: Remove device lock on release
Date: Thu,  9 Feb 2012 21:58:31 +0100
Message-Id: <1328821115-12514-2-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1328821115-12514-1-git-send-email-dh.herrmann@googlemail.com>
References: <1328821115-12514-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Recently we changed the way how we release driver-data. A driver is now
responsible of destroying the data so we no longer need the device lock
on deinitialization in btusb driver.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
Acked in: Message-ID: <1327960875.1955.183.camel@aeonflux>

 drivers/bluetooth/btusb.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index afcd281..12cb2f1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1079,9 +1079,6 @@ static void btusb_disconnect(struct usb_interface *intf)
 		return;
 
 	hdev = data->hdev;
-
-	hci_dev_hold(hdev);
-
 	usb_set_intfdata(data->intf, NULL);
 
 	if (data->isoc)
@@ -1094,8 +1091,6 @@ static void btusb_disconnect(struct usb_interface *intf)
 	else if (data->isoc)
 		usb_driver_release_interface(&btusb_driver, data->isoc);
 
-	hci_dev_put(hdev);
-
 	hci_free_dev(hdev);
 	kfree(data);
 }
-- 
1.7.9
