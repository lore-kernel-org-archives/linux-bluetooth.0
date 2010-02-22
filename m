Return-Path: <cyrus@holtmann.org>
From: Tomas Winkler <tomas.winkler@intel.com>
To: marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Cc: guy.cohen@intel.com, ron.rindjunsky@intel.com,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [bluetooth-next] bluetooth: hci_sysfs: use strict_strtoul instead of simple_strtoul
Date: Mon, 22 Feb 2010 15:05:33 +0200
Message-Id: <1266843933-28802-2-git-send-email-tomas.winkler@intel.com>
In-Reply-To: <1266843933-28802-1-git-send-email-tomas.winkler@intel.com>
References: <1266843933-28802-1-git-send-email-tomas.winkler@intel.com>
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 net/bluetooth/hci_sysfs.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 2bc6f6a..e4bfce5 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -286,11 +286,11 @@ static ssize_t show_idle_timeout(struct device *dev, struct device_attribute *at
 static ssize_t store_idle_timeout(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct hci_dev *hdev = dev_get_drvdata(dev);
-	char *ptr;
-	__u32 val;
+	unsigned long val;
+	int ret;
 
-	val = simple_strtoul(buf, &ptr, 10);
-	if (ptr == buf)
+	ret = strict_strtoul(buf, 0, &val);
+	if (ret)
 		return -EINVAL;
 
 	if (val != 0 && (val < 500 || val > 3600000))
@@ -310,11 +310,11 @@ static ssize_t show_sniff_max_interval(struct device *dev, struct device_attribu
 static ssize_t store_sniff_max_interval(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct hci_dev *hdev = dev_get_drvdata(dev);
-	char *ptr;
-	__u16 val;
+	unsigned long val;
+	int ret;
 
-	val = simple_strtoul(buf, &ptr, 10);
-	if (ptr == buf)
+	ret = strict_strtoul(buf, 0, &val);
+	if (ret)
 		return -EINVAL;
 
 	if (val < 0x0002 || val > 0xFFFE || val % 2)
@@ -337,11 +337,11 @@ static ssize_t show_sniff_min_interval(struct device *dev, struct device_attribu
 static ssize_t store_sniff_min_interval(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct hci_dev *hdev = dev_get_drvdata(dev);
-	char *ptr;
-	__u16 val;
+	unsigned long val;
+	int ret;
 
-	val = simple_strtoul(buf, &ptr, 10);
-	if (ptr == buf)
+	ret = strict_strtoul(buf, 0, &val);
+	if (ret)
 		return -EINVAL;
 
 	if (val < 0x0002 || val > 0xFFFE || val % 2)
-- 
1.6.0.6

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

