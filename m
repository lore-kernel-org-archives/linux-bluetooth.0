Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 16/49] Bluetooth: Add handler function for receiving LE SC public key
Date: Wed,  3 Dec 2014 17:02:10 +0200
Message-Id: <1417618963-18010-17-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds a handler function for the LE SC SMP Public Key PDU.
When we receive the key we proceed with generating the shared DHKey
value from the remote public key and local private key.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 9317583751eb..1cc438c9c2cb 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -50,6 +50,7 @@ enum {
 	SMP_FLAG_COMPLETE,
 	SMP_FLAG_INITIATOR,
 	SMP_FLAG_SC,
+	SMP_FLAG_REMOTE_PK,
 };
 
 struct smp_chan {
@@ -78,6 +79,8 @@ struct smp_chan {
 	/* Secure Connections variables */
 	u8			local_pk[64];
 	u8			local_sk[32];
+	u8			remote_pk[64];
+	u8			dhkey[32];
 
 	struct crypto_blkcipher	*tfm_aes;
 	struct crypto_hash	*tfm_cmac;
@@ -1513,6 +1516,43 @@ static int smp_cmd_sign_info(struct l2cap_conn *conn, struct sk_buff *skb)
 	return 0;
 }
 
+static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
+{
+	struct smp_cmd_public_key *key = (void *) skb->data;
+	struct hci_conn *hcon = conn->hcon;
+	struct l2cap_chan *chan = conn->smp;
+	struct smp_chan *smp = chan->data;
+	int err;
+
+	BT_DBG("conn %p", conn);
+
+	if (skb->len < sizeof(*key))
+		return SMP_INVALID_PARAMS;
+
+	memcpy(smp->remote_pk, key, 64);
+
+	/* Non-initiating device sends its public key after receiving
+	 * the key from the initiating device.
+	 */
+	if (!hcon->out) {
+		err = sc_send_public_key(smp);
+		if (err)
+			return err;
+	}
+
+	BT_DBG("Remote Public Key X: %32phN", smp->remote_pk);
+	BT_DBG("Remote Public Key Y: %32phN", &smp->remote_pk[32]);
+
+	if (!ecdh_shared_secret(smp->remote_pk, smp->local_sk, smp->dhkey))
+		return SMP_UNSPECIFIED;
+
+	BT_DBG("DHKey %32phN", smp->dhkey);
+
+	set_bit(SMP_FLAG_REMOTE_PK, &smp->flags);
+
+	return 0;
+}
+
 static int smp_sig_channel(struct l2cap_chan *chan, struct sk_buff *skb)
 {
 	struct l2cap_conn *conn = chan->conn;
@@ -1597,6 +1637,10 @@ static int smp_sig_channel(struct l2cap_chan *chan, struct sk_buff *skb)
 		reason = smp_cmd_sign_info(conn, skb);
 		break;
 
+	case SMP_CMD_PUBLIC_KEY:
+		reason = smp_cmd_public_key(conn, skb);
+		break;
+
 	default:
 		BT_DBG("Unknown command code 0x%2.2x", code);
 		reason = SMP_CMD_NOTSUPP;
-- 
2.1.0

