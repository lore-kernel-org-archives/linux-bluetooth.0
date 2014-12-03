Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 17/49] Bluetooth: Add support for sending LE SC Confirm value
Date: Wed,  3 Dec 2014 17:02:11 +0200
Message-Id: <1417618963-18010-18-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Once the public key exchange is complete the next step is for the
non-initiating device to send a SMP Pairing Confirm PDU to the
initiating device. This requires the use of a new smp_f4 confirm value
generation function which in turn builds on the AES-CMAC cryptographic
function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 1cc438c9c2cb..a1bfcb601c03 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -43,6 +43,9 @@
 				 0x1f : 0x07)
 #define KEY_DIST_MASK		0x07
 
+/* Maximum message length that can be passed to aes_cmac */
+#define CMAC_MSG_MAX	80
+
 enum {
 	SMP_FLAG_TK_VALID,
 	SMP_FLAG_CFM_PENDING,
@@ -94,6 +97,84 @@ static inline void swap_buf(const u8 *src, u8 *dst, size_t len)
 		dst[len - 1 - i] = src[i];
 }
 
+static int aes_cmac(struct crypto_hash *tfm, const u8 k[16], const u8 *m,
+		    size_t len, u8 mac[16])
+{
+	uint8_t tmp[16], mac_msb[16], msg_msb[CMAC_MSG_MAX];
+	struct hash_desc desc;
+	struct scatterlist sg;
+	int err;
+
+	if (len > CMAC_MSG_MAX)
+		return -EFBIG;
+
+	if (!tfm) {
+		BT_ERR("tfm %p", tfm);
+		return -EINVAL;
+	}
+
+	desc.tfm = tfm;
+	desc.flags = 0;
+
+	crypto_hash_init(&desc);
+
+	/* Swap key and message from LSB to MSB */
+	swap_buf(k, tmp, 16);
+	swap_buf(m, msg_msb, len);
+
+	BT_DBG("msg (len %zu) %*phN", len, len, m);
+	BT_DBG("key %16phN", k);
+
+	err = crypto_hash_setkey(tfm, tmp, 16);
+	if (err) {
+		BT_ERR("cipher setkey failed: %d", err);
+		return err;
+	}
+
+	sg_init_one(&sg, msg_msb, len);
+
+	err = crypto_hash_update(&desc, &sg, len);
+	if (err) {
+		BT_ERR("Hash update error %d", err);
+		return err;
+	}
+
+	err = crypto_hash_final(&desc, mac_msb);
+	if (err) {
+		BT_ERR("Hash final error %d", err);
+		return err;
+	}
+
+	swap_buf(mac_msb, mac, 16);
+
+	BT_DBG("mac %16phN", mac);
+
+	return 0;
+}
+
+static int smp_f4(struct crypto_hash *tfm_cmac, const u8 u[32], const u8 v[32],
+		  const u8 x[16], u8 z, u8 res[16])
+{
+	u8 m[65];
+	int err;
+
+	BT_DBG("u %32phN", u);
+	BT_DBG("v %32phN", v);
+	BT_DBG("x %16phN z %02x", x, z);
+
+	m[0] = z;
+	memcpy(m + 1, v, 32);
+	memcpy(m + 33, u, 32);
+
+	err = aes_cmac(tfm_cmac, x, m, sizeof(m), res);
+	if (err)
+		return err;
+
+	BT_DBG("res %16phN", res);
+
+	return err;
+}
+
 static int smp_e(struct crypto_blkcipher *tfm, const u8 *k, u8 *r)
 {
 	struct blkcipher_desc desc;
@@ -1522,6 +1603,7 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct hci_conn *hcon = conn->hcon;
 	struct l2cap_chan *chan = conn->smp;
 	struct smp_chan *smp = chan->data;
+	struct smp_cmd_pairing_confirm cfm;
 	int err;
 
 	BT_DBG("conn %p", conn);
@@ -1550,6 +1632,20 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	set_bit(SMP_FLAG_REMOTE_PK, &smp->flags);
 
+	/* The Initiating device waits for the non-initiating device to
+	 * send the confirm value.
+	 */
+	if (conn->hcon->out)
+		return 0;
+
+	err = smp_f4(smp->tfm_cmac, smp->local_pk, smp->remote_pk, smp->prnd,
+		     0, cfm.confirm_val);
+	if (err)
+		return SMP_UNSPECIFIED;
+
+	smp_send_cmd(conn, SMP_CMD_PAIRING_CONFIRM, sizeof(cfm), &cfm);
+	SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RANDOM);
+
 	return 0;
 }
 
-- 
2.1.0

