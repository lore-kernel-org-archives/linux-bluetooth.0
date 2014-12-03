Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 44/49] Bluetooth: Introduce SMP_DBG macro for low-level debuging
Date: Wed,  3 Dec 2014 17:02:38 +0200
Message-Id: <1417618963-18010-45-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The various inputs & outputs of the crypto functions as well as the
values of the ECDH keys can be considered security sensitive. They
should therefore not end up in dmesg by mistake. This patch introduces a
new SMP_DBG macro which requires explicit compilation with -DDEBUG to be
enabled. All crypto related data logs now use this macro instead of
BT_DBG.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 68 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 28 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 62ca2aaf72fa..7839354592f4 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -32,6 +32,18 @@
 #include "ecc.h"
 #include "smp.h"
 
+/* Low-level debug macros to be used for stuff that we don't want
+ * accidentially in dmesg, i.e. the values of the various crypto keys
+ * and the inputs & outputs of crypto functions.
+ */
+#ifdef DEBUG
+#define SMP_DBG(fmt, ...) printk(KERN_DEBUG "%s: " fmt, __func__, \
+				 ##__VA_ARGS__)
+#else
+#define SMP_DBG(fmt, ...) no_printk(KERN_DEBUG "%s: " fmt, __func__, \
+				    ##__VA_ARGS__)
+#endif
+
 #define SMP_ALLOW_CMD(smp, code)	set_bit(code, &smp->allow_cmd)
 
 /* Keys which are not distributed with Secure Connections */
