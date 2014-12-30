Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Add skeleton for SMP self-tests
Date: Tue, 30 Dec 2014 09:50:39 +0200
Message-Id: <1419925841-27185-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1419925841-27185-1-git-send-email-johan.hedberg@gmail.com>
References: <1419925841-27185-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds the initial skeleton and kernel config option for SMP
self-tests.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/Kconfig    |  7 +++++++
 net/bluetooth/selftest.c |  7 +++++++
 net/bluetooth/smp.c      | 39 +++++++++++++++++++++++++++++++++++++++
 net/bluetooth/smp.h      | 13 +++++++++++++
 4 files changed, 66 insertions(+)

diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index 8d3b607a72be..7de74635a110 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -84,4 +84,11 @@ config BT_SELFTEST_ECDH
 	  Run test cases for ECDH cryptographic functionality used by the
 	  Bluetooth Low Energy Secure Connections feature.
 
+config BT_SELFTEST_SMP
+	bool "SMP test cases"
+	depends on BT_LE && BT_SELFTEST
+	help
+	  Run test cases for SMP cryptographic functionality, including both
+	  legacy SMP as well as the Secure Connections features.
+
 source "drivers/bluetooth/Kconfig"
diff --git a/net/bluetooth/selftest.c b/net/bluetooth/selftest.c
index b9cb33cd45d7..a7602b3d0b0d 100644
--- a/net/bluetooth/selftest.c
+++ b/net/bluetooth/selftest.c
@@ -22,8 +22,10 @@
 */
 
 #include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
 
 #include "ecc.h"
+#include "smp.h"
 #include "selftest.h"
 
 #if IS_ENABLED(CONFIG_BT_SELFTEST_ECDH)
@@ -195,7 +197,12 @@ static int __init run_selftest(void)
 	BT_INFO("Starting self testing");
 
 	err = test_ecdh();
+	if (err)
+		goto done;
 
+	err = bt_selftest_smp();
+
+done:
 	BT_INFO("Finished self testing");
 
 	return err;
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 9025e177d278..b47528d66a5f 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3022,3 +3022,42 @@ void smp_unregister(struct hci_dev *hdev)
 		smp_del_chan(chan);
 	}
 }
+
+#if IS_ENABLED(CONFIG_BT_SELFTEST_SMP)
+
+static int __init run_selftests(struct crypto_blkcipher *tfm_aes,
+				struct crypto_hash *tfm_cmac)
+{
+	BT_INFO("SMP test passed");
+
+	return 0;
+}
+
+int __init bt_selftest_smp(void)
+{
+	struct crypto_blkcipher *tfm_aes;
+	struct crypto_hash *tfm_cmac;
+	int err;
+
+	tfm_aes = crypto_alloc_blkcipher("ecb(aes)", 0, CRYPTO_ALG_ASYNC);
+	if (IS_ERR(tfm_aes)) {
+		BT_ERR("Unable to create ECB crypto context");
+		return PTR_ERR(tfm_aes);
+	}
+
+	tfm_cmac = crypto_alloc_hash("cmac(aes)", 0, CRYPTO_ALG_ASYNC);
+	if (IS_ERR(tfm_cmac)) {
+		BT_ERR("Unable to create CMAC crypto context");
+		crypto_free_blkcipher(tfm_aes);
+		return PTR_ERR(tfm_cmac);
+	}
+
+	err = run_selftests(tfm_aes, tfm_cmac);
+
+	crypto_free_hash(tfm_cmac);
+	crypto_free_blkcipher(tfm_aes);
+
+	return err;
+}
+
+#endif
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index 3296bf42ae80..60c5b73fcb4b 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -192,4 +192,17 @@ int smp_generate_rpa(struct hci_dev *hdev, const u8 irk[16], bdaddr_t *rpa);
 int smp_register(struct hci_dev *hdev);
 void smp_unregister(struct hci_dev *hdev);
 
+#if IS_ENABLED(CONFIG_BT_SELFTEST_SMP)
+
+int bt_selftest_smp(void);
+
+#else
+
+static inline int bt_selftest_smp(void)
+{
+	return 0;
+}
+
+#endif
+
 #endif /* __SMP_H */
-- 
2.1.0

