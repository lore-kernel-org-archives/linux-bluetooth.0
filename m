Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 11/11] Bluetooth: Implement debugfs support for listing UUIDs
Date: Tue,  4 Jan 2011 12:08:52 +0200
Message-Id: <1294135732-26765-11-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1294135732-26765-1-git-send-email-johan.hedberg@gmail.com>
References: <1294135732-26765-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

This patch adds a debugfs entry to list the UUIDs that have been
registered through the management interface.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 net/bluetooth/hci_sysfs.c |   52 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 5fce3d6..23471dd 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -461,6 +461,56 @@ static const struct file_operations blacklist_fops = {
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
+
+static void print_bt_uuid(struct seq_file *f, u8 *uuid)
+{
+	u32 data0, data4;
+	u16 data1, data2, data3, data5;
+
+	memcpy(&data0, &uuid[0], 4);
+	memcpy(&data1, &uuid[4], 2);
+	memcpy(&data2, &uuid[6], 2);
+	memcpy(&data3, &uuid[8], 2);
+	memcpy(&data4, &uuid[10], 4);
+	memcpy(&data5, &uuid[14], 2);
+
+	seq_printf(f, "%.8x-%.4x-%.4x-%.4x-%.8x%.4x\n",
+				ntohl(data0), ntohs(data1), ntohs(data2),
+				ntohs(data3), ntohl(data4), ntohs(data5));
+}
+
+static int uuids_show(struct seq_file *f, void *p)
+{
+	struct hci_dev *hdev = f->private;
+	struct list_head *l;
+
+	hci_dev_lock_bh(hdev);
+
+	list_for_each(l, &hdev->uuids) {
+		struct bt_uuid *uuid;
+
+		uuid = list_entry(l, struct bt_uuid, list);
+
+		print_bt_uuid(f, uuid->uuid);
+	}
+
+	hci_dev_unlock_bh(hdev);
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
 int hci_register_sysfs(struct hci_dev *hdev)
 {
 	struct device *dev = &hdev->dev;
@@ -493,6 +543,8 @@ int hci_register_sysfs(struct hci_dev *hdev)
 	debugfs_create_file("blacklist", 0444, hdev->debugfs,
 						hdev, &blacklist_fops);
 
+	debugfs_create_file("uuids", 0444, hdev->debugfs, hdev, &uuids_fops);
+
 	return 0;
 }
 
-- 
1.7.2.3