@@ -154,8 +166,8 @@ static int aes_cmac(struct crypto_hash *tfm, const u8 k[16], const u8 *m,
 	swap_buf(k, tmp, 16);
 	swap_buf(m, msg_msb, len);
 
-	BT_DBG("msg (len %zu) %*phN", len, len, m);
-	BT_DBG("key %16phN", k);
+	SMP_DBG("msg (len %zu) %*phN", len, len, m);
+	SMP_DBG("key %16phN", k);
 
 	err = crypto_hash_setkey(tfm, tmp, 16);
 	if (err) {
@@ -179,7 +191,7 @@ static int aes_cmac(struct crypto_hash *tfm, const u8 k[16], const u8 *m,
 
 	swap_buf(mac_msb, mac, 16);
 
-	BT_DBG("mac %16phN", mac);
+	SMP_DBG("mac %16phN", mac);
 
 	return 0;
 }
@@ -190,9 +202,9 @@ static int smp_f4(struct crypto_hash *tfm_cmac, const u8 u[32], const u8 v[32],
 	u8 m[65];
 	int err;
 
-	BT_DBG("u %32phN", u);
-	BT_DBG("v %32phN", v);
-	BT_DBG("x %16phN z %02x", x, z);
+	SMP_DBG("u %32phN", u);
+	SMP_DBG("v %32phN", v);
+	SMP_DBG("x %16phN z %02x", x, z);
 
 	m[0] = z;
 	memcpy(m + 1, v, 32);
@@ -202,7 +214,7 @@ static int smp_f4(struct crypto_hash *tfm_cmac, const u8 u[32], const u8 v[32],
 	if (err)
 		return err;
 
-	BT_DBG("res %16phN", res);
+	SMP_DBG("res %16phN", res);
 
 	return err;
 }
@@ -223,15 +235,15 @@ static int smp_f5(struct crypto_hash *tfm_cmac, u8 w[32], u8 n1[16], u8 n2[16],
 	u8 m[53], t[16];
 	int err;
 
-	BT_DBG("w %32phN", w);
-	BT_DBG("n1 %16phN n2 %16phN", n1, n2);
-	BT_DBG("a1 %7phN a2 %7phN", a1, a2);
+	SMP_DBG("w %32phN", w);
+	SMP_DBG("n1 %16phN n2 %16phN", n1, n2);
+	SMP_DBG("a1 %7phN a2 %7phN", a1, a2);
 
 	err = aes_cmac(tfm_cmac, salt, w, 32, t);
 	if (err)
 		return err;
 
-	BT_DBG("t %16phN", t);
+	SMP_DBG("t %16phN", t);
 
 	memcpy(m, length, 2);
 	memcpy(m + 2, a2, 7);
@@ -246,7 +258,7 @@ static int smp_f5(struct crypto_hash *tfm_cmac, u8 w[32], u8 n1[16], u8 n2[16],
 	if (err)
 		return err;
 
-	BT_DBG("mackey %16phN", mackey);
+	SMP_DBG("mackey %16phN", mackey);
 
 	m[52] = 1; /* Counter */
 
@@ -254,7 +266,7 @@ static int smp_f5(struct crypto_hash *tfm_cmac, u8 w[32], u8 n1[16], u8 n2[16],
 	if (err)
 		return err;
 
-	BT_DBG("ltk %16phN", ltk);
+	SMP_DBG("ltk %16phN", ltk);
 
 	return 0;
 }
@@ -267,9 +279,9 @@ static int smp_f6(struct crypto_hash *tfm_cmac, const u8 w[16],
 	u8 m[65];
 	int err;
 
-	BT_DBG("w %16phN", w);
-	BT_DBG("n1 %16phN n2 %16phN", n1, n2);
-	BT_DBG("r %16phN io_cap %3phN a1 %7phN a2 %7phN", r, io_cap, a1, a2);
+	SMP_DBG("w %16phN", w);
+	SMP_DBG("n1 %16phN n2 %16phN", n1, n2);
+	SMP_DBG("r %16phN io_cap %3phN a1 %7phN a2 %7phN", r, io_cap, a1, a2);
 
 	memcpy(m, a2, 7);
 	memcpy(m + 7, a1, 7);
@@ -293,9 +305,9 @@ static int smp_g2(struct crypto_hash *tfm_cmac, const u8 u[32], const u8 v[32],
 	u8 m[80], tmp[16];
 	int err;
 
-	BT_DBG("u %32phN", u);
-	BT_DBG("v %32phN", v);
-	BT_DBG("x %16phN y %16phN", x, y);
+	SMP_DBG("u %32phN", u);
+	SMP_DBG("v %32phN", v);
+	SMP_DBG("x %16phN y %16phN", x, y);
 
 	memcpy(m, y, 16);
 	memcpy(m + 16, v, 32);
@@ -308,7 +320,7 @@ static int smp_g2(struct crypto_hash *tfm_cmac, const u8 u[32], const u8 v[32],
 	*val = get_unaligned_le32(tmp);
 	*val %= 1000000;
 
-	BT_DBG("val %06u", *val);
+	SMP_DBG("val %06u", *val);
 
 	return 0;
 }
@@ -357,13 +369,13 @@ static int smp_h6(struct crypto_hash *tfm_cmac, const u8 w[16],
 {
 	int err;
 
-	BT_DBG("w %16phN key_id %4phN", w, key_id);
+	SMP_DBG("w %16phN key_id %4phN", w, key_id);
 
 	err = aes_cmac(tfm_cmac, w, key_id, 4, res);
 	if (err)
 		return err;
 
-	BT_DBG("res %16phN", res);
+	SMP_DBG("res %16phN", res);
 
 	return err;
 }
@@ -1742,9 +1754,9 @@ static u8 sc_send_public_key(struct smp_chan *smp)
 		}
 	}
 
-	BT_DBG("Local Public Key X: %32phN", smp->local_pk);
-	BT_DBG("Local Public Key Y: %32phN", &smp->local_pk[32]);
-	BT_DBG("Local Private Key:  %32phN", smp->local_sk);
+	SMP_DBG("Local Public Key X: %32phN", smp->local_pk);
+	SMP_DBG("Local Public Key Y: %32phN", &smp->local_pk[32]);
+	SMP_DBG("Local Private Key:  %32phN", smp->local_sk);
 
 	smp_send_cmd(smp->conn, SMP_CMD_PUBLIC_KEY, 64, smp->local_pk);
 
@@ -2390,13 +2402,13 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 			return err;
 	}
 
-	BT_DBG("Remote Public Key X: %32phN", smp->remote_pk);
-	BT_DBG("Remote Public Key Y: %32phN", &smp->remote_pk[32]);
+	SMP_DBG("Remote Public Key X: %32phN", smp->remote_pk);
+	SMP_DBG("Remote Public Key Y: %32phN", &smp->remote_pk[32]);
 
 	if (!ecdh_shared_secret(smp->remote_pk, smp->local_sk, smp->dhkey))
 		return SMP_UNSPECIFIED;
 
-	BT_DBG("DHKey %32phN", smp->dhkey);
+	SMP_DBG("DHKey %32phN", smp->dhkey);
 
 	set_bit(SMP_FLAG_REMOTE_PK, &smp->flags);
 
-- 
2.1.0

