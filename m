Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Expose static address value for LE capable controllers
Date: Thu, 17 Oct 2013 11:45:09 -0700
Message-Id: <1382035509-43957-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For LE capable controllers, the static address can be configured. For
debugging purposes expose the value in debugfs.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index bb95ddd..3c1014c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -118,6 +118,29 @@ static int auto_accept_delay_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(auto_accept_delay_fops, auto_accept_delay_get,
 			auto_accept_delay_set, "%llu\n");
 
+static int static_address_show(struct seq_file *f, void *p)
+{
+	struct hci_dev *hdev = f->private;
+
+	hci_dev_lock(hdev);
+	seq_printf(f, "%pMR\n", &hdev->static_addr);
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int static_address_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, static_address_show, inode->i_private);
+}
+
+static const struct file_operations static_address_fops = {
+	.open		= static_address_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 /* ---- HCI requests ---- */
 
 static void hci_req_sync_complete(struct hci_dev *hdev, u8 result)
@@ -816,6 +839,10 @@ static int __hci_init(struct hci_dev *hdev)
 		debugfs_create_file("auto_accept_delay", 0644, hdev->debugfs,
 				    hdev, &auto_accept_delay_fops);
 
+	if (lmp_le_capable(hdev))
+		debugfs_create_file("static_address", 0444, hdev->debugfs,
+				   hdev, &static_address_fops);
+
 	return 0;
 }
 
-- 
1.8.3.1

