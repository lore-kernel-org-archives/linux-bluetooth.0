Return-Path: <cyrus@holtmann.org>
From: Jingoo Han <jg1.han@samsung.com>
To: 'Marcel Holtmann' <marcel@holtmann.org>
Cc: 'Gustavo Padovan' <gustavo@padovan.org>,
 'Johan Hedberg' <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
 Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] bluetooth: replace strict_strtol() with kstrtol()
Date: Fri, 19 Jul 2013 16:09:38 +0900
Message-id: <000f01ce844e$eeba10d0$cc2e3270$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

The usage of strict_strtol() is not preferred, because
strict_strtol() is obsolete. Thus, kstrtol() should be
used.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/bluetooth/btmrvl_debugfs.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_debugfs.c b/drivers/bluetooth/btmrvl_debugfs.c
index db2c3c3..023d35e 100644
--- a/drivers/bluetooth/btmrvl_debugfs.c
+++ b/drivers/bluetooth/btmrvl_debugfs.c
@@ -43,7 +43,7 @@ static ssize_t btmrvl_hscfgcmd_write(struct file *file,
 	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
 		return -EFAULT;
 
-	ret = strict_strtol(buf, 10, &result);
+	ret = kstrtol(buf, 10, &result);
 	if (ret)
 		return ret;
 
@@ -89,7 +89,7 @@ static ssize_t btmrvl_pscmd_write(struct file *file, const char __user *ubuf,
 	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
 		return -EFAULT;
 
-	ret = strict_strtol(buf, 10, &result);
+	ret = kstrtol(buf, 10, &result);
 	if (ret)
 		return ret;
 
@@ -135,7 +135,7 @@ static ssize_t btmrvl_hscmd_write(struct file *file, const char __user *ubuf,
 	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
 		return -EFAULT;
 
-	ret = strict_strtol(buf, 10, &result);
+	ret = kstrtol(buf, 10, &result);
 	if (ret)
 		return ret;
 
-- 
1.7.10.4
