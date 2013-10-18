Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/8] Bluetooth: Create HCI device debugfs directory in hci_register_dev
Date: Thu, 17 Oct 2013 17:24:17 -0700
Message-Id: <1382055860-12572-5-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Create the debugfs directory for each HCI device directly in
hci_register_dev function and remove it during hci_unregister_dev.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c  |  5 +++++
 net/bluetooth/hci_sysfs.c | 16 +---------------
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0fb9f6d..f7ba818 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2479,6 +2479,9 @@ int hci_register_dev(struct hci_dev *hdev)
 		goto err;
 	}
 
+	if (!IS_ERR_OR_NULL(bt_debugfs))
+		hdev->debugfs = debugfs_create_dir(hdev->name, bt_debugfs);
+
 	error = hci_add_sysfs(hdev);
 	if (error < 0)
 		goto err_wqueue;
@@ -2569,6 +2572,8 @@ void hci_unregister_dev(struct hci_dev *hdev)
 
 	hci_del_sysfs(hdev);
 
+	debugfs_remove_recursive(hdev->debugfs);
+
 	destroy_workqueue(hdev->workqueue);
 	destroy_workqueue(hdev->req_workqueue);
 
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 077037e..0e71318 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -409,32 +409,18 @@ void hci_init_sysfs(struct hci_dev *hdev)
 int hci_add_sysfs(struct hci_dev *hdev)
 {
 	struct device *dev = &hdev->dev;
-	int err;
 
 	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
 
 	dev_set_name(dev, "%s", hdev->name);
 
-	err = device_add(dev);
-	if (err < 0)
-		return err;
-
-	if (!bt_debugfs)
-		return 0;
-
-	hdev->debugfs = debugfs_create_dir(hdev->name, bt_debugfs);
-	if (!hdev->debugfs)
-		return 0;
-
-	return 0;
+	return device_add(dev);
 }
 
 void hci_del_sysfs(struct hci_dev *hdev)
 {
 	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
 
-	debugfs_remove_recursive(hdev->debugfs);
-
 	device_del(&hdev->dev);
 }
 
-- 
1.8.3.1

