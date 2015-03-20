Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v3] Bluetooth: expose quirks through debugfs
Date: Fri, 20 Mar 2015 10:54:12 -0700
Message-Id: <1426874052-3338-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch expose controller quirks through debugfs. It would be
useful for BlueZ tests using vhci. Currently there is no way to
test quirk dependent behaviour. It might be also useful for manual
testing.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 net/bluetooth/hci_debugfs.c | 59 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 0818fab..a45a0c8 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -28,6 +28,54 @@
 
 #include "hci_debugfs.h"
 
+#define DEFINE_QUIRK_ATTRIBUTE(ATTRIBUTE_NAME, QUIRK_NAME)		      \
+static ssize_t ATTRIBUTE_NAME##_read(struct file *file,			      \
+				char __user *user_buf,			      \
+				size_t count, loff_t *ppos)		      \
+{									      \
+	struct hci_dev *hdev = file->private_data;			      \
+	char buf[3];							      \
+									      \
+	buf[0] = test_bit(QUIRK_NAME, &hdev->quirks) ? 'Y' : 'N';	      \
+	buf[1] = '\n';							      \
+	buf[2] = '\0';							      \
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);	      \
+}									      \
+									      \
+static ssize_t ATTRIBUTE_NAME##_write(struct file *file,		      \
+				 const char __user *user_buf,		      \
+				 size_t count, loff_t *ppos)		      \
+{									      \
+	struct hci_dev *hdev = file->private_data;			      \
+	char buf[32];							      \
+	size_t buf_size = min(count, (sizeof(buf) - 1));		      \
+	bool enable;							      \
+									      \
+	if (test_bit(HCI_UP, &hdev->flags))				      \
+		return -EBUSY;						      \
+									      \
+	if (copy_from_user(buf, user_buf, buf_size))			      \
+		return -EFAULT;						      \
+									      \
+	buf[buf_size] = '\0';						      \
+	if (strtobool(buf, &enable))					      \
+		return -EINVAL;						      \
+									      \
+	if (enable == test_bit(QUIRK_NAME, &hdev->quirks))		      \
+		return -EALREADY;					      \
+									      \
+	change_bit(QUIRK_NAME, &hdev->quirks);				      \
+									      \
+	return count;							      \
+}									      \
+									      \
+static const struct file_operations ATTRIBUTE_NAME##_fops = {		      \
+	.open		= simple_open,					      \
+	.read		= ATTRIBUTE_NAME##_read,			      \
+	.write		= ATTRIBUTE_NAME##_write,			      \
+	.llseek		= default_llseek,				      \
+}									      \
+
 static int features_show(struct seq_file *f, void *ptr)
 {
 	struct hci_dev *hdev = f->private;
@@ -277,6 +325,11 @@ static const struct file_operations sc_only_mode_fops = {
 	.llseek		= default_llseek,
 };
 
+DEFINE_QUIRK_ATTRIBUTE(quirk_strict_duplicate_filter,
+		       HCI_QUIRK_STRICT_DUPLICATE_FILTER);
+DEFINE_QUIRK_ATTRIBUTE(quirk_simulteanous_discovery,
+		       HCI_QUIRK_SIMULTANEOUS_DISCOVERY);
+
 void hci_debugfs_create_common(struct hci_dev *hdev)
 {
 	debugfs_create_file("features", 0444, hdev->debugfs, hdev,
@@ -308,6 +361,12 @@ void hci_debugfs_create_common(struct hci_dev *hdev)
 	if (lmp_sc_capable(hdev) || lmp_le_capable(hdev))
 		debugfs_create_file("sc_only_mode", 0444, hdev->debugfs,
 				    hdev, &sc_only_mode_fops);
+	debugfs_create_file("quirk_strict_duplicate_filter", 0644,
+			    hdev->debugfs, hdev,
+			    &quirk_strict_duplicate_filter_fops);
+	debugfs_create_file("quirk_simulteanous_discovery", 0644,
+			    hdev->debugfs, hdev,
+			    &quirk_simulteanous_discovery_fops);
 }
 
 static int inquiry_cache_show(struct seq_file *f, void *p)
-- 
2.2.0.rc0.207.ga3a616c

