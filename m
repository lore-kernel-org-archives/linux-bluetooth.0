Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 2/8] Bluetooth: Rename smp_key_size to enc_key_size
Date: Mon, 30 Jan 2012 19:29:12 -0300
Message-Id: <1327962558-25720-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1327962558-25720-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1327962558-25720-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes clear that this is the size of the key used to
encrypt the link.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/smp.h |    2 +-
 net/bluetooth/smp.c         |   18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/smp.h b/include/net/bluetooth/smp.h
index aeaf5fa..7b3acdd 100644
--- a/include/net/bluetooth/smp.h
+++ b/include/net/bluetooth/smp.h
@@ -127,7 +127,7 @@ struct smp_chan {
 	u8              rrnd[16]; /* SMP Pairing Random (remote) */
 	u8		pcnf[16]; /* SMP Pairing Confirm */
 	u8		tk[16]; /* SMP Temporary Key */
-	u8		smp_key_size;
+	u8		enc_key_size;
 	unsigned long	smp_flags;
 	struct crypto_blkcipher	*tfm;
 	struct work_struct confirm;
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index e08fe6c..5818334 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -250,7 +250,7 @@ static u8 check_enc_key_size(struct l2cap_conn *conn, __u8 max_key_size)
 			(max_key_size < SMP_MIN_ENC_KEY_SIZE))
 		return SMP_ENC_KEY_SIZE;
 
-	smp->smp_key_size = max_key_size;
+	smp->enc_key_size = max_key_size;
 
 	return 0;
 }
@@ -446,8 +446,8 @@ static void random_work(struct work_struct *work)
 		smp_s1(tfm, smp->tk, smp->rrnd, smp->prnd, key);
 		swap128(key, stk);
 
-		memset(stk + smp->smp_key_size, 0,
-				SMP_MAX_ENC_KEY_SIZE - smp->smp_key_size);
+		memset(stk + smp->enc_key_size, 0,
+				SMP_MAX_ENC_KEY_SIZE - smp->enc_key_size);
 
 		if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, &hcon->flags)) {
 			reason = SMP_UNSPECIFIED;
@@ -455,7 +455,7 @@ static void random_work(struct work_struct *work)
 		}
 
 		hci_le_start_enc(hcon, ediv, rand, stk);
-		hcon->enc_key_size = smp->smp_key_size;
+		hcon->enc_key_size = smp->enc_key_size;
 	} else {
 		u8 stk[16], r[16], rand[8];
 		__le16 ediv;
@@ -469,10 +469,10 @@ static void random_work(struct work_struct *work)
 		smp_s1(tfm, smp->tk, smp->prnd, smp->rrnd, key);
 		swap128(key, stk);
 
-		memset(stk + smp->smp_key_size, 0,
-				SMP_MAX_ENC_KEY_SIZE - smp->smp_key_size);
+		memset(stk + smp->enc_key_size, 0,
+				SMP_MAX_ENC_KEY_SIZE - smp->enc_key_size);
 
-		hci_add_ltk(hcon->hdev, 0, conn->dst, smp->smp_key_size,
+		hci_add_ltk(hcon->hdev, 0, conn->dst, smp->enc_key_size,
 							ediv, rand, stk);
 	}
 
@@ -819,7 +819,7 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	skb_pull(skb, sizeof(*rp));
 
-	hci_add_ltk(conn->hcon->hdev, 1, conn->dst, smp->smp_key_size,
+	hci_add_ltk(conn->hcon->hdev, 1, conn->dst, smp->enc_key_size,
 						rp->ediv, rp->rand, smp->tk);
 
 	smp_distribute_keys(conn, 1);
@@ -940,7 +940,7 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 
 		smp_send_cmd(conn, SMP_CMD_ENCRYPT_INFO, sizeof(enc), &enc);
 
-		hci_add_ltk(conn->hcon->hdev, 1, conn->dst, smp->smp_key_size,
+		hci_add_ltk(conn->hcon->hdev, 1, conn->dst, smp->enc_key_size,
 						ediv, ident.rand, enc.ltk);
 
 		ident.ediv = cpu_to_le16(ediv);
-- 
1.7.8.1

