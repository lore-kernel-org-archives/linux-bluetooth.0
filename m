Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Move idle_timeout and sniff_{min,max}_interval to hci_core.c
Date: Thu, 17 Oct 2013 19:16:02 -0700
Message-Id: <1382062562-20113-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Move the debugfs configuration directly into hci_core.c and only expose
it when the controller actually support BR/EDR sniff power saving mode.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c  | 93 +++++++++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_sysfs.c | 91 ----------------------------------------------
 2 files changed, 93 insertions(+), 91 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a4047d6..e8058c3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -195,6 +195,90 @@ static int auto_accept_delay_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(auto_accept_delay_fops, auto_accept_delay_get,
 			auto_accept_delay_set, "%llu\n");
 
+static int idle_timeout_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+
+	if (val != 0 && (val < 500 || val > 3600000))
+		return -EINVAL;
+
+	hci_dev_lock(hdev);
+	hdev->idle_timeout= val;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int idle_timeout_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->idle_timeout;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(idle_timeout_fops, idle_timeout_get,
+			idle_timeout_set, "%llu\n");
+
+static int sniff_min_interval_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+
+	if (val == 0 || val % 2 || val > hdev->sniff_max_interval)
+		return -EINVAL;
+
+	hci_dev_lock(hdev);
+	hdev->sniff_min_interval= val;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int sniff_min_interval_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->sniff_min_interval;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(sniff_min_interval_fops, sniff_min_interval_get,
+			sniff_min_interval_set, "%llu\n");
+
+static int sniff_max_interval_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+
+	if (val == 0 || val % 2 || val < hdev->sniff_min_interval)
+		return -EINVAL;
+
+	hci_dev_lock(hdev);
+	hdev->sniff_max_interval= val;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int sniff_max_interval_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->sniff_max_interval;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(sniff_max_interval_fops, sniff_max_interval_get,
+			sniff_max_interval_set, "%llu\n");
+
 static int static_address_show(struct seq_file *f, void *p)
 {
 	struct hci_dev *hdev = f->private;
@@ -923,6 +1007,15 @@ static int __hci_init(struct hci_dev *hdev)
 		debugfs_create_file("auto_accept_delay", 0644, hdev->debugfs,
 				    hdev, &auto_accept_delay_fops);
 
+	if (lmp_sniff_capable(hdev)) {
+		debugfs_create_file("idle_timeout", 0644, hdev->debugfs,
+				    hdev, &idle_timeout_fops);
+		debugfs_create_file("sniff_min_interval", 0644, hdev->debugfs,
+				    hdev, &sniff_min_interval_fops);
+		debugfs_create_file("sniff_max_interval", 0644, hdev->debugfs,
+				    hdev, &sniff_max_interval_fops);
+	}
+
 	if (lmp_le_capable(hdev))
 		debugfs_create_file("static_address", 0444, hdev->debugfs,
 				   hdev, &static_address_fops);
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 9cbf8fe..4fac57c 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -255,87 +255,6 @@ static ssize_t show_hci_revision(struct device *dev,
 	return sprintf(buf, "%d\n", hdev->hci_rev);
 }
 
-static ssize_t show_idle_timeout(struct device *dev,
-				 struct device_attribute *attr, char *buf)
-{
-	struct hci_dev *hdev = to_hci_dev(dev);
-	return sprintf(buf, "%d\n", hdev->idle_timeout);
-}
-
-static ssize_t store_idle_timeout(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf, size_t count)
-{
-	struct hci_dev *hdev = to_hci_dev(dev);
-	unsigned int val;
-	int rv;
-
-	rv = kstrtouint(buf, 0, &val);
-	if (rv < 0)
-		return rv;
-
-	if (val != 0 && (val < 500 || val > 3600000))
-		return -EINVAL;
-
-	hdev->idle_timeout = val;
-
-	return count;
-}
-
-static ssize_t show_sniff_max_interval(struct device *dev,
-				       struct device_attribute *attr, char *buf)
-{
-	struct hci_dev *hdev = to_hci_dev(dev);
-	return sprintf(buf, "%d\n", hdev->sniff_max_interval);
-}
-
-static ssize_t store_sniff_max_interval(struct device *dev,
-					struct device_attribute *attr,
-					const char *buf, size_t count)
-{
-	struct hci_dev *hdev = to_hci_dev(dev);
-	u16 val;
-	int rv;
-
-	rv = kstrtou16(buf, 0, &val);
-	if (rv < 0)
-		return rv;
-
-	if (val == 0 || val % 2 || val < hdev->sniff_min_interval)
-		return -EINVAL;
-
-	hdev->sniff_max_interval = val;
-
-	return count;
-}
-
-static ssize_t show_sniff_min_interval(struct device *dev,
-				       struct device_attribute *attr, char *buf)
-{
-	struct hci_dev *hdev = to_hci_dev(dev);
-	return sprintf(buf, "%d\n", hdev->sniff_min_interval);
-}
-
-static ssize_t store_sniff_min_interval(struct device *dev,
-					struct device_attribute *attr,
-					const char *buf, size_t count)
-{
-	struct hci_dev *hdev = to_hci_dev(dev);
-	u16 val;
-	int rv;
-
-	rv = kstrtou16(buf, 0, &val);
-	if (rv < 0)
-		return rv;
-
-	if (val == 0 || val % 2 || val > hdev->sniff_max_interval)
-		return -EINVAL;
-
-	hdev->sniff_min_interval = val;
-
-	return count;
-}
-
 static DEVICE_ATTR(bus, S_IRUGO, show_bus, NULL);
 static DEVICE_ATTR(type, S_IRUGO, show_type, NULL);
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
@@ -346,13 +265,6 @@ static DEVICE_ATTR(manufacturer, S_IRUGO, show_manufacturer, NULL);
 static DEVICE_ATTR(hci_version, S_IRUGO, show_hci_version, NULL);
 static DEVICE_ATTR(hci_revision, S_IRUGO, show_hci_revision, NULL);
 
-static DEVICE_ATTR(idle_timeout, S_IRUGO | S_IWUSR,
-		   show_idle_timeout, store_idle_timeout);
-static DEVICE_ATTR(sniff_max_interval, S_IRUGO | S_IWUSR,
-		   show_sniff_max_interval, store_sniff_max_interval);
-static DEVICE_ATTR(sniff_min_interval, S_IRUGO | S_IWUSR,
-		   show_sniff_min_interval, store_sniff_min_interval);
-
 static struct attribute *bt_host_attrs[] = {
 	&dev_attr_bus.attr,
 	&dev_attr_type.attr,
@@ -363,9 +275,6 @@ static struct attribute *bt_host_attrs[] = {
 	&dev_attr_manufacturer.attr,
 	&dev_attr_hci_version.attr,
 	&dev_attr_hci_revision.attr,
-	&dev_attr_idle_timeout.attr,
-	&dev_attr_sniff_max_interval.attr,
-	&dev_attr_sniff_min_interval.attr,
 	NULL
 };
 
-- 
1.8.3.1

