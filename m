Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Add debugfs fields for hardware and firmware info
Date: Sun, 17 Jul 2016 19:55:16 +0200
Message-Id: <1468778117-62931-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some Bluetooth controllers allow for reading hardware and firmware
related vendor specific infos. If they are available, then they can be
exposed via debugfs now.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  4 ++++
 net/bluetooth/hci_core.c         | 24 ++++++++++++++++++++++++
 net/bluetooth/hci_debugfs.c      | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 84d0273d826a..ee7fc47680a1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -372,6 +372,8 @@ struct hci_dev {
 
 	atomic_t		promisc;
 
+	const char		*hw_info;
+	const char		*fw_info;
 	struct dentry		*debugfs;
 
 	struct device		dev;
@@ -1024,6 +1026,8 @@ int hci_resume_dev(struct hci_dev *hdev);
 int hci_reset_dev(struct hci_dev *hdev);
 int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb);
 int hci_recv_diag(struct hci_dev *hdev, struct sk_buff *skb);
+void hci_set_hw_info(struct hci_dev *hdev, const char *fmt, ...);
+void hci_set_fw_info(struct hci_dev *hdev, const char *fmt, ...);
 int hci_dev_open(__u16 dev);
 int hci_dev_close(__u16 dev);
 int hci_dev_do_close(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 98f6c3770736..ddf8432fe8fb 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3163,6 +3163,8 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	device_del(&hdev->dev);
 
 	debugfs_remove_recursive(hdev->debugfs);
+	kfree_const(hdev->hw_info);
+	kfree_const(hdev->fw_info);
 
 	destroy_workqueue(hdev->workqueue);
 	destroy_workqueue(hdev->req_workqueue);
@@ -3266,6 +3268,28 @@ int hci_recv_diag(struct hci_dev *hdev, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(hci_recv_diag);
 
+void hci_set_hw_info(struct hci_dev *hdev, const char *fmt, ...)
+{
+	va_list vargs;
+
+	va_start(vargs, fmt);
+	kfree_const(hdev->hw_info);
+	hdev->hw_info = kvasprintf_const(GFP_KERNEL, fmt, vargs);
+	va_end(vargs);
+}
+EXPORT_SYMBOL(hci_set_hw_info);
+
+void hci_set_fw_info(struct hci_dev *hdev, const char *fmt, ...)
+{
+	va_list vargs;
+
+	va_start(vargs, fmt);
+	kfree_const(hdev->fw_info);
+	hdev->fw_info = kvasprintf_const(GFP_KERNEL, fmt, vargs);
+	va_end(vargs);
+}
+EXPORT_SYMBOL(hci_set_fw_info);
+
 /* ---- Interface to upper protocols ---- */
 
 int hci_register_cb(struct hci_cb *cb)
diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 7db4220941cc..63df63ebfb24 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -76,6 +76,30 @@ static const struct file_operations __name ## _fops = {			      \
 	.llseek		= default_llseek,				      \
 }									      \
 
+#define DEFINE_INFO_ATTRIBUTE(__name, __field)				      \
+static int __name ## _show(struct seq_file *f, void *ptr)		      \
+{									      \
+	struct hci_dev *hdev = f->private;				      \
+									      \
+	hci_dev_lock(hdev);						      \
+	seq_printf(f, "%s\n", hdev->__field ? : "");			      \
+	hci_dev_unlock(hdev);						      \
+									      \
+	return 0;							      \
+}									      \
+									      \
+static int __name ## _open(struct inode *inode, struct file *file)	      \
+{									      \
+	return single_open(file, __name ## _show, inode->i_private);	      \
+}									      \
+									      \
+static const struct file_operations __name ## _fops = {			      \
+	.open		= __name ## _open,				      \
+	.read		= seq_read,					      \
+	.llseek		= seq_lseek,					      \
+	.release	= single_release,				      \
+}									      \
+
 static int features_show(struct seq_file *f, void *ptr)
 {
 	struct hci_dev *hdev = f->private;
@@ -349,6 +373,9 @@ static const struct file_operations sc_only_mode_fops = {
 	.llseek		= default_llseek,
 };
 
+DEFINE_INFO_ATTRIBUTE(hardware_info, hw_info);
+DEFINE_INFO_ATTRIBUTE(firmware_info, fw_info);
+
 void hci_debugfs_create_common(struct hci_dev *hdev)
 {
 	debugfs_create_file("features", 0444, hdev->debugfs, hdev,
@@ -382,6 +409,14 @@ void hci_debugfs_create_common(struct hci_dev *hdev)
 	if (lmp_sc_capable(hdev) || lmp_le_capable(hdev))
 		debugfs_create_file("sc_only_mode", 0444, hdev->debugfs,
 				    hdev, &sc_only_mode_fops);
+
+	if (hdev->hw_info)
+		debugfs_create_file("hardware_info", 0444, hdev->debugfs,
+				    hdev, &hardware_info_fops);
+
+	if (hdev->fw_info)
+		debugfs_create_file("firmware_info", 0444, hdev->debugfs,
+				    hdev, &firmware_info_fops);
 }
 
 static int inquiry_cache_show(struct seq_file *f, void *p)
-- 
2.7.4

