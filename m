Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix sparse warning in amp.c
Date: Mon, 10 Nov 2014 10:26:21 +0200
Message-Id: <1415607981-20337-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This fixes the following sparse warning:

net/bluetooth/amp.c:152:53: warning: Variable length array is used.

The warning itself is probably harmless since this kind of usage of
shash_desc is present also in other places in the kernel (there's even a
convenience macro SHASH_DESC_ON_STACK available for defining such stack
variables). However, dynamically allocated versions are also used in
several places of the kernel (e.g. lib/kexec.c and lib/digsig.c) which
have the benefit of not exhibiting the sparse warning.

Since there are no more sparse warnings in the Bluetooth subsystem after
fixing this one it is now easier to spot whenever new ones might get
introduced by future patches.
---
 net/bluetooth/amp.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index 2640d78f30b8..ee016f039100 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -134,6 +134,7 @@ struct hci_conn *phylink_add(struct hci_dev *hdev, struct amp_mgr *mgr,
 static int hmac_sha256(u8 *key, u8 ksize, char *plaintext, u8 psize, u8 *output)
 {
 	struct crypto_shash *tfm;
+	struct shash_desc *shash;
 	int ret;
 
 	if (!ksize)
@@ -148,18 +149,24 @@ static int hmac_sha256(u8 *key, u8 ksize, char *plaintext, u8 psize, u8 *output)
 	ret = crypto_shash_setkey(tfm, key, ksize);
 	if (ret) {
 		BT_DBG("crypto_ahash_setkey failed: err %d", ret);
-	} else {
-		char desc[sizeof(struct shash_desc) +
-			crypto_shash_descsize(tfm)] CRYPTO_MINALIGN_ATTR;
-		struct shash_desc *shash = (struct shash_desc *)desc;
-
-		shash->tfm = tfm;
-		shash->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
+		goto failed;
+	}
 
-		ret = crypto_shash_digest(shash, plaintext, psize,
-					  output);
+	shash = kzalloc(sizeof(*shash) + crypto_shash_descsize(tfm),
+			GFP_KERNEL);
+	if (!shash) {
+		ret = -ENOMEM;
+		goto failed;
 	}
 
+	shash->tfm = tfm;
+	shash->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
+
+	ret = crypto_shash_digest(shash, plaintext, psize, output);
+
+	kfree(shash);
+
+failed:
 	crypto_free_shash(tfm);
 	return ret;
 }
-- 
2.1.0

