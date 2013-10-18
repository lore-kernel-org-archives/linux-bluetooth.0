Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/7] Bluetooth: Move export of class of device information into hci_core.c
Date: Fri, 18 Oct 2013 12:04:51 -0700
Message-Id: <1382123092-35256-6-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The class of device debugfs information should be directly exported
from hci_core.c and so move them over there.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c  | 26 ++++++++++++++++++++++++++
 net/bluetooth/hci_sysfs.c | 10 ----------
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 1d3c892..3ef5fdd 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -187,6 +187,30 @@ static const struct file_operations inquiry_cache_fops = {
 	.release	= single_release,
 };
 
+static int dev_class_show(struct seq_file *f, void *ptr)
+{
+	struct hci_dev *hdev = f->private;
+
+	hci_dev_lock(hdev);
+	seq_printf(f, "0x%.2x%.2x%.2x\n", hdev->dev_class[2],
+		   hdev->dev_class[1], hdev->dev_class[0]);
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int dev_class_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, dev_class_show, inode->i_private);
+}
+
+static const struct file_operations dev_class_fops = {
+	.open		= dev_class_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static int voice_setting_get(void *data, u64 *val)
 {
 	struct hci_dev *hdev = data;
@@ -1043,6 +1067,8 @@ static int __hci_init(struct hci_dev *hdev)
 	if (lmp_bredr_capable(hdev)) {
 		debugfs_create_file("inquiry_cache", 0444, hdev->debugfs,
 				    hdev, &inquiry_cache_fops);
+		debugfs_create_file("dev_class", 0444, hdev->debugfs,
+				    hdev, &dev_class_fops);
 		debugfs_create_file("voice_setting", 0444, hdev->debugfs,
 				    hdev, &voice_setting_fops);
 	}
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index acc6a2a..95fc5bb 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -193,14 +193,6 @@ static ssize_t show_name(struct device *dev,
 	return sprintf(buf, "%s\n", name);
 }
 
-static ssize_t show_class(struct device *dev,
-			  struct device_attribute *attr, char *buf)
-{
-	struct hci_dev *hdev = to_hci_dev(dev);
-	return sprintf(buf, "0x%.2x%.2x%.2x\n", hdev->dev_class[2],
-		       hdev->dev_class[1], hdev->dev_class[0]);
-}
-
 static ssize_t show_address(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
@@ -211,14 +203,12 @@ static ssize_t show_address(struct device *dev,
 static DEVICE_ATTR(bus, S_IRUGO, show_bus, NULL);
 static DEVICE_ATTR(type, S_IRUGO, show_type, NULL);
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
-static DEVICE_ATTR(class, S_IRUGO, show_class, NULL);
 static DEVICE_ATTR(address, S_IRUGO, show_address, NULL);
 
 static struct attribute *bt_host_attrs[] = {
 	&dev_attr_bus.attr,
 	&dev_attr_type.attr,
 	&dev_attr_name.attr,
-	&dev_attr_class.attr,
 	&dev_attr_address.attr,
 	NULL
 };
-- 
1.8.3.1

