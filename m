Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 16/19] Bluetooth: Add function to derive AMP key using hmac
Date: Fri, 29 Jun 2012 17:46:49 +0300
Message-Id: <1340981212-21709-17-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Dmitry Kasatkin <dmitry.kasatkin@intel.com>

hmac(sha256) will be used for AMP key generation.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/pal.c |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/net/bluetooth/pal.c b/net/bluetooth/pal.c
index 35c9934..1c74912 100644
--- a/net/bluetooth/pal.c
+++ b/net/bluetooth/pal.c
@@ -226,3 +226,37 @@ struct phy_link *hci_phylink_lookup(struct amp_mgr *mgr, u8 local_id,
 
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

