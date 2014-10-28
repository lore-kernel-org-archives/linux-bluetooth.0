Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Revert SMP self-test patches
Date: Tue, 28 Oct 2014 15:22:12 +0100
Message-Id: <1414506132-21330-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This reverts commits c6992e9ef2a17e9738b7bb8a03a7fe581a8f9977 and
4cd3362da899a59955146851dd860198b0aaaa75.

The reason for the revert is that we cannot have more than one module
initialization function and the SMP one breaks the build with modular
kernels. As the proper fix for this is right now looking non-trivial
it's better to simply revert the problematic patches in order to keep
the upstream tree compilable.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/Kconfig |   6 ---
 net/bluetooth/smp.c   | 120 --------------------------------------------------
 2 files changed, 126 deletions(-)

diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index 2675b4106b00..600fb29288f4 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -45,12 +45,6 @@ config BT_6LOWPAN
 	help
 	  IPv6 compression over Bluetooth Low Energy.
 
-config BT_SELFTEST
-	bool "Run self-tests on boot"
-	depends on BT && DEBUG_KERNEL
-	help
-	  Run self-tests during boot. Currently limited to SMP.
-
 source "net/bluetooth/rfcomm/Kconfig"
 
 source "net/bluetooth/bnep/Kconfig"
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 983d1e0793f6..fea3782989f4 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1743,123 +1743,3 @@ void smp_unregister(struct hci_dev *hdev)
 	hdev->smp_data = NULL;
 	l2cap_chan_put(chan);
 }
-
-#ifdef CONFIG_BT_SELFTEST
-
-static int __init test_ah(struct crypto_blkcipher *tfm_aes)
-{
-	u8 irk[16] = {	0x9b, 0x7d, 0x39, 0x0a, 0xa6, 0x10, 0x10, 0x34,
-			0x05, 0xad, 0xc8, 0x57, 0xa3, 0x34, 0x02, 0xec };
-	u8 r[3] = {	0x94, 0x81, 0x70 };
-	u8 exp[3] = {	0xaa, 0xfb, 0x0d };
-	u8 res[3];
-	int err;
-
-	err = smp_ah(tfm_aes, irk, r, res);
-	if (err)
-		return err;
-
-	if (memcmp(res, exp, 3) != 0)
-		return -EINVAL;
-
-	return 0;
-}
-
-static int __init test_c1(struct crypto_blkcipher *tfm_aes)
-{
-	u8 k[16] = {	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
-	u8 r[16] = {	0xe0, 0x2e, 0x70, 0xc6, 0x4e, 0x27, 0x88, 0x63,
-			0x0e, 0x6f, 0xad, 0x56, 0x21, 0xd5, 0x83, 0x57 };
-	u8 preq[7] = {	0x01, 0x01, 0x00, 0x00, 0x10, 0x07, 0x07 };
-	u8 pres[7] = {	0x02, 0x03, 0x00, 0x00, 0x08, 0x00, 0x05 };
-	u8 _iat =	0x01;
-	u8 _rat =	0x00;
-	bdaddr_t ra = { { 0xb6, 0xb5, 0xb4, 0xb3, 0xb2, 0xb1 } };
-	bdaddr_t ia = { { 0xa6, 0xa5, 0xa4, 0xa3, 0xa2, 0xa1 } };
-	u8 exp[16] = {	0x86, 0x3b, 0xf1, 0xbe, 0xc5, 0x4d, 0xa7, 0xd2,
-			0xea, 0x88, 0x89, 0x87, 0xef, 0x3f, 0x1e, 0x1e };
-	u8 res[16];
-	int err;
-
-	err = smp_c1(tfm_aes, k, r, preq, pres, _iat, &ia, _rat, &ra, res);
-	if (err)
-		return err;
-
-	if (memcmp(res, exp, 16) != 0)
-		return -EINVAL;
-
-	return 0;
-}
-
-static int __init test_s1(struct crypto_blkcipher *tfm_aes)
-{
-	u8 k[16] = {	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
-	u8 r1[16] = {	0x88, 0x77, 0x66, 0x55, 0x44, 0x33, 0x22, 0x11 };
-	u8 r2[16] = {	0x00, 0xff, 0xee, 0xdd, 0xcc, 0xbb, 0xaa, 0x99 };
-	u8 exp[16] = {	0x62, 0xa0, 0x6d, 0x79, 0xae, 0x16, 0x42, 0x5b,
-			0x9b, 0xf4, 0xb0, 0xe8, 0xf0, 0xe1, 0x1f, 0x9a };
-	u8 res[16];
-	int err;
-
-	err = smp_s1(tfm_aes, k, r1, r2, res);
-	if (err)
-		return err;
-
-	if (memcmp(res, exp, 16) != 0)
-		return -EINVAL;
-
-	return 0;
-}
-
-static int __init run_selftests(struct crypto_blkcipher *tfm_aes)
-{
-	int err;
-
-	err = test_ah(tfm_aes);
-	if (err) {
-		BT_ERR("smp_ah test failed");
-		return err;
-	}
-
-	err = test_c1(tfm_aes);
-	if (err) {
-		BT_ERR("smp_c1 test failed");
-		return err;
-	}
-
-	err = test_s1(tfm_aes);
-	if (err) {
-		BT_ERR("smp_s1 test failed");
-		return err;
-	}
-
-	return 0;
-}
-
-static int __init test_smp(void)
-{
-	struct crypto_blkcipher *tfm_aes;
-	int err;
-
-	tfm_aes = crypto_alloc_blkcipher("ecb(aes)", 0, CRYPTO_ALG_ASYNC);
-	if (IS_ERR(tfm_aes)) {
-		BT_ERR("Unable to create ECB crypto context");
-		return PTR_ERR(tfm_aes);
-	}
-
-	err = run_selftests(tfm_aes);
-	if (err < 0)
-		BT_ERR("Self tests failed");
-	else
-		BT_INFO("Self-tests passed");
-
-	crypto_free_blkcipher(tfm_aes);
-
-	return err;
-}
-
-module_init(test_smp);
-
-#endif /* CONFIG_BT_SELFTEST */
-- 
1.9.3

