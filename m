Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	padovan@profusion.mobi,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 5/5] Bluetooth: Remove __hci_dev_put/hold
Date: Thu, 29 Dec 2011 16:40:42 +0100
Message-Id: <1325173242-12264-6-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1325173242-12264-1-git-send-email-dh.herrmann@googlemail.com>
References: <1325173242-12264-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Since we remove the owner field of hci_dev hci_dev_put and __hci_dev_put do the
same so we can merge them into one function.
Same for hci_dev_hold and __hci_dev_hold.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/bluetooth/btusb.c        |    4 ++--
 include/net/bluetooth/hci_core.h |   12 ++----------
 net/bluetooth/hci_core.c         |    4 ++--
 3 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 246944e..2dbecfa 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1082,7 +1082,7 @@ static void btusb_disconnect(struct usb_interface *intf)
 
 	hdev = data->hdev;
 
-	__hci_dev_hold(hdev);
+	hci_dev_hold(hdev);
 
 	usb_set_intfdata(data->intf, NULL);
 
@@ -1096,7 +1096,7 @@ static void btusb_disconnect(struct usb_interface *intf)
 	else if (data->isoc)
 		usb_driver_release_interface(&btusb_driver, data->isoc);
 
-	__hci_dev_put(hdev);
+	hci_dev_put(hdev);
 
 	hci_free_dev(hdev);
 	kfree(data);
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8b17d07..afab7d3 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -562,25 +562,17 @@ static inline void hci_conn_put(struct hci_conn *conn)
 }
 
 /* ----- HCI Devices ----- */
-static inline void __hci_dev_put(struct hci_dev *d)
+static inline void hci_dev_put(struct hci_dev *d)
 {
 	put_device(&d->dev);
 }
 
-/*
- * hci_dev_put and hci_dev_hold are macros to avoid dragging all the
- * overhead of all the modular infrastructure into this header.
- */
-#define hci_dev_put(d) __hci_dev_put(d)
-
-static inline struct hci_dev *__hci_dev_hold(struct hci_dev *d)
+static inline struct hci_dev *hci_dev_hold(struct hci_dev *d)
 {
 	get_device(&d->dev);
 	return d;
 }
 
-#define hci_dev_hold(d) __hci_dev_hold(d)
-
 #define hci_dev_lock(d)		mutex_lock(&d->lock)
 #define hci_dev_unlock(d)	mutex_unlock(&d->lock)
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4dbbfbc..ac0b795 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1557,7 +1557,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	schedule_work(&hdev->power_on);
 
 	hci_notify(hdev, HCI_DEV_REG);
-	__hci_dev_hold(hdev);
+	hci_dev_hold(hdev);
 
 	return id;
 
@@ -1620,7 +1620,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	hci_adv_entries_clear(hdev);
 	hci_dev_unlock(hdev);
 
-	__hci_dev_put(hdev);
+	hci_dev_put(hdev);
 }
 EXPORT_SYMBOL(hci_unregister_dev);
 
-- 
1.7.8.1
