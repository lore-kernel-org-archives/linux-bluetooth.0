Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/7] Bluetooth: Move HCI device features into hci_core.c
Date: Fri, 18 Oct 2013 12:04:46 -0700
Message-Id: <1382123092-35256-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Move the handling of HCI device features debugfs into hci_core.c and
also extend it with handling of multiple feature pages.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c  | 34 +++++++++++++++++++++++++++++++++-
 net/bluetooth/hci_sysfs.c | 14 --------------
 2 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e8058c3..47fcb49 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -58,6 +58,37 @@ static void hci_notify(struct hci_dev *hdev, int event)
 
 /* ---- HCI debugfs entries ---- */
 
+static int features_show(struct seq_file *f, void *ptr)
+{
+	struct hci_dev *hdev = f->private;
+	u8 p;
+
+	hci_dev_lock(hdev);
+	for (p = 0; p < HCI_MAX_PAGES && p <= hdev->max_page; p++) {
+		seq_printf(f, "Page %u: 0x%2.2x 0x%2.2x 0x%2.2x 0x%2.2x "
+			   "0x%2.2x 0x%2.2x 0x%2.2x 0x%2.2x\n", p,
+			   hdev->features[p][0], hdev->features[p][1],
+			   hdev->features[p][2], hdev->features[p][3],
+			   hdev->features[p][4], hdev->features[p][5],
+			   hdev->features[p][6], hdev->features[p][7]);
+	}
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int features_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, features_show, inode->i_private);
+}
+
+static const struct file_operations features_fops = {
+	.open		= features_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static int blacklist_show(struct seq_file *f, void *p)
 {
 	struct hci_dev *hdev = f->private;
@@ -991,9 +1022,10 @@ static int __hci_init(struct hci_dev *hdev)
 	if (!test_bit(HCI_SETUP, &hdev->dev_flags))
 		return 0;
 
+	debugfs_create_file("features", 0444, hdev->debugfs, hdev,
+			    &features_fops);
 	debugfs_create_file("blacklist", 0444, hdev->debugfs, hdev,
 			    &blacklist_fops);
-
 	debugfs_create_file("uuids", 0444, hdev->debugfs, hdev, &uuids_fops);
 
 	if (lmp_bredr_capable(hdev)) {
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 4fac57c..90142ae 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -222,18 +222,6 @@ static ssize_t show_address(struct device *dev,
 	return sprintf(buf, "%pMR\n", &hdev->bdaddr);
 }
 
-static ssize_t show_features(struct device *dev,
-			     struct device_attribute *attr, char *buf)
-{
-	struct hci_dev *hdev = to_hci_dev(dev);
-
-	return sprintf(buf, "0x%02x%02x%02x%02x%02x%02x%02x%02x\n",
-		       hdev->features[0][0], hdev->features[0][1],
-		       hdev->features[0][2], hdev->features[0][3],
-		       hdev->features[0][4], hdev->features[0][5],
-		       hdev->features[0][6], hdev->features[0][7]);
-}
-
 static ssize_t show_manufacturer(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
@@ -260,7 +248,6 @@ static DEVICE_ATTR(type, S_IRUGO, show_type, NULL);
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 static DEVICE_ATTR(class, S_IRUGO, show_class, NULL);
 static DEVICE_ATTR(address, S_IRUGO, show_address, NULL);
-static DEVICE_ATTR(features, S_IRUGO, show_features, NULL);
 static DEVICE_ATTR(manufacturer, S_IRUGO, show_manufacturer, NULL);
 static DEVICE_ATTR(hci_version, S_IRUGO, show_hci_version, NULL);
 static DEVICE_ATTR(hci_revision, S_IRUGO, show_hci_revision, NULL);
@@ -271,7 +258,6 @@ static struct attribute *bt_host_attrs[] = {
 	&dev_attr_name.attr,
 	&dev_attr_class.attr,
 	&dev_attr_address.attr,
-	&dev_attr_features.attr,
 	&dev_attr_manufacturer.attr,
 	&dev_attr_hci_version.attr,
 	&dev_attr_hci_revision.attr,
-- 
1.8.3.1

