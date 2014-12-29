Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/5] Bluetooth: Add skeleton for debugfs-based SMP self-tests
Date: Mon, 29 Dec 2014 12:11:24 +0200
Message-Id: <1419847887-7604-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1419847887-7604-1-git-send-email-johan.hedberg@gmail.com>
References: <1419847887-7604-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds the basic initialization and cleanup of a selftest file
in debugfs to be used for triggering SMP self-tests. This is an
alternative approach to the independent module one which doesn't require
exporting the SMP crypto functions anywhere.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/bluetooth.h |  3 ++
 net/bluetooth/Kconfig             |  9 +++++
 net/bluetooth/af_bluetooth.c      |  4 ++
 net/bluetooth/smp.c               | 77 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 93 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 58695ffeb138..35a08cfed113 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -358,6 +358,9 @@ void l2cap_exit(void);
 int sco_init(void);
 void sco_exit(void);
 
+void bt_smp_init(void);
+void bt_smp_exit(void);
+
 void bt_sock_reclassify_lock(struct sock *sk, int proto);
 
 #endif /* __BLUETOOTH_H */
diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index 29bcafc41adf..af6a827b2d96 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -64,4 +64,13 @@ config BT_6LOWPAN
 	help
 	  IPv6 compression over Bluetooth Low Energy.
 
+config BT_SELFTEST
+        bool "Include self-tests that can be triggered through debugfs"
+        depends on BT_LE && DEBUG_KERNEL
+        help
+          This option creates debugfs files that can be used to trigger
+	  various self-tests. For now this is limited to SMP which will
+	  expose a smp_selftest file. To run the tests simply do a
+	  'cat smp_selftest' which will then print the result.
+
 source "drivers/bluetooth/Kconfig"
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 012e3b03589d..e735b838d2df 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -744,6 +744,8 @@ static int __init bt_init(void)
 		goto sock_err;
 	}
 
+	bt_smp_init();
+
 	return 0;
 
 sock_err:
@@ -758,6 +760,8 @@ error:
 
 static void __exit bt_exit(void)
 {
+	bt_smp_exit();
+
 	sco_exit();
 
 	l2cap_exit();
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 9025e177d278..79af975e83ab 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -23,6 +23,7 @@
 #include <linux/crypto.h>
 #include <linux/scatterlist.h>
 #include <crypto/b128ops.h>
+#include <linux/debugfs.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -3022,3 +3023,79 @@ void smp_unregister(struct hci_dev *hdev)
 		smp_del_chan(chan);
 	}
 }
+
+#ifdef CONFIG_BT_SELFTEST
+
+static int run_selftests(struct seq_file *f, struct crypto_blkcipher *tfm_aes,
+			 struct crypto_hash *tfm_cmac)
+{
+	return 0;
+}
+
+static int smp_selftest_show(struct seq_file *f, void *p)
+{
+	struct crypto_blkcipher *tfm_aes;
+	struct crypto_hash *tfm_cmac;
+	int err;
+
+	tfm_aes = crypto_alloc_blkcipher("ecb(aes)", 0, CRYPTO_ALG_ASYNC);
+	if (IS_ERR(tfm_aes)) {
+		seq_printf(f, "Unable to create ECB crypto context\n");
+		return 0;
+	}
+
+	tfm_cmac = crypto_alloc_hash("cmac(aes)", 0, CRYPTO_ALG_ASYNC);
+	if (IS_ERR(tfm_cmac)) {
+		seq_printf(f, "Unable to create CMAC crypto context\n");
+		crypto_free_blkcipher(tfm_aes);
+		return 0;
+	}
+
+	err = run_selftests(f, tfm_aes, tfm_cmac);
+	if (err < 0)
+		seq_printf(f, "Self tests failed\n");
+	else
+		seq_printf(f, "Self-tests passed\n");
+
+	crypto_free_hash(tfm_cmac);
+	crypto_free_blkcipher(tfm_aes);
+
+	return 0;
+}
+
+static int smp_selftest_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, smp_selftest_show, inode->i_private);
+}
+
+static const struct file_operations smp_selftest_fops = {
+	.open		= smp_selftest_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static struct dentry *smp_debugfs;
+
+void __init bt_smp_init(void)
+{
+	smp_debugfs = debugfs_create_file("smp_selftest", 0444, bt_debugfs,
+					    NULL, &smp_selftest_fops);
+}
+
+void bt_smp_exit(void)
+{
+	debugfs_remove(smp_debugfs);
+}
+
+#else
+
+void __init bt_smp_init(void)
+{
+}
+
+void bt_smp_exit(void)
+{
+}
+
+#endif /* CONFIG_BT_SELFTEST */
-- 
2.1.0

