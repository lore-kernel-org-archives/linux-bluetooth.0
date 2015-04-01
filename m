Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Expose current Device ID information via debugfs
Date: Wed,  1 Apr 2015 13:21:37 -0700
Message-Id: <1427919697-11385-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For debugging purposes it is good to be able to read the current
configured Device ID details.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_debugfs.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index e6255833a258..7db4220941cc 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -114,6 +114,30 @@ static const struct file_operations features_fops = {
 	.release	= single_release,
 };
 
+static int device_id_show(struct seq_file *f, void *ptr)
+{
+	struct hci_dev *hdev = f->private;
+
+	hci_dev_lock(hdev);
+	seq_printf(f, "%4.4x:%4.4x:%4.4x:%4.4x\n", hdev->devid_source,
+		  hdev->devid_vendor, hdev->devid_product, hdev->devid_version);
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int device_id_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, device_id_show, inode->i_private);
+}
+
+static const struct file_operations device_id_fops = {
+	.open		= device_id_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static int device_list_show(struct seq_file *f, void *ptr)
 {
 	struct hci_dev *hdev = f->private;
@@ -335,6 +359,8 @@ void hci_debugfs_create_common(struct hci_dev *hdev)
 	debugfs_create_u16("hci_revision", 0444, hdev->debugfs, &hdev->hci_rev);
 	debugfs_create_u8("hardware_error", 0444, hdev->debugfs,
 			  &hdev->hw_error_code);
+	debugfs_create_file("device_id", 0444, hdev->debugfs, hdev,
+			    &device_id_fops);
 
 	debugfs_create_file("device_list", 0444, hdev->debugfs, hdev,
 			    &device_list_fops);
-- 
2.1.0

