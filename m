Return-Path: <cyrus@holtmann.org>
Date: Sat, 6 Mar 2010 14:15:52 +0300
From: Dan Carpenter <error27@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Dave Young <hidave.darkstar@gmail.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Roger Quadros <ext-roger.quadros@nokia.com>,
	Bing Zhao <bzhao@marvell.com>, linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [patch] bluetooth: debugfs changes use too much stack
Message-ID: <20100306111552.GK4958@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

The original code would break with a 4K stack.

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
This was compile tested only.  Sorry about that.

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 1a79a6c..835758f 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -417,9 +417,11 @@ static ssize_t inquiry_cache_read(struct file *file, char __user *userbuf,
 	struct hci_dev *hdev = file->private_data;
 	struct inquiry_cache *cache = &hdev->inq_cache;
 	struct inquiry_entry *e;
-	char buf[4096];
+	char *buf;
 	int n = 0;
+	ssize_t ret;
 
+	buf = kmalloc(4096, GFP_KERNEL);
 	hci_dev_lock_bh(hdev);
 
 	for (e = cache->list; e; e = e->next) {
@@ -437,7 +439,10 @@ static ssize_t inquiry_cache_read(struct file *file, char __user *userbuf,
 
 	hci_dev_unlock_bh(hdev);
 
-	return simple_read_from_buffer(userbuf, count, ppos, buf, n);
+	ret = simple_read_from_buffer(userbuf, count, ppos, buf, n);
+	kfree(buf);
+
+	return ret;
 }
 
 static const struct file_operations inquiry_cache_fops = {
