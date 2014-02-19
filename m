Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Expose current list of identity resolving keys via debugfs
Date: Tue, 18 Feb 2014 21:54:49 -0800
Message-Id: <1392789289-40436-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For debugging purposes expose the current list of identity resolving
keys via debugfs. This file is read-only and limited to root access.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e4c5b9d6083c..e8f61b3fe87c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -599,6 +599,36 @@ static int own_address_type_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(own_address_type_fops, own_address_type_get,
 			own_address_type_set, "%llu\n");
 
+static int identity_resolving_keys_show(struct seq_file *f, void *ptr)
+{
+	struct hci_dev *hdev = f->private;
+	struct list_head *p, *n;
+
+	hci_dev_lock(hdev);
+	list_for_each_safe(p, n, &hdev->identity_resolving_keys) {
+		struct smp_irk *irk = list_entry(p, struct smp_irk, list);
+		seq_printf(f, "%pMR (type %u) %*phN %pMR\n",
+			   &irk->bdaddr, irk->addr_type,
+			   16, irk->val, &irk->rpa);
+	}
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int identity_resolving_keys_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, identity_resolving_keys_show,
+			   inode->i_private);
+}
+
+static const struct file_operations identity_resolving_keys_fops = {
+	.open		= identity_resolving_keys_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static int long_term_keys_show(struct seq_file *f, void *ptr)
 {
 	struct hci_dev *hdev = f->private;
@@ -1512,6 +1542,9 @@ static int __hci_init(struct hci_dev *hdev)
 				   hdev, &static_address_fops);
 		debugfs_create_file("own_address_type", 0644, hdev->debugfs,
 				    hdev, &own_address_type_fops);
+		debugfs_create_file("identity_resolving_keys", 0400,
+				    hdev->debugfs, hdev,
+				    &identity_resolving_keys_fops);
 		debugfs_create_file("long_term_keys", 0400, hdev->debugfs,
 				    hdev, &long_term_keys_fops);
 		debugfs_create_file("conn_min_interval", 0644, hdev->debugfs,
-- 
1.8.5.3

