Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Fengguang Wu <fengguang.wu@intel.com>
Subject: [PATCH] Bluetooth: Use memdup_user in le_auto_conn_write()
Date: Mon, 24 Mar 2014 16:08:48 -0300
Message-Id: <1395688128-30563-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch does a small code simplification replacing the tipical
kmalloc-copy_from_user sequence by memdup_user() helper.

Cc: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_core.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 1c6ffaa..bfc6f81 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -955,14 +955,9 @@ static ssize_t le_auto_conn_write(struct file *file, const char __user *data,
 	if (count < 3)
 		return -EINVAL;
 
-	buf = kzalloc(count, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	if (copy_from_user(buf, data, count)) {
-		err = -EFAULT;
-		goto done;
-	}
+	buf = memdup_user(data, count);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
 
 	if (memcmp(buf, "add", 3) == 0) {
 		n = sscanf(&buf[4], "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx %hhu %hhu",
-- 
1.9.0

