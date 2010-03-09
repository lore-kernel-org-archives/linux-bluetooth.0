Return-Path: <cyrus@holtmann.org>
From: Tomas Winkler <tomas.winkler@intel.com>
To: marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org
Cc: guy.cohen@intel.com,
	ron.rindjunsky@intel.com,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [bluetooth-next V2] bluetooth: hci_sysfs: use strict_strtoul instead of simple_strtoul
Date: Tue,  9 Mar 2010 21:38:03 +0200
Message-Id: <1268163483-26181-1-git-send-email-tomas.winkler@intel.com>
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

use strict_strtoul as suggested by checkpatch.pl

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V2:
1. more verbose commit message
2. return the error code that was produced by strict_strtoul 

 net/bluetooth/hci_sysfs.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 1a79a6c..dd11d61 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -282,12 +282,12 @@ static ssize_t show_idle_timeout(struct device *dev, struct device_attribute *at
 static ssize_t store_idle_timeout(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct hci_dev *hdev = dev_get_drvdata(dev);
-	char *ptr;
-	__u32 val;
+	unsigned long val;
+	int ret;
 
-	val = simple_strtoul(buf, &ptr, 10);
-	if (ptr == buf)
-		return -EINVAL;
+	ret = strict_strtoul(buf, 0, &val);
+	if (ret)
+		return ret;
 
 	if (val != 0 && (val < 500 || val > 3600000))
 		return -EINVAL;
@@ -306,12 +306,12 @@ static ssize_t show_sniff_max_interval(struct device *dev, struct device_attribu
 static ssize_t store_sniff_max_interval(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct hci_dev *hdev = dev_get_drvdata(dev);
-	char *ptr;
-	__u16 val;
+	unsigned long val;
+	int ret;
 
-	val = simple_strtoul(buf, &ptr, 10);
-	if (ptr == buf)
-		return -EINVAL;
+	ret = strict_strtoul(buf, 0, &val);
+	if (ret)
+		return ret;
 
 	if (val < 0x0002 || val > 0xFFFE || val % 2)
 		return -EINVAL;
@@ -333,12 +333,12 @@ static ssize_t show_sniff_min_interval(struct device *dev, struct device_attribu
 static ssize_t store_sniff_min_interval(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct hci_dev *hdev = dev_get_drvdata(dev);
-	char *ptr;
-	__u16 val;
+	unsigned long val;
+	int ret;
 
-	val = simple_strtoul(buf, &ptr, 10);
-	if (ptr == buf)
-		return -EINVAL;
+	ret = strict_strtoul(buf, 0, &val);
+	if (ret)
+		return ret;
 
 	if (val < 0x0002 || val > 0xFFFE || val % 2)
 		return -EINVAL;
-- 
1.6.6.1

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
