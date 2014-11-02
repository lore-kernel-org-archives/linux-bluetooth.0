Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Consolidate whitelist debugfs entry into device_list
Date: Sun,  2 Nov 2014 21:46:52 +0100
Message-Id: <1414961212-33611-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The debufs entry for the BR/EDR whitelist is confusing since there is
a controller debugfs entry with the name white_list and both are two
different things.

With the BR/EDR whitelist, the actual interface in use is the device
list and thus just include all values from the internal BR/EDR whitelist
in the device_list debugfs entry.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 36 ++++++------------------------------
 1 file changed, 6 insertions(+), 30 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a12e018ee21c..6c162c8809cf 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -200,31 +200,6 @@ static const struct file_operations blacklist_fops = {
 	.release	= single_release,
 };
 
-static int whitelist_show(struct seq_file *f, void *p)
-{
-	struct hci_dev *hdev = f->private;
-	struct bdaddr_list *b;
-
-	hci_dev_lock(hdev);
-	list_for_each_entry(b, &hdev->whitelist, list)
-		seq_printf(f, "%pMR (type %u)\n", &b->bdaddr, b->bdaddr_type);
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-static int whitelist_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, whitelist_show, inode->i_private);
-}
-
-static const struct file_operations whitelist_fops = {
-	.open		= whitelist_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 static int uuids_show(struct seq_file *f, void *p)
 {
 	struct hci_dev *hdev = f->private;
@@ -1030,10 +1005,13 @@ static int device_list_show(struct seq_file *f, void *ptr)
 {
 	struct hci_dev *hdev = f->private;
 	struct hci_conn_params *p;
+	struct bdaddr_list *b;
 
 	hci_dev_lock(hdev);
+	list_for_each_entry(b, &hdev->whitelist, list)
+		seq_printf(f, "%pMR (type %u)\n", &b->bdaddr, b->bdaddr_type);
 	list_for_each_entry(p, &hdev->le_conn_params, list) {
-		seq_printf(f, "%pMR %u %u\n", &p->addr, p->addr_type,
+		seq_printf(f, "%pMR (type %u) %u\n", &p->addr, p->addr_type,
 			   p->auto_connect);
 	}
 	hci_dev_unlock(hdev);
@@ -1815,10 +1793,10 @@ static int __hci_init(struct hci_dev *hdev)
 			   &hdev->manufacturer);
 	debugfs_create_u8("hci_version", 0444, hdev->debugfs, &hdev->hci_ver);
 	debugfs_create_u16("hci_revision", 0444, hdev->debugfs, &hdev->hci_rev);
+	debugfs_create_file("device_list", 0444, hdev->debugfs, hdev,
+			    &device_list_fops);
 	debugfs_create_file("blacklist", 0444, hdev->debugfs, hdev,
 			    &blacklist_fops);
-	debugfs_create_file("whitelist", 0444, hdev->debugfs, hdev,
-			    &whitelist_fops);
 	debugfs_create_file("uuids", 0444, hdev->debugfs, hdev, &uuids_fops);
 
 	debugfs_create_file("conn_info_min_age", 0644, hdev->debugfs, hdev,
@@ -1897,8 +1875,6 @@ static int __hci_init(struct hci_dev *hdev)
 				    hdev, &adv_min_interval_fops);
 		debugfs_create_file("adv_max_interval", 0644, hdev->debugfs,
 				    hdev, &adv_max_interval_fops);
-		debugfs_create_file("device_list", 0444, hdev->debugfs, hdev,
-				    &device_list_fops);
 		debugfs_create_u16("discov_interleaved_timeout", 0644,
 				   hdev->debugfs,
 				   &hdev->discov_interleaved_timeout);
-- 
1.9.3

