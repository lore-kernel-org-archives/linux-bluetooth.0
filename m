Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 19/49] Bluetooth: Add support for LE SC numeric comparison
Date: Wed,  3 Dec 2014 17:02:13 +0200
Message-Id: <1417618963-18010-20-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

After the Pairing Confirm and Random PDUs have been exchanged in LE SC
it's time to generate a numeric comparison value using a new smp_g2
cryptographic function (which also builds on AES-CMAC). This patch adds
the smp_g2 implementation and updates the Pairing Random PDU handler to
proceed with the value genration and user confirmation.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 36f3c75ac858..00bafcae8814 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -175,6 +175,32 @@ static int smp_f4(struct crypto_hash *tfm_cmac, const u8 u[32], const u8 v[32],
 	return err;
 }
 
+static int smp_g2(struct crypto_hash *tfm_cmac, const u8 u[32], const u8 v[32],
+		  const u8 x[16], const u8 y[16], u32 *val)
+{
+	u8 m[80], tmp[16];
+	int err;
+
+	BT_DBG("u %32phN", u);
+	BT_DBG("v %32phN", v);
+	BT_DBG("x %16phN y %16phN", x, y);
+
+	memcpy(m, y, 16);
+	memcpy(m + 16, v, 32);
+	memcpy(m + 48, u, 32);
+
+	err = aes_cmac(tfm_cmac, x, m, sizeof(m), tmp);
+	if (err)
+		return err;
+
+	*val = get_unaligned_le32(tmp);
+	*val %= 1000000;
+
+	BT_DBG("val %06u", *val);
+
+	return 0;
+}
+
 static int smp_e(struct crypto_blkcipher *tfm, const u8 *k, u8 *r)
 {
 	struct blkcipher_desc desc;
@@ -1270,6 +1296,10 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct l2cap_chan *chan = conn->smp;
 	struct smp_chan *smp = chan->data;
+	struct hci_conn *hcon = conn->hcon;
+	u8 *pkax, *pkbx, *na, *nb;
+	u32 passkey;
+	int err;
 
 	BT_DBG("conn %p", conn);
 
@@ -1279,7 +1309,46 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	memcpy(smp->rrnd, skb->data, sizeof(smp->rrnd));
 	skb_pull(skb, sizeof(smp->rrnd));
 
-	return smp_random(smp);
+	if (!test_bit(SMP_FLAG_SC, &smp->flags))
+		return smp_random(smp);
+
+	if (hcon->out) {
+		u8 cfm[16];
+
+		err = smp_f4(smp->tfm_cmac, smp->remote_pk, smp->local_pk,
+			     smp->rrnd, 0, cfm);
+		if (err)
+			return SMP_UNSPECIFIED;
+
+		if (memcmp(smp->pcnf, cfm, 16))
+			return SMP_CONFIRM_FAILED;
+
+		pkax = smp->local_pk;
+		pkbx = smp->remote_pk;
+		na   = smp->prnd;
+		nb   = smp->rrnd;
+	} else {
+		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(smp->prnd),
+			     smp->prnd);
+		SMP_ALLOW_CMD(smp, SMP_CMD_DHKEY_CHECK);
+
+		pkax = smp->remote_pk;
+		pkbx = smp->local_pk;
+		na   = smp->rrnd;
+		nb   = smp->prnd;
+	}
+
+	err = smp_g2(smp->tfm_cmac, pkax, pkbx, na, nb, &passkey);
+	if (err)
+		return SMP_UNSPECIFIED;
+
+	err = mgmt_user_confirm_request(hcon->hdev, &hcon->dst,
+					hcon->type, hcon->dst_type,
+					passkey, 0);
+	if (err)
+		return SMP_UNSPECIFIED;
+
+	return 0;
 }
 
 static bool smp_ltk_encrypt(struct l2cap_conn *conn, u8 sec_level)
-- 
2.1.0

