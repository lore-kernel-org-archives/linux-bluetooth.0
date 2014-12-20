Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: Move common debugfs file creation into hci_debugfs.c
Date: Sat, 20 Dec 2014 16:05:14 +0100
Message-Id: <1419087916-8968-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch moves the creation of the debugs files common for all
controllers into hci_debugfs.c file.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c    | 201 --------------------------------------------
 net/bluetooth/hci_debugfs.c | 200 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 200 insertions(+), 201 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b3ab2bfb3f86..dde29f4bfaa9 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -139,104 +139,6 @@ static const struct file_operations dut_mode_fops = {
 	.llseek		= default_llseek,
 };
 
-static int features_show(struct seq_file *f, void *ptr)
-{
-	struct hci_dev *hdev = f->private;
-	u8 p;
-
-	hci_dev_lock(hdev);
-	for (p = 0; p < HCI_MAX_PAGES && p <= hdev->max_page; p++) {
-		seq_printf(f, "%2u: 0x%2.2x 0x%2.2x 0x%2.2x 0x%2.2x "
-			   "0x%2.2x 0x%2.2x 0x%2.2x 0x%2.2x\n", p,
-			   hdev->features[p][0], hdev->features[p][1],
-			   hdev->features[p][2], hdev->features[p][3],
-			   hdev->features[p][4], hdev->features[p][5],
-			   hdev->features[p][6], hdev->features[p][7]);
-	}
-	if (lmp_le_capable(hdev))
-		seq_printf(f, "LE: 0x%2.2x 0x%2.2x 0x%2.2x 0x%2.2x "
-			   "0x%2.2x 0x%2.2x 0x%2.2x 0x%2.2x\n",
-			   hdev->le_features[0], hdev->le_features[1],
-			   hdev->le_features[2], hdev->le_features[3],
-			   hdev->le_features[4], hdev->le_features[5],
-			   hdev->le_features[6], hdev->le_features[7]);
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-static int features_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, features_show, inode->i_private);
-}
-
-static const struct file_operations features_fops = {
-	.open		= features_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static int blacklist_show(struct seq_file *f, void *p)
-{
-	struct hci_dev *hdev = f->private;
-	struct bdaddr_list *b;
-
-	hci_dev_lock(hdev);
-	list_for_each_entry(b, &hdev->blacklist, list)
-		seq_printf(f, "%pMR (type %u)\n", &b->bdaddr, b->bdaddr_type);
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
-static int uuids_show(struct seq_file *f, void *p)
-{
-	struct hci_dev *hdev = f->private;
-	struct bt_uuid *uuid;
-
-	hci_dev_lock(hdev);
-	list_for_each_entry(uuid, &hdev->uuids, list) {
-		u8 i, val[16];
-
-		/* The Bluetooth UUID values are stored in big endian,
-		 * but with reversed byte order. So convert them into
-		 * the right order for the %pUb modifier.
-		 */
-		for (i = 0; i < 16; i++)
-			val[i] = uuid->uuid[15 - i];
-
-		seq_printf(f, "%pUb\n", val);
-	}
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
 static int inquiry_cache_show(struct seq_file *f, void *p)
 {
 	struct hci_dev *hdev = f->private;
@@ -584,62 +486,6 @@ static int sniff_max_interval_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(sniff_max_interval_fops, sniff_max_interval_get,
 			sniff_max_interval_set, "%llu\n");
 
-static int conn_info_min_age_set(void *data, u64 val)
-{
-	struct hci_dev *hdev = data;
-
-	if (val == 0 || val > hdev->conn_info_max_age)
-		return -EINVAL;
-
-	hci_dev_lock(hdev);
-	hdev->conn_info_min_age = val;
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-static int conn_info_min_age_get(void *data, u64 *val)
-{
-	struct hci_dev *hdev = data;
-
-	hci_dev_lock(hdev);
-	*val = hdev->conn_info_min_age;
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-DEFINE_SIMPLE_ATTRIBUTE(conn_info_min_age_fops, conn_info_min_age_get,
-			conn_info_min_age_set, "%llu\n");
-
-static int conn_info_max_age_set(void *data, u64 val)
-{
-	struct hci_dev *hdev = data;
-
-	if (val == 0 || val < hdev->conn_info_min_age)
-		return -EINVAL;
-
-	hci_dev_lock(hdev);
-	hdev->conn_info_max_age = val;
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-static int conn_info_max_age_get(void *data, u64 *val)
-{
-	struct hci_dev *hdev = data;
-
-	hci_dev_lock(hdev);
-	*val = hdev->conn_info_max_age;
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-DEFINE_SIMPLE_ATTRIBUTE(conn_info_max_age_fops, conn_info_max_age_get,
-			conn_info_max_age_set, "%llu\n");
-
 static int identity_show(struct seq_file *f, void *p)
 {
 	struct hci_dev *hdev = f->private;
@@ -1041,36 +887,6 @@ static int adv_max_interval_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(adv_max_interval_fops, adv_max_interval_get,
 			adv_max_interval_set, "%llu\n");
 
-static int device_list_show(struct seq_file *f, void *ptr)
-{
-	struct hci_dev *hdev = f->private;
-	struct hci_conn_params *p;
-	struct bdaddr_list *b;
-
-	hci_dev_lock(hdev);
-	list_for_each_entry(b, &hdev->whitelist, list)
-		seq_printf(f, "%pMR (type %u)\n", &b->bdaddr, b->bdaddr_type);
-	list_for_each_entry(p, &hdev->le_conn_params, list) {
-		seq_printf(f, "%pMR (type %u) %u\n", &p->addr, p->addr_type,
-			   p->auto_connect);
-	}
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-static int device_list_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, device_list_show, inode->i_private);
-}
-
-static const struct file_operations device_list_fops = {
-	.open		= device_list_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 /* ---- HCI requests ---- */
 
 static void hci_req_sync_complete(struct hci_dev *hdev, u8 result)
@@ -1849,23 +1665,6 @@ static int __hci_init(struct hci_dev *hdev)
 	if (!test_bit(HCI_SETUP, &hdev->dev_flags))
 		return 0;
 
-	debugfs_create_file("features", 0444, hdev->debugfs, hdev,
-			    &features_fops);
-	debugfs_create_u16("manufacturer", 0444, hdev->debugfs,
-			   &hdev->manufacturer);
-	debugfs_create_u8("hci_version", 0444, hdev->debugfs, &hdev->hci_ver);
-	debugfs_create_u16("hci_revision", 0444, hdev->debugfs, &hdev->hci_rev);
-	debugfs_create_file("device_list", 0444, hdev->debugfs, hdev,
-			    &device_list_fops);
-	debugfs_create_file("blacklist", 0444, hdev->debugfs, hdev,
-			    &blacklist_fops);
-	debugfs_create_file("uuids", 0444, hdev->debugfs, hdev, &uuids_fops);
-
-	debugfs_create_file("conn_info_min_age", 0644, hdev->debugfs, hdev,
-			    &conn_info_min_age_fops);
-	debugfs_create_file("conn_info_max_age", 0644, hdev->debugfs, hdev,
-			    &conn_info_max_age_fops);
-
 	hci_debugfs_create_common(hdev);
 
 	if (lmp_bredr_capable(hdev)) {
diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index b8cf0734cc3d..4d06beef8c53 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -28,8 +28,208 @@
 
 #include "hci_debugfs.h"
 
+static int features_show(struct seq_file *f, void *ptr)
+{
+	struct hci_dev *hdev = f->private;
+	u8 p;
+
+	hci_dev_lock(hdev);
+	for (p = 0; p < HCI_MAX_PAGES && p <= hdev->max_page; p++) {
+		seq_printf(f, "%2u: 0x%2.2x 0x%2.2x 0x%2.2x 0x%2.2x "
+			   "0x%2.2x 0x%2.2x 0x%2.2x 0x%2.2x\n", p,
+			   hdev->features[p][0], hdev->features[p][1],
+			   hdev->features[p][2], hdev->features[p][3],
+			   hdev->features[p][4], hdev->features[p][5],
+			   hdev->features[p][6], hdev->features[p][7]);
+	}
+	if (lmp_le_capable(hdev))
+		seq_printf(f, "LE: 0x%2.2x 0x%2.2x 0x%2.2x 0x%2.2x "
+			   "0x%2.2x 0x%2.2x 0x%2.2x 0x%2.2x\n",
+			   hdev->le_features[0], hdev->le_features[1],
+			   hdev->le_features[2], hdev->le_features[3],
+			   hdev->le_features[4], hdev->le_features[5],
+			   hdev->le_features[6], hdev->le_features[7]);
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int features_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, features_show, inode->i_private);
+}
+
+static const struct file_operations features_fops = {
+	.open		= features_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int device_list_show(struct seq_file *f, void *ptr)
+{
+	struct hci_dev *hdev = f->private;
+	struct hci_conn_params *p;
+	struct bdaddr_list *b;
+
+	hci_dev_lock(hdev);
+	list_for_each_entry(b, &hdev->whitelist, list)
+		seq_printf(f, "%pMR (type %u)\n", &b->bdaddr, b->bdaddr_type);
+	list_for_each_entry(p, &hdev->le_conn_params, list) {
+		seq_printf(f, "%pMR (type %u) %u\n", &p->addr, p->addr_type,
+			   p->auto_connect);
+	}
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int device_list_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, device_list_show, inode->i_private);
+}
+
+static const struct file_operations device_list_fops = {
+	.open		= device_list_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int blacklist_show(struct seq_file *f, void *p)
+{
+	struct hci_dev *hdev = f->private;
+	struct bdaddr_list *b;
+
+	hci_dev_lock(hdev);
+	list_for_each_entry(b, &hdev->blacklist, list)
+		seq_printf(f, "%pMR (type %u)\n", &b->bdaddr, b->bdaddr_type);
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
+static int uuids_show(struct seq_file *f, void *p)
+{
+	struct hci_dev *hdev = f->private;
+	struct bt_uuid *uuid;
+
+	hci_dev_lock(hdev);
+	list_for_each_entry(uuid, &hdev->uuids, list) {
+		u8 i, val[16];
+
+		/* The Bluetooth UUID values are stored in big endian,
+		 * but with reversed byte order. So convert them into
+		 * the right order for the %pUb modifier.
+		 */
+		for (i = 0; i < 16; i++)
+			val[i] = uuid->uuid[15 - i];
+
+		seq_printf(f, "%pUb\n", val);
+	}
+	hci_dev_unlock(hdev);
+
+       return 0;
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
+static int conn_info_min_age_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+
+	if (val == 0 || val > hdev->conn_info_max_age)
+		return -EINVAL;
+
+	hci_dev_lock(hdev);
+	hdev->conn_info_min_age = val;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int conn_info_min_age_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->conn_info_min_age;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(conn_info_min_age_fops, conn_info_min_age_get,
+			conn_info_min_age_set, "%llu\n");
+
+static int conn_info_max_age_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+
+	if (val == 0 || val < hdev->conn_info_min_age)
+		return -EINVAL;
+
+	hci_dev_lock(hdev);
+	hdev->conn_info_max_age = val;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int conn_info_max_age_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->conn_info_max_age;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(conn_info_max_age_fops, conn_info_max_age_get,
+			conn_info_max_age_set, "%llu\n");
+
 void hci_debugfs_create_common(struct hci_dev *hdev)
 {
+	debugfs_create_file("features", 0444, hdev->debugfs, hdev,
+			    &features_fops);
+	debugfs_create_u16("manufacturer", 0444, hdev->debugfs,
+			   &hdev->manufacturer);
+	debugfs_create_u8("hci_version", 0444, hdev->debugfs, &hdev->hci_ver);
+	debugfs_create_u16("hci_revision", 0444, hdev->debugfs, &hdev->hci_rev);
+	debugfs_create_file("device_list", 0444, hdev->debugfs, hdev,
+			    &device_list_fops);
+	debugfs_create_file("blacklist", 0444, hdev->debugfs, hdev,
+			    &blacklist_fops);
+	debugfs_create_file("uuids", 0444, hdev->debugfs, hdev, &uuids_fops);
+
+	debugfs_create_file("conn_info_min_age", 0644, hdev->debugfs, hdev,
+			    &conn_info_min_age_fops);
+	debugfs_create_file("conn_info_max_age", 0644, hdev->debugfs, hdev,
+			    &conn_info_max_age_fops);
 }
 
 void hci_debugfs_create_bredr(struct hci_dev *hdev)
-- 
2.1.0

