Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>,
	Anderson Lizardo <anderson.lizardo@openbossa.org>,
	Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [RFC 16/20] Bluetooth: LE SMP Cryptoolbox functions
Date: Tue, 23 Nov 2010 12:06:32 -0300
Message-Id: <1290524796-32246-17-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1290524796-32246-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1290524796-32246-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

This patch implements SMP crypto functions called ah, c1, s1 and e.
These functions are needed for SMP keys generation.

Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
Signed-off-by: Anderson Lizardo <anderson.lizardo@openbossa.org>
Signed-off-by: Bruna Moreira <bruna.moreira@openbossa.org>
---
 net/bluetooth/smp.c |  129 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 129 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index d3f9828..7997978 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -24,6 +24,135 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/smp.h>
+#include <linux/crypto.h>
+#include <crypto/b128ops.h>
+
+/* Criptographic toolbox functions */
+
+static int smp_e(const u8 *k, const u8 *r)
+{
+	struct crypto_blkcipher *tfm;
+	struct blkcipher_desc desc;
+	struct scatterlist sg[1];
+	int err, iv_len;
+	unsigned char iv[128];
+
+	tfm = crypto_alloc_blkcipher("ecb(aes)", 0, CRYPTO_ALG_ASYNC);
+	if (IS_ERR(tfm)) {
+		BT_ERR("Failed to load transform for ecb(aes): %ld",
+				PTR_ERR(tfm));
+		return PTR_ERR(tfm);
+	}
+
+	desc.tfm = tfm;
+	desc.flags = 0;
+
+	err = crypto_blkcipher_setkey(tfm, k, 16);
+	if (err) {
+		BT_ERR("smp_e: cipher setkey failed: %d", err);
+		goto out;
+	}
+
+	sg_init_table(sg, 1);
+	sg_set_buf(sg, r, 16);
+
+	iv_len = crypto_blkcipher_ivsize(tfm);
+	if (iv_len) {
+		memset(&iv, 0xff, iv_len);
+		crypto_blkcipher_set_iv(tfm, iv, iv_len);
+	}
+
+	err = crypto_blkcipher_encrypt(&desc, sg, sg, 16);
+	if (err)
+		BT_ERR("smp_e: Encrypt data error %d", err);
+
+out:
+	crypto_free_blkcipher(tfm);
+	return err;
+}
+
+static int smp_ah(const u8 *k, const u8 *r, u8 *res)
+{
+	u8 _r[16];
+	int err;
+
+	/* _r = padding || r */
+	memset(_r, 0, 16);
+	memcpy(_r + 13, r, 3);
+
+	err = smp_e(k, _r);
+	if (err) {
+		BT_ERR("smp_ah: Encrypt data error");
+		goto out;
+	}
+
+	/* Returns last 24 bits from previous intermediate result _r */
+	memcpy(res, _r + 13, 3);
+
+out:
+	return err;
+}
+
+static int smp_c1(const u8 *k, const u8 *r, const u8 *pres, const u8 *preq,
+		const u8 _iat, const u8 *ia, const u8 _rat, const u8 *ra,
+		u8 *res)
+{
+	u8 p1[16], p2[16];
+	int err;
+
+	/* p1 = pres || preq || _rat || _iat */
+	memset(p1, 0, 16);
+	memcpy(p1, pres, 7);
+	memcpy(p1 + 7, preq, 7);
+	*(p1 + 14) = _rat;
+	*(p1 + 15) = _iat;
+
+	/* p2 = padding || ia || ra */
+	memset(p2, 0, 16);
+	memcpy(p2 + 4, ia, 6);
+	memcpy(p2 + 10, ra, 6);
+
+	/* res = r XOR p1 */
+	u128_xor((u128 *)res, (u128 *)r, (u128 *)p1);
+
+	/* res = e(k, res) */
+	err = smp_e(k, res);
+	if (err) {
+		BT_ERR("smp_c1: Encrypt data error");
+		goto out;
+	}
+
+	/* res = res XOR p2 */
+	u128_xor((u128 *)res, (u128 *)res, (u128 *)p2);
+
+	/* res = e(k, res) */
+	err = smp_e(k, res);
+	if (err) {
+		BT_ERR("smp_c1: Encrypt data error");
+		goto out;
+	}
+
+out:
+	return err;
+}
+
+static int smp_s1(const u_char *k, const u_char *r1, const u_char *r2, u_char *_r)
+{
+	int err;
+
+	/* Just least significant octets from r1 and r2 are considered */
+	memcpy(_r, r1 + 8, 8);
+	memcpy(_r + 8, r2 + 8, 8);
+
+	err = smp_e(k, _r);
+	if (err) {
+		BT_ERR("smp_s1: Encrypt data error");
+		goto out;
+	}
+
+out:
+	return err;
+}
 
 static struct sk_buff *smp_build_cmd(struct l2cap_conn *conn, u8 code,
 		u16 dlen, void *data)
-- 
1.7.3.2

