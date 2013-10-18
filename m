Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/8] Bluetooth: Move blacklist debugfs entry creation into hci_core.c
Date: Thu, 17 Oct 2013 17:24:14 -0700
Message-Id: <1382055860-12572-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The blacklist debugfs should only be created together with the other
entries after the setup procedure has been finished.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c  | 28 ++++++++++++++++++++++++++++
 net/bluetooth/hci_sysfs.c | 30 ------------------------------
 2 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2376c30..de59bb1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -57,6 +57,31 @@ static void hci_notify(struct hci_dev *hdev, int event)
 
 /* ---- HCI debugfs entries ---- */
 
+static int blacklist_show(struct seq_file *f, void *p)
+{
+	struct hci_dev *hdev = f->private;
+	struct bdaddr_list *b;
+
+	hci_dev_lock(hdev);
+	list_for_each_entry(b, &hdev->blacklist, list)
+		seq_printf(f, "%pMR\n", &b->bdaddr);
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int blacklist_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, blacklist_show, inode->i_private);
+}
+
+static const struct file_operations blacklist_fops = {
+	.open		= blacklist_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static int inquiry_cache_show(struct seq_file *f, void *p)
 {
 	struct hci_dev *hdev = f->private;
@@ -844,6 +869,9 @@ static int __hci_init(struct hci_dev *hdev)
 	if (!test_bit(HCI_SETUP, &hdev->dev_flags))
 		return 0;
 
+	debugfs_create_file("blacklist", 0444, hdev->debugfs, hdev,
+			    &blacklist_fops);
+
 	if (lmp_bredr_capable(hdev)) {
 		debugfs_create_file("inquiry_cache", 0444, hdev->debugfs,
 				    hdev, &inquiry_cache_fops);
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index a141960..863e313 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -396,33 +396,6 @@ static struct device_type bt_host = {
 	.release = bt_host_release,
 };
 
-static int blacklist_show(struct seq_file *f, void *p)
-{
-	struct hci_dev *hdev = f->private;
-	struct bdaddr_list *b;
-
-	hci_dev_lock(hdev);
-
-	list_for_each_entry(b, &hdev->blacklist, list)
-		seq_printf(f, "%pMR\n", &b->bdaddr);
-
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-static int blacklist_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, blacklist_show, inode->i_private);
-}
-
-static const struct file_operations blacklist_fops = {
-	.open		= blacklist_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 static void print_bt_uuid(struct seq_file *f, u8 *uuid)
 {
 	u32 data0, data5;
@@ -497,9 +470,6 @@ int hci_add_sysfs(struct hci_dev *hdev)
 	if (!hdev->debugfs)
 		return 0;
 
-	debugfs_create_file("blacklist", 0444, hdev->debugfs,
-			    hdev, &blacklist_fops);
-
 	debugfs_create_file("uuids", 0444, hdev->debugfs, hdev, &uuids_fops);
 
 	return 0;
-- 
1.8.3.1

