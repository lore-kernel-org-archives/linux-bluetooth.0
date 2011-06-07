Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>,
	Anderson Lizardo <anderson.lizardo@openbossa.org>,
	Bruna Moreira <bruna.moreira@openbossa.org>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [bluetooth-next v3 05/16] Bluetooth: Add LE SMP Cryptoolbox functions
Date: Tue,  7 Jun 2011 18:46:34 -0300
Message-Id: <1307483205-1518-6-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1307483205-1518-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1307483205-1518-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

This patch implements SMP crypto functions called ah, c1, s1 and e.
It also implements auxiliary functions. All These functions are needed
for SMP keys generation.

Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
Signed-off-by: Anderson Lizardo <anderson.lizardo@openbossa.org>
Signed-off-by: Bruna Moreira <bruna.moreira@openbossa.org>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/smp.c |  117 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 117 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index aa20bee..57fc7d0 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -24,6 +24,123 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/smp.h>
+#include <linux/crypto.h>
+#include <crypto/b128ops.h>
+
+static inline void swap128(u8 src[16], u8 dst[16])
+{
+	int i;
+	for (i = 0; i < 16; i++)
+		dst[15 - i] = src[i];
+}
+
+static inline void swap56(u8 src[7], u8 dst[7])
+{
+	int i;
+	for (i = 0; i < 7; i++)
+		dst[6 - i] = src[i];
+}
+
+static int smp_e(struct crypto_blkcipher *tfm, const u8 *k, u8 *r)
+{
+	struct blkcipher_desc desc;
+	struct scatterlist sg;
+	int err, iv_len;
+	unsigned char iv[128];
+
+	if (tfm == NULL) {
+		BT_ERR("tfm %p", tfm);
+		return -EINVAL;
+	}
+
+	desc.tfm = tfm;
+	desc.flags = 0;
+
+	err = crypto_blkcipher_setkey(tfm, k, 16);
+	if (err) {
+		BT_ERR("cipher setkey failed: %d", err);
+		return err;
+	}
+
+	sg_init_one(&sg, r, 16);
+
+	iv_len = crypto_blkcipher_ivsize(tfm);
+	if (iv_len) {
+		memset(&iv, 0xff, iv_len);
+		crypto_blkcipher_set_iv(tfm, iv, iv_len);
+	}
+
+	err = crypto_blkcipher_encrypt(&desc, &sg, &sg, 16);
+	if (err)
+		BT_ERR("Encrypt data error %d", err);
+
+	return err;
+}
+
+static int smp_c1(struct crypto_blkcipher *tfm, u8 k[16], u8 r[16],
+		u8 preq[7], u8 pres[7], u8 _iat, bdaddr_t *ia,
+		u8 _rat, bdaddr_t *ra, u8 res[16])
+{
+	u8 p1[16], p2[16];
+	int err;
+
+	memset(p1, 0, 16);
+
+	/* p1 = pres || preq || _rat || _iat */
+	swap56(pres, p1);
+	swap56(preq, p1 + 7);
+	p1[14] = _rat;
+	p1[15] = _iat;
+
+	memset(p2, 0, 16);
+
+	/* p2 = padding || ia || ra */
+	baswap((bdaddr_t *) (p2 + 4), ia);
+	baswap((bdaddr_t *) (p2 + 10), ra);
+
+	/* res = r XOR p1 */
+	u128_xor((u128 *) res, (u128 *) r, (u128 *) p1);
+
+	/* res = e(k, res) */
+	err = smp_e(tfm, k, res);
+	if (err) {
+		BT_ERR("Encrypt data error");
+		return err;
+	}
+
+	/* res = res XOR p2 */
+	u128_xor((u128 *) res, (u128 *) res, (u128 *) p2);
+
+	/* res = e(k, res) */
+	err = smp_e(tfm, k, res);
+	if (err)
+		BT_ERR("Encrypt data error");
+
+	return err;
+}
+
+static int smp_s1(struct crypto_blkcipher *tfm, u8 k[16],
+			u8 r1[16], u8 r2[16], u8 _r[16])
+{
+	int err;
+
+	/* Just least significant octets from r1 and r2 are considered */
+	memcpy(_r, r1 + 8, 8);
+	memcpy(_r + 8, r2 + 8, 8);
+
+	err = smp_e(tfm, k, _r);
+	if (err)
+		BT_ERR("Encrypt data error");
+
+	return err;
+}
+
+static int smp_rand(u8 *buf)
+{
+	get_random_bytes(buf, 16);
+
+	return 0;
+}
 
 static struct sk_buff *smp_build_cmd(struct l2cap_conn *conn, u8 code,
 						u16 dlen, void *data)
-- 
1.7.5.4

