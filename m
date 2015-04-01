Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Export ECDH selftest result in debugfs
Date: Wed,  1 Apr 2015 12:52:12 -0700
Message-Id: <1427917933-32183-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When ECDH selftest is enabled, then besides printing the result into the
kernel message buffer, also create a debugfs file that allows retrieving
the same information.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/selftest.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/selftest.c b/net/bluetooth/selftest.c
index 378f4064952c..dc688f13e496 100644
--- a/net/bluetooth/selftest.c
+++ b/net/bluetooth/selftest.c
@@ -21,6 +21,8 @@
    SOFTWARE IS DISCLAIMED.
 */
 
+#include <linux/debugfs.h>
+
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
@@ -154,6 +156,21 @@ static int __init test_ecdh_sample(const u8 priv_a[32], const u8 priv_b[32],
 	return 0;
 }
 
+static char test_ecdh_buffer[32];
+
+static ssize_t test_ecdh_read(struct file *file, char __user *user_buf,
+			      size_t count, loff_t *ppos)
+{
+	return simple_read_from_buffer(user_buf, count, ppos, test_ecdh_buffer,
+				       strlen(test_ecdh_buffer));
+}
+
+static const struct file_operations test_ecdh_fops = {
+	.open		= simple_open,
+	.read		= test_ecdh_read,
+	.llseek		= default_llseek,
+};
+
 static int __init test_ecdh(void)
 {
 	ktime_t calltime, delta, rettime;
@@ -165,19 +182,19 @@ static int __init test_ecdh(void)
 	err = test_ecdh_sample(priv_a_1, priv_b_1, pub_a_1, pub_b_1, dhkey_1);
 	if (err) {
 		BT_ERR("ECDH sample 1 failed");
-		return err;
+		goto done;
 	}
 
 	err = test_ecdh_sample(priv_a_2, priv_b_2, pub_a_2, pub_b_2, dhkey_2);
 	if (err) {
 		BT_ERR("ECDH sample 2 failed");
-		return err;
+		goto done;
 	}
 
 	err = test_ecdh_sample(priv_a_3, priv_a_3, pub_a_3, pub_a_3, dhkey_3);
 	if (err) {
 		BT_ERR("ECDH sample 3 failed");
-		return err;
+		goto done;
 	}
 
 	rettime = ktime_get();
@@ -186,7 +203,17 @@ static int __init test_ecdh(void)
 
 	BT_INFO("ECDH test passed in %llu usecs", duration);
 
-	return 0;
+done:
+	if (!err)
+		snprintf(test_ecdh_buffer, sizeof(test_ecdh_buffer),
+			 "PASS (%llu usecs)\n", duration);
+	else
+		snprintf(test_ecdh_buffer, sizeof(test_ecdh_buffer), "FAIL\n");
+
+	debugfs_create_file("selftest_ecdh", 0444, bt_debugfs, NULL,
+			    &test_ecdh_fops);
+
+	return err;
 }
 
 #else
-- 
2.1.0

