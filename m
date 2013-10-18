Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Expose current list of long term keys via debugfs
Date: Fri, 18 Oct 2013 15:56:57 -0700
Message-Id: <1382137017-56186-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For debugging purposes expose the current list of long term keys
via debugfs. This file is read-only and limited to root access.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8710d1f..6b1844f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -385,6 +385,36 @@ static const struct file_operations static_address_fops = {
 	.release	= single_release,
 };
 
+static int long_term_keys_show(struct seq_file *f, void *ptr)
+{
+	struct hci_dev *hdev = f->private;
+	struct list_head *p, *n;
+
+	hci_dev_lock(hdev);
+	list_for_each_safe(p, n, &hdev->link_keys) {
+		struct smp_ltk *ltk = list_entry(p, struct smp_ltk, list);
+		seq_printf(f, "%pMR (type %u) %u %u %u %.4x %*phN %*phN\\n",
+			   &ltk->bdaddr, ltk->bdaddr_type, ltk->authenticated,
+			   ltk->type, ltk->enc_size, __le16_to_cpu(ltk->ediv),
+			   8, ltk->rand, 16, ltk->val);
+	}
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int long_term_keys_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, long_term_keys_show, inode->i_private);
+}
+
+static const struct file_operations long_term_keys_fops = {
+	.open		= long_term_keys_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 /* ---- HCI requests ---- */
 
 static void hci_req_sync_complete(struct hci_dev *hdev, u8 result)
@@ -1121,6 +1151,8 @@ static int __hci_init(struct hci_dev *hdev)
 				  &hdev->le_white_list_size);
 		debugfs_create_file("static_address", 0444, hdev->debugfs,
 				   hdev, &static_address_fops);
+		debugfs_create_file("long_term_keys", 0400, hdev->debugfs,
+				    hdev, &long_term_keys_fops);
 	}
 
 	return 0;
-- 
1.8.3.1

