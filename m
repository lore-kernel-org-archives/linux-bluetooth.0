Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 13/20] Bluetooth: Add function to derive AMP key using hmac
Date: Tue, 24 Jul 2012 16:21:54 +0300
Message-Id: <1343136121-22476-14-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1343136121-22476-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1343136121-22476-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Dmitry Kasatkin <dmitry.kasatkin@intel.com>

hmac(sha256) will be used for AMP key generation.

Signed-off-by: Dmitry Kasatkin <dmitry.kasatkin@intel.com>
Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/pal.c |   35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/net/bluetooth/pal.c b/net/bluetooth/pal.c
index 335cbc3..a405e88 100644
--- a/net/bluetooth/pal.c
+++ b/net/bluetooth/pal.c
@@ -12,6 +12,7 @@
 */
 
 #include <net/bluetooth/pal.h>
+#include <crypto/hash.h>
 
 enum pal_states {
 	DISCONNECTED,
@@ -220,3 +221,37 @@ struct phy_link *phylink_lookup(struct amp_mgr *mgr, u8 local_id, u8 remote_id)
 
 	return found;
 }
+
+int hmac_sha256(u8 *key, u8 ksize, char *plaintext, u8 psize, u8 *output)
+{
+	int ret = 0;
+	struct crypto_shash *tfm;
+
+	tfm = crypto_alloc_shash("hmac(sha256)", 0, 0);
+	if (IS_ERR(tfm)) {
+		BT_DBG("crypto_alloc_ahash failed");
+		return PTR_ERR(tfm);
+	}
+
+	if (ksize) {
+		ret = crypto_shash_setkey(tfm, key, ksize);
+		if (ret) {
+			BT_DBG("crypto_ahash_setkey failed");
+		} else {
+			struct {
+				struct shash_desc shash;
+				char ctx[crypto_shash_descsize(tfm)];
+			} desc;
+
+			desc.shash.tfm = tfm;
+			desc.shash.flags = CRYPTO_TFM_REQ_MAY_SLEEP;
+
+			ret = crypto_shash_digest(&desc.shash, plaintext, psize,
+						  output);
+		}
+	}
+
+	BT_DBG("ret 0x%x", ret);
+	crypto_free_shash(tfm);
+	return ret;
+}
-- 
1.7.9.5

