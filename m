Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: Brian Gix <bgix@codeaurora.org>
Subject: [PATCH-v2 1/1] Bluetooth: Add LE Data signing smp_sign_pkt()
Date: Tue, 20 Dec 2011 17:14:41 -0800
Message-Id: <1324430081-3032-2-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1324430081-3032-1-git-send-email-bgix@codeaurora.org>
References: <1324430081-3032-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The LE packet signing algorythm is based on RFC-4493, and is
used by the GATT procedure Write Signed Command. This implementation
is self contained, takes as inputs a Packet to be signed, a Serial
number, and CSRK, all in Network order. It's output is a fully
signed datagram for Transmission or Verification.

Signed-off-by: Brian Gix <bgix@codeaurora.org>
---
 include/net/bluetooth/smp.h |    3 +-
 net/bluetooth/smp.c         |  103 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/smp.h b/include/net/bluetooth/smp.h
index 15b97d5..987a864 100644
--- a/include/net/bluetooth/smp.h
+++ b/include/net/bluetooth/smp.h
@@ -134,7 +134,8 @@ struct smp_chan {
 int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level);
 int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb);
 int smp_distribute_keys(struct l2cap_conn *conn, __u8 force);
-
+int smp_sign_pkt(u8 *src, int slen, u8 *dst, int *dlen, __le32 serial,
+								u8 *csrk);
 void smp_chan_destroy(struct l2cap_conn *conn);
 
 #endif /* __SMP_H */
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 0ee2905..7bcf67d 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -30,6 +30,17 @@
 
 #define SMP_TIMEOUT 30000 /* 30 seconds */
 
+static inline void lshift128(u8 target[16])
+{
+	int i;
+	for (i = 0; i < 15; i++) {
+		target[i] <<= 1;
+		if (target[i+1] & 0x80)
+			target[i] |= 0x01;
+	}
+	target[15] <<= 1;
+}
+
 static inline void swap128(u8 src[16], u8 dst[16])
 {
 	int i;
@@ -145,6 +156,98 @@ static int smp_rand(u8 *buf)
 	return 0;
 }
 
+int smp_sign_pkt(u8 *src, int slen, u8 *dst, int *dlen, __le32 serial, u8 *csrk)
+{
+	struct crypto_blkcipher *tfm;
+	u8 k[16], sub_k[16], tmp[16];
+	int test_msb, i, err, enc_size = slen + sizeof(u32);
+	u32 serial_num = le32_to_cpu(serial);
+
+	if (!src || !dst || !csrk || !dlen || !slen || *dlen < enc_size + 8)
+		return -EINVAL;
+
+	tfm = crypto_alloc_blkcipher("ecb(aes)", 0, CRYPTO_ALG_ASYNC);
+	if (IS_ERR(tfm))
+		return -ENOTSUPP;
+
+	/* Put key into required order (Big Endian) */
+	swap128(csrk, k);
+
+	/* Calculate SubKey per RFC-4493 section 2.3 Step 1 */
+	memset(sub_k, 0, sizeof(sub_k));
+	err = smp_e(tfm, k, sub_k);
+	if (err) {
+		BT_ERR("SubKey generation failed: %d", err);
+		goto error;
+	}
+
+	/* Calculate K1 per RFC-4493 section 2.3 Step 2 */
+	test_msb = sub_k[0] & 0x80;
+	lshift128(sub_k);
+	if (test_msb)
+		sub_k[15] ^= 0x87;
+
+	/* Calculate K2 per RFC-4493 section 2.3 Step 3 (if needed) */
+	if (enc_size % 16) {
+		test_msb = sub_k[0] & 0x80;
+		lshift128(sub_k);
+		if (test_msb)
+			sub_k[15] ^= 0x87;
+	}
+
+	/* Stage data for encryption in dst buffer (Big Endian) */
+	put_unaligned_be32(serial_num, dst);
+	for (i = 0; i < slen; i++)
+		dst[i + sizeof(u32)] = src[slen - i - 1];
+
+
+	/* Apply blocks 1 to N-1 and Encrypt per RFC-4493 section 2.4 */
+	memset(tmp, 0, 16);
+	for (i = 0; i < enc_size - 16; i += 16) {
+		u128_xor((u128 *) tmp, (u128 *) tmp, (u128 *) &dst[i]);
+		err = smp_e(tfm, k, tmp);
+		if (err) {
+			BT_ERR("mid block(%d) encryption failed: %d", i, err);
+			goto error;
+		}
+	}
+
+	/* Apply SubKey for last block */
+	u128_xor((u128 *) tmp, (u128 *) tmp, (u128 *) sub_k);
+
+	/* Apply last block, and pad as needed */
+	if (enc_size % 16) {
+		/* reuse sub_k to pad target data to 16 bytes */
+		memset(sub_k, 0, 16);
+		memcpy(sub_k, &dst[i], enc_size - i);
+		sub_k[enc_size - i] = 0x80;
+
+		u128_xor((u128 *) tmp, (u128 *) tmp, (u128 *) sub_k);
+	} else {
+		u128_xor((u128 *) tmp, (u128 *) tmp, (u128 *) &dst[i]);
+	}
+
+	/* Encrypt last block */
+	err = smp_e(tfm, k, tmp);
+	if (err) {
+		BT_ERR("last block encryption failed: %d", err);
+		goto error;
+	}
+
+	/* Signature calculation complete */
+	swap128(tmp, k);
+
+	/* Construct final dst buffer (Little Endian) */
+	memcpy(dst, src, slen);
+	put_unaligned_le32(serial_num, &dst[slen]);
+	memcpy(&dst[slen + sizeof(u32)], &k[8], 8);
+	*dlen = slen + sizeof(u32) + 8;
+
+error:
+	crypto_free_blkcipher(tfm);
+	return err;
+}
+
 static struct sk_buff *smp_build_cmd(struct l2cap_conn *conn, u8 code,
 						u16 dlen, void *data)
 {
-- 
1.7.8

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum 
