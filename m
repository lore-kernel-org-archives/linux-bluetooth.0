Return-Path: <andriy.shevchenko@linux.intel.com>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] Bluetooth: btmrvl: Re-use kstrtol_from_user()
Date: Tue, 29 May 2018 16:33:49 +0300
Message-Id: <20180529133349.19814-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20180529133349.19814-1-andriy.shevchenko@linux.intel.com>
References: <20180529133349.19814-1-andriy.shevchenko@linux.intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Re-use kstrtol_from_user() instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/bluetooth/btmrvl_debugfs.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_debugfs.c b/drivers/bluetooth/btmrvl_debugfs.c
index 023d35e3c7a7..c4867576be00 100644
--- a/drivers/bluetooth/btmrvl_debugfs.c
+++ b/drivers/bluetooth/btmrvl_debugfs.c
@@ -35,15 +35,9 @@ static ssize_t btmrvl_hscfgcmd_write(struct file *file,
 			const char __user *ubuf, size_t count, loff_t *ppos)
 {
 	struct btmrvl_private *priv = file->private_data;
-	char buf[16];
 	long result, ret;
 
-	memset(buf, 0, sizeof(buf));
-
-	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
-		return -EFAULT;
-
-	ret = kstrtol(buf, 10, &result);
+	ret = kstrtol_from_user(ubuf, count, 10, &result);
 	if (ret)
 		return ret;
 
@@ -81,15 +75,9 @@ static ssize_t btmrvl_pscmd_write(struct file *file, const char __user *ubuf,
 						size_t count, loff_t *ppos)
 {
 	struct btmrvl_private *priv = file->private_data;
-	char buf[16];
 	long result, ret;
 
-	memset(buf, 0, sizeof(buf));
-
-	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
-		return -EFAULT;
-
-	ret = kstrtol(buf, 10, &result);
+	ret = kstrtol_from_user(ubuf, count, 10, &result);
 	if (ret)
 		return ret;
 
@@ -127,15 +115,9 @@ static ssize_t btmrvl_hscmd_write(struct file *file, const char __user *ubuf,
 						size_t count, loff_t *ppos)
 {
 	struct btmrvl_private *priv = file->private_data;
-	char buf[16];
 	long result, ret;
 
-	memset(buf, 0, sizeof(buf));
-
-	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
-		return -EFAULT;
-
-	ret = kstrtol(buf, 10, &result);
+	ret = kstrtol_from_user(ubuf, count, 10, &result);
 	if (ret)
 		return ret;
 
-- 
2.17.0
