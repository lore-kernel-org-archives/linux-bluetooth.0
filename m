Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 May 2011 17:37:45 -0400 (EDT)
Message-Id: <20110519.173745.19153862714606787.davem@davemloft.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] bluetooth: Do not ignore errors returned from
 strict_strtol()
From: David Miller <davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/bluetooth/btmrvl_debugfs.c b/drivers/bluetooth/btmrvl_debugfs.c
index fd6305b..8ecf4c6 100644
--- a/drivers/bluetooth/btmrvl_debugfs.c
+++ b/drivers/bluetooth/btmrvl_debugfs.c
@@ -64,6 +64,8 @@ static ssize_t btmrvl_hscfgcmd_write(struct file *file,
 		return -EFAULT;
 
 	ret = strict_strtol(buf, 10, &result);
+	if (ret)
+		return ret;
 
 	priv->btmrvl_dev.hscfgcmd = result;
 
@@ -108,6 +110,8 @@ static ssize_t btmrvl_psmode_write(struct file *file, const char __user *ubuf,
 		return -EFAULT;
 
 	ret = strict_strtol(buf, 10, &result);
+	if (ret)
+		return ret;
 
 	priv->btmrvl_dev.psmode = result;
 
@@ -147,6 +151,8 @@ static ssize_t btmrvl_pscmd_write(struct file *file, const char __user *ubuf,
 		return -EFAULT;
 
 	ret = strict_strtol(buf, 10, &result);
+	if (ret)
+		return ret;
 
 	priv->btmrvl_dev.pscmd = result;
 
@@ -191,6 +197,8 @@ static ssize_t btmrvl_gpiogap_write(struct file *file, const char __user *ubuf,
 		return -EFAULT;
 
 	ret = strict_strtol(buf, 16, &result);
+	if (ret)
+		return ret;
 
 	priv->btmrvl_dev.gpio_gap = result;
 
@@ -230,6 +238,8 @@ static ssize_t btmrvl_hscmd_write(struct file *file, const char __user *ubuf,
 		return -EFAULT;
 
 	ret = strict_strtol(buf, 10, &result);
+	if (ret)
+		return ret;
 
 	priv->btmrvl_dev.hscmd = result;
 	if (priv->btmrvl_dev.hscmd) {
@@ -272,6 +282,8 @@ static ssize_t btmrvl_hsmode_write(struct file *file, const char __user *ubuf,
 		return -EFAULT;
 
 	ret = strict_strtol(buf, 10, &result);
+	if (ret)
+		return ret;
 
 	priv->btmrvl_dev.hsmode = result;
 
