Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/7] Bluetooth: Move manufacturer, hci_ver and hci_rev into hci_core.c
Date: Fri, 18 Oct 2013 12:04:49 -0700
Message-Id: <1382123092-35256-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Move the debugfs entries for manufacturer, hci_ver and hci_rev into
hci_core.c and use the new helpers for static entries that will not
change at runtime. Once passed the setup procedure, they will stay
fixed.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c  |  4 ++++
 net/bluetooth/hci_sysfs.c | 27 ---------------------------
 2 files changed, 4 insertions(+), 27 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e445f35..1d3c892 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1032,6 +1032,10 @@ static int __hci_init(struct hci_dev *hdev)
 
 	debugfs_create_file("features", 0444, hdev->debugfs, hdev,
 			    &features_fops);
+	debugfs_create_u16("manufacturer", 0444, hdev->debugfs,
+			   &hdev->manufacturer);
+	debugfs_create_u8("hci_version", 0444, hdev->debugfs, &hdev->hci_ver);
+	debugfs_create_u16("hci_revision", 0444, hdev->debugfs, &hdev->hci_rev);
 	debugfs_create_file("blacklist", 0444, hdev->debugfs, hdev,
 			    &blacklist_fops);
 	debugfs_create_file("uuids", 0444, hdev->debugfs, hdev, &uuids_fops);
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index c5aa42f..acc6a2a 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -208,35 +208,11 @@ static ssize_t show_address(struct device *dev,
 	return sprintf(buf, "%pMR\n", &hdev->bdaddr);
 }
 
-static ssize_t show_manufacturer(struct device *dev,
-				 struct device_attribute *attr, char *buf)
-{
-	struct hci_dev *hdev = to_hci_dev(dev);
-	return sprintf(buf, "%d\n", hdev->manufacturer);
-}
-
-static ssize_t show_hci_version(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct hci_dev *hdev = to_hci_dev(dev);
-	return sprintf(buf, "%d\n", hdev->hci_ver);
-}
-
-static ssize_t show_hci_revision(struct device *dev,
-				 struct device_attribute *attr, char *buf)
-{
-	struct hci_dev *hdev = to_hci_dev(dev);
-	return sprintf(buf, "%d\n", hdev->hci_rev);
-}
-
 static DEVICE_ATTR(bus, S_IRUGO, show_bus, NULL);
 static DEVICE_ATTR(type, S_IRUGO, show_type, NULL);
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 static DEVICE_ATTR(class, S_IRUGO, show_class, NULL);
 static DEVICE_ATTR(address, S_IRUGO, show_address, NULL);
-static DEVICE_ATTR(manufacturer, S_IRUGO, show_manufacturer, NULL);
-static DEVICE_ATTR(hci_version, S_IRUGO, show_hci_version, NULL);
-static DEVICE_ATTR(hci_revision, S_IRUGO, show_hci_revision, NULL);
 
 static struct attribute *bt_host_attrs[] = {
 	&dev_attr_bus.attr,
@@ -244,9 +220,6 @@ static struct attribute *bt_host_attrs[] = {
 	&dev_attr_name.attr,
 	&dev_attr_class.attr,
 	&dev_attr_address.attr,
-	&dev_attr_manufacturer.attr,
-	&dev_attr_hci_version.attr,
-	&dev_attr_hci_revision.attr,
 	NULL
 };
 
-- 
1.8.3.1

