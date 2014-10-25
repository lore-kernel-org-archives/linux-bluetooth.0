Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Add skeleton for SMP self-tests
Date: Sat, 25 Oct 2014 21:15:38 +0200
Message-Id: <1414264539-19068-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1414264539-19068-1-git-send-email-johan.hedberg@gmail.com>
References: <1414264539-19068-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds a basic skeleton for SMP self-tests. The tests are put
behind a new configuration option since running them will slow down the
boot process. For now there are no actual tests defined but those will
come in a subsequent patch.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/Kconfig |  6 ++++++
 net/bluetooth/smp.c   | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index 600fb29288f4..2675b4106b00 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -45,6 +45,12 @@ config BT_6LOWPAN
 	help
 	  IPv6 compression over Bluetooth Low Energy.
 
+config BT_SELFTEST
+	bool "Run self-tests on boot"
+	depends on BT && DEBUG_KERNEL
+	help
+	  Run self-tests during boot. Currently limited to SMP.
+
 source "net/bluetooth/rfcomm/Kconfig"
 
 source "net/bluetooth/bnep/Kconfig"
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index fea3782989f4..9821dc938e2c 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1743,3 +1743,36 @@ void smp_unregister(struct hci_dev *hdev)
 	hdev->smp_data = NULL;
 	l2cap_chan_put(chan);
 }
+
+#ifdef CONFIG_BT_SELFTEST
+
+static int __init run_selftests(struct crypto_blkcipher *tfm_aes)
+{
+	return 0;
+}
+
+static int __init test_smp(void)
+{
+	struct crypto_blkcipher *tfm_aes;
+	int err;
+
+	tfm_aes = crypto_alloc_blkcipher("ecb(aes)", 0, CRYPTO_ALG_ASYNC);
+	if (IS_ERR(tfm_aes)) {
+		BT_ERR("Unable to create ECB crypto context");
+		return PTR_ERR(tfm_aes);
+	}
+
+	err = run_selftests(tfm_aes);
+	if (err < 0)
+		BT_ERR("Self tests failed");
+	else
+		BT_INFO("Self-tests passed");
+
+	crypto_free_blkcipher(tfm_aes);
+
+	return err;
+}
+
+module_init(test_smp);
+
+#endif /* CONFIG_BT_SELFTEST */
-- 
1.9.3

