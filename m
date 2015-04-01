Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Export SMP selftest result in debugfs
Date: Wed,  1 Apr 2015 12:52:13 -0700
Message-Id: <1427917933-32183-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When SMP selftest is enabled, then besides printing the result into the
kernel message buffer, also create a debugfs file that allows retrieving
the same information.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/smp.c | 43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 1910c5806974..1ab3dc9c8f99 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3549,6 +3549,21 @@ static int __init test_h6(struct crypto_hash *tfm_cmac)
 	return 0;
 }
 
+static char test_smp_buffer[32];
+
+static ssize_t test_smp_read(struct file *file, char __user *user_buf,
+			     size_t count, loff_t *ppos)
+{
+	return simple_read_from_buffer(user_buf, count, ppos, test_smp_buffer,
+				       strlen(test_smp_buffer));
+}
+
+static const struct file_operations test_smp_fops = {
+	.open		= simple_open,
+	.read		= test_smp_read,
+	.llseek		= default_llseek,
+};
+
 static int __init run_selftests(struct crypto_blkcipher *tfm_aes,
 				struct crypto_hash *tfm_cmac)
 {
@@ -3561,49 +3576,49 @@ static int __init run_selftests(struct crypto_blkcipher *tfm_aes,
 	err = test_ah(tfm_aes);
 	if (err) {
 		BT_ERR("smp_ah test failed");
-		return err;
+		goto done;
 	}
 
 	err = test_c1(tfm_aes);
 	if (err) {
 		BT_ERR("smp_c1 test failed");
-		return err;
+		goto done;
 	}
 
 	err = test_s1(tfm_aes);
 	if (err) {
 		BT_ERR("smp_s1 test failed");
-		return err;
+		goto done;
 	}
 
 	err = test_f4(tfm_cmac);
 	if (err) {
 		BT_ERR("smp_f4 test failed");
-		return err;
+		goto done;
 	}
 
 	err = test_f5(tfm_cmac);
 	if (err) {
 		BT_ERR("smp_f5 test failed");
-		return err;
+		goto done;
 	}
 
 	err = test_f6(tfm_cmac);
 	if (err) {
 		BT_ERR("smp_f6 test failed");
-		return err;
+		goto done;
 	}
 
 	err = test_g2(tfm_cmac);
 	if (err) {
 		BT_ERR("smp_g2 test failed");
-		return err;
+		goto done;
 	}
 
 	err = test_h6(tfm_cmac);
 	if (err) {
 		BT_ERR("smp_h6 test failed");
-		return err;
+		goto done;
 	}
 
 	rettime = ktime_get();
@@ -3612,7 +3627,17 @@ static int __init run_selftests(struct crypto_blkcipher *tfm_aes,
 
 	BT_INFO("SMP test passed in %llu usecs", duration);
 
-	return 0;
+done:
+	if (!err)
+		snprintf(test_smp_buffer, sizeof(test_smp_buffer),
+			 "PASS (%llu usecs)\n", duration);
+	else
+		snprintf(test_smp_buffer, sizeof(test_smp_buffer), "FAIL\n");
+
+	debugfs_create_file("selftest_smp", 0444, bt_debugfs, NULL,
+			    &test_smp_fops);
+
+	return err;
 }
 
 int __init bt_selftest_smp(void)
-- 
2.1.0

