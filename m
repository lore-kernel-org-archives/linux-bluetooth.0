Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/7] Bluetooth: Expose current list of link keys via debugfs
Date: Fri, 18 Oct 2013 12:04:52 -0700
Message-Id: <1382123092-35256-7-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For debugging purposes expose the current list of link keys via
debugfs. This file is read-only and limited to root access.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3ef5fdd..ee946cb 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -187,6 +187,34 @@ static const struct file_operations inquiry_cache_fops = {
 	.release	= single_release,
 };
 
+static int link_keys_show(struct seq_file *f, void *ptr)
+{
+	struct hci_dev *hdev = f->private;
+	struct list_head *p, *n;
+
+	hci_dev_lock(hdev);
+	list_for_each_safe(p, n, &hdev->link_keys) {
+		struct link_key *key = list_entry(p, struct link_key, list);
+		seq_printf(f, "%pMR %u %*phN %u\n", &key->bdaddr, key->type,
+			   HCI_LINK_KEY_SIZE, key->val, key->pin_len);
+	}
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int link_keys_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, link_keys_show, inode->i_private);
+}
+
+static const struct file_operations link_keys_fops = {
+	.open		= link_keys_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static int dev_class_show(struct seq_file *f, void *ptr)
 {
 	struct hci_dev *hdev = f->private;
@@ -1067,6 +1095,8 @@ static int __hci_init(struct hci_dev *hdev)
 	if (lmp_bredr_capable(hdev)) {
 		debugfs_create_file("inquiry_cache", 0444, hdev->debugfs,
 				    hdev, &inquiry_cache_fops);
+		debugfs_create_file("link_keys", 0400, hdev->debugfs,
+				    hdev, &link_keys_fops);
 		debugfs_create_file("dev_class", 0444, hdev->debugfs,
 				    hdev, &dev_class_fops);
 		debugfs_create_file("voice_setting", 0444, hdev->debugfs,
-- 
1.8.3.1

