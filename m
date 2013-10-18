Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/8] Bluetooth: Move device_add handling into hci_register_dev
Date: Thu, 17 Oct 2013 17:24:19 -0700
Message-Id: <1382055860-12572-7-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The device_add handling can be done directly in hci_register_dev and
device_remove within hci_unregister_dev.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  2 --
 net/bluetooth/hci_core.c         |  6 ++++--
 net/bluetooth/hci_sysfs.c        | 18 ------------------
 3 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c6becda..9b5db01 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -768,8 +768,6 @@ int hci_recv_fragment(struct hci_dev *hdev, int type, void *data, int count);
 int hci_recv_stream_fragment(struct hci_dev *hdev, void *data, int count);
 
 void hci_init_sysfs(struct hci_dev *hdev);
-int hci_add_sysfs(struct hci_dev *hdev);
-void hci_del_sysfs(struct hci_dev *hdev);
 void hci_conn_init_sysfs(struct hci_conn *conn);
 void hci_conn_add_sysfs(struct hci_conn *conn);
 void hci_conn_del_sysfs(struct hci_conn *conn);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f7ba818..940da80 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2482,7 +2482,9 @@ int hci_register_dev(struct hci_dev *hdev)
 	if (!IS_ERR_OR_NULL(bt_debugfs))
 		hdev->debugfs = debugfs_create_dir(hdev->name, bt_debugfs);
 
-	error = hci_add_sysfs(hdev);
+	dev_set_name(&hdev->dev, "%s", hdev->name);
+
+	error = device_add(&hdev->dev);
 	if (error < 0)
 		goto err_wqueue;
 
@@ -2570,7 +2572,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 		rfkill_destroy(hdev->rfkill);
 	}
 
-	hci_del_sysfs(hdev);
+	device_del(&hdev->dev);
 
 	debugfs_remove_recursive(hdev->debugfs);
 
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 320a761..9cbf8fe 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -402,24 +402,6 @@ void hci_init_sysfs(struct hci_dev *hdev)
 	device_initialize(dev);
 }
 
-int hci_add_sysfs(struct hci_dev *hdev)
-{
-	struct device *dev = &hdev->dev;
-
-	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
-
-	dev_set_name(dev, "%s", hdev->name);
-
-	return device_add(dev);
-}
-
-void hci_del_sysfs(struct hci_dev *hdev)
-{
-	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
-
-	device_del(&hdev->dev);
-}
-
 int __init bt_sysfs_init(void)
 {
 	bt_class = class_create(THIS_MODULE, "bluetooth");
-- 
1.8.3.1

