Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add selftest for ECDH key generation
Date: Sun, 30 Apr 2017 04:20:26 -0700
Message-Id: <20170430112026.3747-1-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since the ECDH key generation takes a different path, it needs to be
tested as well. For this generate the public debug key from the private
debug key and compare both.

This also moves the seeding of the private key into the SMP calling code
to allow for easier re-use of the ECDH key generation helper.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/ecdh_helper.c |  3 ---
 net/bluetooth/smp.c         | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/ecdh_helper.c b/net/bluetooth/ecdh_helper.c
index 2a65ca3fa8fa..24d4e60f8c48 100644
--- a/net/bluetooth/ecdh_helper.c
+++ b/net/bluetooth/ecdh_helper.c
@@ -22,7 +22,6 @@
  */
 #include "ecdh_helper.h"
 
-#include <linux/random.h>
 #include <linux/scatterlist.h>
 #include <crypto/kpp.h>
 #include <crypto/ecdh.h>
@@ -181,8 +180,6 @@ bool generate_ecdh_keys(u8 public_key[64], u8 private_key[32])
 		if (tries++ >= max_tries)
 			goto free_all;
 
-		get_random_bytes(private_key, 32);
-
 		/* Set private Key */
 		p.key = (char *)private_key;
 		crypto_ecdh_encode_key(buf, buf_len, &p);
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 40e921a9cc17..14585edc9439 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -569,6 +569,9 @@ int smp_generate_oob(struct hci_dev *hdev, u8 hash[16], u8 rand[16])
 		smp->debug_key = true;
 	} else {
 		while (true) {
+			/* Seed private key with random number */
+			get_random_bytes(smp->local_sk, 32);
+
 			/* Generate local key pair for Secure Connections */
 			if (!generate_ecdh_keys(smp->local_pk, smp->local_sk))
 				return -EIO;
@@ -1895,6 +1898,9 @@ static u8 sc_send_public_key(struct smp_chan *smp)
 		set_bit(SMP_FLAG_DEBUG_KEY, &smp->flags);
 	} else {
 		while (true) {
+			/* Seed private key with random number */
+			get_random_bytes(smp->local_sk, 32);
+
 			/* Generate local key pair for Secure Connections */
 			if (!generate_ecdh_keys(smp->local_pk, smp->local_sk))
 				return SMP_UNSPECIFIED;
@@ -3483,6 +3489,32 @@ void smp_unregister(struct hci_dev *hdev)
 
 #if IS_ENABLED(CONFIG_BT_SELFTEST_SMP)
 
+static inline void swap_digits(u64 *in, u64 *out, unsigned int ndigits)
+{
+	int i;
+
+	for (i = 0; i < ndigits; i++)
+		out[i] = __swab64(in[ndigits - 1 - i]);
+}
+
+static int __init test_debug_key(void)
+{
+	u8 pk[64], sk[32];
+
+	swap_digits((u64 *)debug_sk, (u64 *)sk, 4);
+
+	if (!generate_ecdh_keys(pk, sk))
+		return -EINVAL;
+
+	if (memcmp(sk, debug_sk, 32))
+		return -EINVAL;
+
+	if (memcmp(pk, debug_pk, 64))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int __init test_ah(struct crypto_cipher *tfm_aes)
 {
 	const u8 irk[16] = {
@@ -3738,6 +3770,12 @@ static int __init run_selftests(struct crypto_cipher *tfm_aes,
 
 	calltime = ktime_get();
 
+	err = test_debug_key();
+	if (err) {
+		BT_ERR("debug_key test failed");
+		goto done;
+	}
+
 	err = test_ah(tfm_aes);
 	if (err) {
 		BT_ERR("smp_ah test failed");
-- 
2.9.3

