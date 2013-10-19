Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Expose setting if debug keys are used or not
Date: Fri, 18 Oct 2013 17:14:22 -0700
Message-Id: <1382141662-6799-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The system can be figured to accept and use debug keys. Expose this
value in debugfs for debugging purposes.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d47c8ec..94d5342 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -215,6 +215,24 @@ static const struct file_operations link_keys_fops = {
 	.release	= single_release,
 };
 
+static ssize_t use_debug_keys_read(struct file *file, char __user *user_buf,
+				   size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[3];
+
+	buf[0] = test_bit(HCI_DEBUG_KEYS, &hdev->dev_flags) ? 'Y': 'N';
+	buf[1] = '\n';
+	buf[2] = '\0';
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static const struct file_operations use_debug_keys_fops = {
+	.open		= simple_open,
+	.read		= use_debug_keys_read,
+	.llseek		= default_llseek,
+};
+
 static int dev_class_show(struct seq_file *f, void *ptr)
 {
 	struct hci_dev *hdev = f->private;
@@ -1166,6 +1184,8 @@ static int __hci_init(struct hci_dev *hdev)
 				    hdev, &inquiry_cache_fops);
 		debugfs_create_file("link_keys", 0400, hdev->debugfs,
 				    hdev, &link_keys_fops);
+		debugfs_create_file("use_debug_keys", 0444, hdev->debugfs,
+				    hdev, &use_debug_keys_fops);
 		debugfs_create_file("dev_class", 0444, hdev->debugfs,
 				    hdev, &dev_class_fops);
 		debugfs_create_file("voice_setting", 0444, hdev->debugfs,
-- 
1.8.3.1

