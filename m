Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 07/13] Bluetooth: Rename smp_key_size to enc_size
Date: Thu, 25 Aug 2011 20:02:33 -0300
Message-Id: <1314313359-12652-8-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1314313359-12652-1-git-send-email-vcgomes@gmail.com>
References: <1314313359-12652-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

This makes it more clear that the encryption size (effective
size of the key used for encrypting the link) is a different
concept than the pin code lenght.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/smp.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index fd5e1ca..eb9e3e7 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -41,7 +41,7 @@ struct smp_chan {
 	u8		rrnd[16]; /* SMP Pairing Random (remote) */
 	u8		pcnf[16]; /* SMP Pairing Confirm */
 	u8		tk[16]; /* SMP Temporary Key */
-	u8		smp_key_size;
+	u8		enc_size;
 	struct crypto_blkcipher	*tfm;
 	struct work_struct confirm;
 	struct work_struct random;
@@ -243,7 +243,7 @@ static u8 check_enc_key_size(struct l2cap_conn *conn, __u8 max_key_size)
 			(max_key_size < SMP_MIN_ENC_KEY_SIZE))
 		return SMP_ENC_KEY_SIZE;
 
-	smp->smp_key_size = max_key_size;
+	smp->enc_size = max_key_size;
 
 	return 0;
 }
@@ -337,8 +337,8 @@ static void random_work(struct work_struct *work)
 		smp_s1(tfm, smp->tk, smp->rrnd, smp->prnd, key);
 		swap128(key, stk);
 
-		memset(stk + smp->smp_key_size, 0,
-				SMP_MAX_ENC_KEY_SIZE - smp->smp_key_size);
+		memset(stk + smp->enc_size, 0,
+				SMP_MAX_ENC_KEY_SIZE - smp->enc_size);
 
 		if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, &hcon->pend)) {
 			reason = SMP_UNSPECIFIED;
@@ -346,7 +346,7 @@ static void random_work(struct work_struct *work)
 		}
 
 		hci_le_start_enc(hcon, ediv, rand, stk);
-		hcon->enc_key_size = smp->smp_key_size;
+		hcon->enc_key_size = smp->enc_size;
 	} else {
 		u8 stk[16], r[16], rand[8];
 		__le16 ediv;
@@ -360,10 +360,10 @@ static void random_work(struct work_struct *work)
 		smp_s1(tfm, smp->tk, smp->prnd, smp->rrnd, key);
 		swap128(key, stk);
 
-		memset(stk + smp->smp_key_size, 0,
-				SMP_MAX_ENC_KEY_SIZE - smp->smp_key_size);
+		memset(stk + smp->enc_size, 0,
+				SMP_MAX_ENC_KEY_SIZE - smp->enc_size);
 
-		hci_add_ltk(hcon->hdev, 0, conn->dst, smp->smp_key_size,
+		hci_add_ltk(hcon->hdev, 0, conn->dst, smp->enc_size,
 							ediv, rand, stk);
 	}
 
@@ -630,7 +630,7 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	skb_pull(skb, sizeof(*rp));
 
-	hci_add_ltk(conn->hcon->hdev, 1, conn->src, smp->smp_key_size,
+	hci_add_ltk(conn->hcon->hdev, 1, conn->src, smp->enc_size,
 						rp->ediv, rp->rand, smp->tk);
 
 	smp_distribute_keys(conn, 1);
@@ -754,7 +754,7 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 
 		smp_send_cmd(conn, SMP_CMD_ENCRYPT_INFO, sizeof(enc), &enc);
 
-		hci_add_ltk(conn->hcon->hdev, 1, conn->dst, smp->smp_key_size,
+		hci_add_ltk(conn->hcon->hdev, 1, conn->dst, smp->enc_size,
 						ediv, ident.rand, enc.ltk);
 
 		ident.ediv = cpu_to_le16(ediv);
-- 
1.7.6

