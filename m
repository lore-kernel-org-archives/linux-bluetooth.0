Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 3/8] Bluetooth: Rename smp_key_size to enc_size
Date: Thu, 10 Nov 2011 22:03:51 -0300
Message-Id: <1320973436-13399-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1320973436-13399-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1320973436-13399-1-git-send-email-vinicius.gomes@openbossa.org>
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
index 15b97d5..cf3aab0 100644
--- a/include/net/bluetooth/smp.h
+++ b/include/net/bluetooth/smp.h
@@ -123,7 +123,7 @@ struct smp_chan {
 	u8              rrnd[16]; /* SMP Pairing Random (remote) */
 	u8		pcnf[16]; /* SMP Pairing Confirm */
 	u8		tk[16]; /* SMP Temporary Key */
-	u8		smp_key_size;
+	u8		enc_size;
 	struct crypto_blkcipher	*tfm;
 	struct work_struct confirm;
 	struct work_struct random;
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 94e94ca..e30bf6a 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -227,7 +227,7 @@ static u8 check_enc_key_size(struct l2cap_conn *conn, __u8 max_key_size)
 			(max_key_size < SMP_MIN_ENC_KEY_SIZE))
 		return SMP_ENC_KEY_SIZE;
 
-	smp->smp_key_size = max_key_size;
+	smp->enc_size = max_key_size;
 
 	return 0;
 }
@@ -321,8 +321,8 @@ static void random_work(struct work_struct *work)
 		smp_s1(tfm, smp->tk, smp->rrnd, smp->prnd, key);
 		swap128(key, stk);
 
-		memset(stk + smp->smp_key_size, 0,
-				SMP_MAX_ENC_KEY_SIZE - smp->smp_key_size);
+		memset(stk + smp->enc_size, 0,
+				SMP_MAX_ENC_KEY_SIZE - smp->enc_size);
 
 		if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, &hcon->pend)) {
 			reason = SMP_UNSPECIFIED;
@@ -330,7 +330,7 @@ static void random_work(struct work_struct *work)
 		}
 
 		hci_le_start_enc(hcon, ediv, rand, stk);
-		hcon->enc_key_size = smp->smp_key_size;
+		hcon->enc_key_size = smp->enc_size;
 	} else {
 		u8 stk[16], r[16], rand[8];
 		__le16 ediv;
@@ -344,10 +344,10 @@ static void random_work(struct work_struct *work)
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
 
@@ -619,7 +619,7 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	skb_pull(skb, sizeof(*rp));
 
-	hci_add_ltk(conn->hcon->hdev, 1, conn->src, smp->smp_key_size,
+	hci_add_ltk(conn->hcon->hdev, 1, conn->src, smp->enc_size,
 						rp->ediv, rp->rand, smp->tk);
 
 	smp_distribute_keys(conn, 1);
@@ -740,7 +740,7 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 
 		smp_send_cmd(conn, SMP_CMD_ENCRYPT_INFO, sizeof(enc), &enc);
 
-		hci_add_ltk(conn->hcon->hdev, 1, conn->dst, smp->smp_key_size,
+		hci_add_ltk(conn->hcon->hdev, 1, conn->dst, smp->enc_size,
 						ediv, ident.rand, enc.ltk);
 
 		ident.ediv = cpu_to_le16(ediv);
-- 
1.7.7

