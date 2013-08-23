Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/5] Bluetooth: Fix hci_add_sysfs
Date: Fri, 23 Aug 2013 17:01:07 -0300
Message-Id: <1377288071-3664-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The inquiry_cache and auto_accept_delay files should be added to
debugfs only if controller is BR/EDR capable.

Since in hci_register_dev() hdev has not been initialized yet,
we are not able to check if the controller is BR/EDR capable.
Thus, we postpone exporting those two files to just after
controller's initialization.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 17 ++++++++++++-----
 net/bluetooth/hci_sysfs.c        | 16 +++++++++++-----
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3ede820..879bf45 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -775,6 +775,7 @@ int hci_recv_stream_fragment(struct hci_dev *hdev, void *data, int count);
 void hci_init_sysfs(struct hci_dev *hdev);
 int hci_add_sysfs(struct hci_dev *hdev);
 void hci_del_sysfs(struct hci_dev *hdev);
+void hci_sysfs_export_info(struct hci_dev *hdev);
 void hci_conn_init_sysfs(struct hci_conn *conn);
 void hci_conn_add_sysfs(struct hci_conn *conn);
 void hci_conn_del_sysfs(struct hci_conn *conn);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8d9b87d..e8be6ec 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1184,11 +1184,18 @@ int hci_dev_open(__u16 dev)
 		hci_dev_hold(hdev);
 		set_bit(HCI_UP, &hdev->flags);
 		hci_notify(hdev, HCI_DEV_UP);
-		if (!test_bit(HCI_SETUP, &hdev->dev_flags) &&
-		    mgmt_valid_hdev(hdev)) {
-			hci_dev_lock(hdev);
-			mgmt_powered(hdev, 1);
-			hci_dev_unlock(hdev);
+		if (mgmt_valid_hdev(hdev)) {
+			/* If we are in HCI_SETUP phase, meaning the device
+			 * has just been registered, we should export the
+			 * remaining infos to debugfs.
+			 */
+			if (test_bit(HCI_SETUP, &hdev->dev_flags)) {
+				hci_sysfs_export_info(hdev);
+			} else {
+				hci_dev_lock(hdev);
+				mgmt_powered(hdev, 1);
+				hci_dev_unlock(hdev);
+			}
 		}
 	} else {
 		/* Init failed, cleanup */
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 7ad6ecf..c89032c 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -542,6 +542,17 @@ void hci_init_sysfs(struct hci_dev *hdev)
 	device_initialize(dev);
 }
 
+/* This function expects hdev has been already intialized */
+void hci_sysfs_export_info(struct hci_dev *hdev)
+{
+	if (lmp_bredr_capable(hdev)) {
+		debugfs_create_file("inquiry_cache", 0444, hdev->debugfs,
+				    hdev, &inquiry_cache_fops);
+		debugfs_create_file("auto_accept_delay", 0444, hdev->debugfs,
+				    hdev, &auto_accept_delay_fops);
+	}
+}
+
 int hci_add_sysfs(struct hci_dev *hdev)
 {
 	struct device *dev = &hdev->dev;
@@ -562,16 +573,11 @@ int hci_add_sysfs(struct hci_dev *hdev)
 	if (!hdev->debugfs)
 		return 0;
 
-	debugfs_create_file("inquiry_cache", 0444, hdev->debugfs,
-			    hdev, &inquiry_cache_fops);
-
 	debugfs_create_file("blacklist", 0444, hdev->debugfs,
 			    hdev, &blacklist_fops);
 
 	debugfs_create_file("uuids", 0444, hdev->debugfs, hdev, &uuids_fops);
 
-	debugfs_create_file("auto_accept_delay", 0444, hdev->debugfs, hdev,
-			    &auto_accept_delay_fops);
 	return 0;
 }
 
-- 
1.8.3.4

