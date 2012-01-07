Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	marcel@holtmann.org,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 10/18] Bluetooth: btusb: Free driver data on USB shutdown
Date: Sat,  7 Jan 2012 15:47:16 +0100
Message-Id: <1325947644-11736-11-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1325947644-11736-1-git-send-email-dh.herrmann@googlemail.com>
References: <1325947644-11736-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of using the hci-destruct callback we free our private driver data on
USB shutdown. We already called hci_unregister_dev() here so the hci core will
never ever call our callbacks again except the destruct callback.

However, there is no reason to keep our *private* driver data alive if we get
never called again and the hci-core does never touch it the data. So we simply
free it right away and set the destruct callback to NULL.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/bluetooth/btusb.c |   11 +----------
 1 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index fbfba80..85bb17d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -786,15 +786,6 @@ done:
 	return err;
 }
 
-static void btusb_destruct(struct hci_dev *hdev)
-{
-	struct btusb_data *data = hdev->driver_data;
-
-	BT_DBG("%s", hdev->name);
-
-	kfree(data);
-}
-
 static void btusb_notify(struct hci_dev *hdev, unsigned int evt)
 {
 	struct btusb_data *data = hdev->driver_data;
@@ -1007,7 +998,6 @@ static int btusb_probe(struct usb_interface *intf,
 	hdev->close    = btusb_close;
 	hdev->flush    = btusb_flush;
 	hdev->send     = btusb_send_frame;
-	hdev->destruct = btusb_destruct;
 	hdev->notify   = btusb_notify;
 
 	hdev->owner = THIS_MODULE;
@@ -1111,6 +1101,7 @@ static void btusb_disconnect(struct usb_interface *intf)
 	__hci_dev_put(hdev);
 
 	hci_free_dev(hdev);
+	kfree(data);
 }
 
 #ifdef CONFIG_PM
-- 
1.7.8.1
