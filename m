Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	johan.hedberg@gmail.com,
	marcel@holtmann.org,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [RESEND PATCH 1/4] Bluetooth: Introduce to_hci_dev()
Date: Thu,  9 Feb 2012 21:58:30 +0100
Message-Id: <1328821115-12514-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

We currently use dev_set_drvdata to keep a pointer to ourself. This
doesn't make sense as we are the bus and not a driver. Therefore,
introduce to_hci_dev() so we can get a struct hci_dev pointer from a
struct device pointer.

dev_set/get_drvdata() is reserved for drivers that provide a device and
not for the bus using the device. The bus can use simple pointer
arithmetic to retrieve its private data.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
Acked in: Message-ID: <1327960525.1955.178.camel@aeonflux>

 include/net/bluetooth/hci_core.h |    2 ++
 net/bluetooth/hci_sysfs.c        |   33 ++++++++++++++++-----------------
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ccb24a4..221d772 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -623,6 +623,8 @@ static inline struct hci_dev *hci_dev_hold(struct hci_dev *d)
 #define hci_dev_lock(d)		mutex_lock(&d->lock)
 #define hci_dev_unlock(d)	mutex_unlock(&d->lock)
 
+#define to_hci_dev(d) container_of(d, struct hci_dev, dev)
+
 struct hci_dev *hci_dev_get(int index);
 struct hci_dev *hci_get_route(bdaddr_t *src, bdaddr_t *dst);
 
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index ec03ee2..2a0243a 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -189,19 +189,19 @@ static inline char *host_typetostr(int type)
 
 static ssize_t show_bus(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct hci_dev *hdev = dev_get_drvdata(dev);
+	struct hci_dev *hdev = to_hci_dev(dev);
 	return sprintf(buf, "%s\n", host_bustostr(hdev->bus));
 }
 
 static ssize_t show_type(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct hci_dev *hdev = dev_get_drvdata(dev);
+	struct hci_dev *hdev = to_hci_dev(dev);
 	return sprintf(buf, "%s\n", host_typetostr(hdev->dev_type));
 }
 
 static ssize_t show_name(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct hci_dev *hdev = dev_get_drvdata(dev);
+	struct hci_dev *hdev = to_hci_dev(dev);
 	char name[HCI_MAX_NAME_LENGTH + 1];
 	int i;
 
@@ -214,20 +214,20 @@ static ssize_t show_name(struct device *dev, struct device_attribute *attr, char
 
 static ssize_t show_class(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct hci_dev *hdev = dev_get_drvdata(dev);
+	struct hci_dev *hdev = to_hci_dev(dev);
 	return sprintf(buf, "0x%.2x%.2x%.2x\n",
 			hdev->dev_class[2], hdev->dev_class[1], hdev->dev_class[0]);
 }
 
 static ssize_t show_address(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct hci_dev *hdev = dev_get_drvdata(dev);
+	struct hci_dev *hdev = to_hci_dev(dev);
 	return sprintf(buf, "%s\n", batostr(&hdev->bdaddr));
 }
 
 static ssize_t show_features(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct hci_dev *hdev = dev_get_drvdata(dev);
+	struct hci_dev *hdev = to_hci_dev(dev);
 
 	return sprintf(buf, "0x%02x%02x%02x%02x%02x%02x%02x%02x\n",
 				hdev->features[0], hdev->features[1],
@@ -238,31 +238,31 @@ static ssize_t show_features(struct device *dev, struct device_attribute *attr,
 
 static ssize_t show_manufacturer(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct hci_dev *hdev = dev_get_drvdata(dev);
+	struct hci_dev *hdev = to_hci_dev(dev);
 	return sprintf(buf, "%d\n", hdev->manufacturer);
 }
 
 static ssize_t show_hci_version(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct hci_dev *hdev = dev_get_drvdata(dev);
+	struct hci_dev *hdev = to_hci_dev(dev);
 	return sprintf(buf, "%d\n", hdev->hci_ver);
 }
 
 static ssize_t show_hci_revision(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct hci_dev *hdev = dev_get_drvdata(dev);
+	struct hci_dev *hdev = to_hci_dev(dev);
 	return sprintf(buf, "%d\n", hdev->hci_rev);
 }
 
 static ssize_t show_idle_timeout(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct hci_dev *hdev = dev_get_drvdata(dev);
+	struct hci_dev *hdev = to_hci_dev(dev);
 	return sprintf(buf, "%d\n", hdev->idle_timeout);
 }
 
 static ssize_t store_idle_timeout(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct hci_dev *hdev = dev_get_drvdata(dev);
+	struct hci_dev *hdev = to_hci_dev(dev);
 	unsigned int val;
 	int rv;
 
@@ -280,13 +280,13 @@ static ssize_t store_idle_timeout(struct device *dev, struct device_attribute *a
 
 static ssize_t show_sniff_max_interval(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct hci_dev *hdev = dev_get_drvdata(dev);
+	struct hci_dev *hdev = to_hci_dev(dev);
 	return sprintf(buf, "%d\n", hdev->sniff_max_interval);
 }
 
 static ssize_t store_sniff_max_interval(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct hci_dev *hdev = dev_get_drvdata(dev);
+	struct hci_dev *hdev = to_hci_dev(dev);
 	u16 val;
 	int rv;
 
@@ -304,13 +304,13 @@ static ssize_t store_sniff_max_interval(struct device *dev, struct device_attrib
 
 static ssize_t show_sniff_min_interval(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct hci_dev *hdev = dev_get_drvdata(dev);
+	struct hci_dev *hdev = to_hci_dev(dev);
 	return sprintf(buf, "%d\n", hdev->sniff_min_interval);
 }
 
 static ssize_t store_sniff_min_interval(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct hci_dev *hdev = dev_get_drvdata(dev);
+	struct hci_dev *hdev = to_hci_dev(dev);
 	u16 val;
 	int rv;
 
@@ -370,7 +370,7 @@ static const struct attribute_group *bt_host_groups[] = {
 
 static void bt_host_release(struct device *dev)
 {
-	void *data = dev_get_drvdata(dev);
+	void *data = to_hci_dev(dev);
 	kfree(data);
 	module_put(THIS_MODULE);
 }
@@ -525,7 +525,6 @@ void hci_init_sysfs(struct hci_dev *hdev)
 	dev->class = bt_class;
 
 	__module_get(THIS_MODULE);
-	dev_set_drvdata(dev, hdev);
 	device_initialize(dev);
 }
 
-- 
1.7.9
