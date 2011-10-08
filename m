Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	padovan@profusion.mobi,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 3/3] Bluetooth: Forward errors from hci_register_dev
Date: Sat,  8 Oct 2011 14:58:49 +0200
Message-Id: <1318078729-4158-3-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1318078729-4158-1-git-send-email-dh.herrmann@googlemail.com>
References: <1318078729-4158-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

We need to catch errors when calling hci_add_sysfs() and return them to the
caller to avoid kernel oopses on device_add() failure.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 net/bluetooth/hci_core.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4975578..fdcbf8f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1426,7 +1426,7 @@ int hci_add_adv_entry(struct hci_dev *hdev,
 int hci_register_dev(struct hci_dev *hdev)
 {
 	struct list_head *head = &hci_dev_list, *p;
-	int i, id = 0;
+	int i, id = 0, error;
 
 	BT_DBG("%p name %s bus %d owner %p", hdev, hdev->name,
 						hdev->bus, hdev->owner);
@@ -1503,10 +1503,14 @@ int hci_register_dev(struct hci_dev *hdev)
 	write_unlock_bh(&hci_dev_list_lock);
 
 	hdev->workqueue = create_singlethread_workqueue(hdev->name);
-	if (!hdev->workqueue)
-		goto nomem;
+	if (!hdev->workqueue) {
+		error = -ENOMEM;
+		goto err;
+	}
 
-	hci_add_sysfs(hdev);
+	error = hci_add_sysfs(hdev);
+	if (error < 0)
+		goto err_wqueue;
 
 	hdev->rfkill = rfkill_alloc(hdev->name, &hdev->dev,
 				RFKILL_TYPE_BLUETOOTH, &hci_rfkill_ops, hdev);
@@ -1525,12 +1529,14 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	return id;
 
-nomem:
+err_wqueue:
+	destroy_workqueue(hdev->workqueue);
+err:
 	write_lock_bh(&hci_dev_list_lock);
 	list_del(&hdev->list);
 	write_unlock_bh(&hci_dev_list_lock);
 
-	return -ENOMEM;
+	return error;
 }
 EXPORT_SYMBOL(hci_register_dev);
 
-- 
1.7.7
