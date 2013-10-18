Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/8] Bluetooth: Move uuids debugfs entry creation into hci_core.c
Date: Thu, 17 Oct 2013 17:24:15 -0700
Message-Id: <1382055860-12572-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The uuids debugfs should only be created together with the other
entries after the setup procedure has been finished.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_sysfs.c | 46 ----------------------------------------------
 2 files changed, 40 insertions(+), 46 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index de59bb1..0fb9f6d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -29,6 +29,7 @@
 #include <linux/idr.h>
 #include <linux/rfkill.h>
 #include <linux/debugfs.h>
+#include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -82,6 +83,43 @@ static const struct file_operations blacklist_fops = {
 	.release	= single_release,
 };
 
+static int uuids_show(struct seq_file *f, void *p)
+{
+	struct hci_dev *hdev = f->private;
+	struct bt_uuid *uuid;
+
+	hci_dev_lock(hdev);
+	list_for_each_entry(uuid, &hdev->uuids, list) {
+		u32 data0, data5;
+		u16 data1, data2, data3, data4;
+
+		data5 = get_unaligned_le32(uuid);
+		data4 = get_unaligned_le16(uuid + 4);
+		data3 = get_unaligned_le16(uuid + 6);
+		data2 = get_unaligned_le16(uuid + 8);
+		data1 = get_unaligned_le16(uuid + 10);
+		data0 = get_unaligned_le32(uuid + 12);
+
+		seq_printf(f, "%.8x-%.4x-%.4x-%.4x-%.4x%.8x\n",
+			   data0, data1, data2, data3, data4, data5);
+	}
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int uuids_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, uuids_show, inode->i_private);
+}
+
+static const struct file_operations uuids_fops = {
+	.open		= uuids_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static int inquiry_cache_show(struct seq_file *f, void *p)
 {
 	struct hci_dev *hdev = f->private;
@@ -872,6 +910,8 @@ static int __hci_init(struct hci_dev *hdev)
 	debugfs_create_file("blacklist", 0444, hdev->debugfs, hdev,
 			    &blacklist_fops);
 
+	debugfs_create_file("uuids", 0444, hdev->debugfs, hdev, &uuids_fops);
+
 	if (lmp_bredr_capable(hdev)) {
 		debugfs_create_file("inquiry_cache", 0444, hdev->debugfs,
 				    hdev, &inquiry_cache_fops);
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 863e313..077037e 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -2,7 +2,6 @@
 
 #include <linux/debugfs.h>
 #include <linux/module.h>
-#include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -396,49 +395,6 @@ static struct device_type bt_host = {
 	.release = bt_host_release,
 };
 
-static void print_bt_uuid(struct seq_file *f, u8 *uuid)
-{
-	u32 data0, data5;
-	u16 data1, data2, data3, data4;
-
-	data5 = get_unaligned_le32(uuid);
-	data4 = get_unaligned_le16(uuid + 4);
-	data3 = get_unaligned_le16(uuid + 6);
-	data2 = get_unaligned_le16(uuid + 8);
-	data1 = get_unaligned_le16(uuid + 10);
-	data0 = get_unaligned_le32(uuid + 12);
-
-	seq_printf(f, "%.8x-%.4x-%.4x-%.4x-%.4x%.8x\n",
-		   data0, data1, data2, data3, data4, data5);
-}
-
-static int uuids_show(struct seq_file *f, void *p)
-{
-	struct hci_dev *hdev = f->private;
-	struct bt_uuid *uuid;
-
-	hci_dev_lock(hdev);
-
-	list_for_each_entry(uuid, &hdev->uuids, list)
-		print_bt_uuid(f, uuid->uuid);
-
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-static int uuids_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, uuids_show, inode->i_private);
-}
-
-static const struct file_operations uuids_fops = {
-	.open		= uuids_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 void hci_init_sysfs(struct hci_dev *hdev)
 {
 	struct device *dev = &hdev->dev;
@@ -470,8 +426,6 @@ int hci_add_sysfs(struct hci_dev *hdev)
 	if (!hdev->debugfs)
 		return 0;
 
-	debugfs_create_file("uuids", 0444, hdev->debugfs, hdev, &uuids_fops);
-
 	return 0;
 }
 
-- 
1.8.3.1

