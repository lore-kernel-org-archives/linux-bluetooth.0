Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: mathewm@codeaurora.org, gustavo@padovan.org
Subject: [PATCHv5 12/17] Bluetooth: Add function to derive AMP key using hmac
Date: Mon, 17 Sep 2012 16:24:29 +0300
Message-Id: <1347888274-30779-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1347888274-30779-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1347437192-24694-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1347888274-30779-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
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
index bc2426a..8e28986 100644
--- a/net/bluetooth/pal.c
+++ b/net/bluetooth/pal.c
@@ -12,6 +12,7 @@
 */
 
 #include <net/bluetooth/pal.h>
+#include <crypto/hash.h>
 
 /* Remote AMP Controllers handling */
 static void amp_ctrl_get(struct amp_ctrl *ctrl)
@@ -122,3 +123,37 @@ struct hci_conn *phylink_add(struct hci_dev *hdev, struct amp_mgr *mgr,
 
 	return hcon;
 }
+
+int hmac_sha256(u8 *key, u8 ksize, char *plaintext, u8 psize, u8 *output)
+{
+	int ret = 0;
+	struct crypto_shash *tfm;
+
+	if (!ksize)
+		return -EINVAL;
+
+	tfm = crypto_alloc_shash("hmac(sha256)", 0, 0);
+	if (IS_ERR(tfm)) {
+		BT_DBG("crypto_alloc_ahash failed: err %ld", PTR_ERR(tfm));
+		return PTR_ERR(tfm);
+	}
+
+	ret = crypto_shash_setkey(tfm, key, ksize);
+	if (ret) {
+		BT_DBG("crypto_ahash_setkey failed: err %d", ret);
+	} else {
+		struct {
+			struct shash_desc shash;
+			char ctx[crypto_shash_descsize(tfm)];
+		} desc;
+
+		desc.shash.tfm = tfm;
+		desc.shash.flags = CRYPTO_TFM_REQ_MAY_SLEEP;
+
+		ret = crypto_shash_digest(&desc.shash, plaintext, psize,
+					  output);
+	}
+
+	crypto_free_shash(tfm);
+	return ret;
+}
-- 
1.7.9.5

