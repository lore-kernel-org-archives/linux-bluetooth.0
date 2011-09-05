Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 2/2] Bluetooth: Move SMP crypto functions to a workqueue
Date: Mon,  5 Sep 2011 14:31:31 -0300
Message-Id: <1315243891-21875-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1315243891-21875-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1315243891-21875-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The function crypto_blkcipher_setkey() called by smp_e()
can sleep, so all the crypto work has to be moved to
hci_dev workqueue.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/smp.h |    9 ++-
 net/bluetooth/l2cap_core.c  |    2 +-
 net/bluetooth/smp.c         |  277 +++++++++++++++++++++++++++----------------
 3 files changed, 185 insertions(+), 103 deletions(-)

diff --git a/include/net/bluetooth/smp.h b/include/net/bluetooth/smp.h
index a9ba72c..15b97d5 100644
--- a/include/net/bluetooth/smp.h
+++ b/include/net/bluetooth/smp.h
@@ -116,13 +116,18 @@ struct smp_cmd_security_req {
 #define SMP_MAX_ENC_KEY_SIZE		16
 
 struct smp_chan {
+	struct l2cap_conn *conn;
 	u8		preq[7]; /* SMP Pairing Request */
 	u8		prsp[7]; /* SMP Pairing Response */
-	u8		prnd[16]; /* SMP Pairing Random */
+	u8              prnd[16]; /* SMP Pairing Random (local) */
+	u8              rrnd[16]; /* SMP Pairing Random (remote) */
 	u8		pcnf[16]; /* SMP Pairing Confirm */
 	u8		tk[16]; /* SMP Temporary Key */
 	u8		smp_key_size;
 	struct crypto_blkcipher	*tfm;
+	struct work_struct confirm;
+	struct work_struct random;
+
 };
 
 /* SMP Commands */
@@ -130,4 +135,6 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level);
 int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb);
 int smp_distribute_keys(struct l2cap_conn *conn, __u8 force);
 
+void smp_chan_destroy(struct l2cap_conn *conn);
+
 #endif /* __SMP_H */
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 09ca51e..566c880 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -996,7 +996,7 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 
 	if (test_and_clear_bit(HCI_CONN_LE_SMP_PEND, &hcon->pend)) {
 		del_timer(&conn->security_timer);
-		hci_conn_put(hcon);
+		smp_chan_destroy(conn);
 	}
 
 	hcon->l2cap_data = NULL;
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index b5e1b4a..03489e5 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -243,16 +243,170 @@ static u8 check_enc_key_size(struct l2cap_conn *conn, __u8 max_key_size)
 	return 0;
 }
 
+static void confirm_work(struct work_struct *work)
+{
+	struct smp_chan *smp = container_of(work, struct smp_chan, confirm);
+	struct l2cap_conn *conn = smp->conn;
+	struct crypto_blkcipher *tfm;
+	struct smp_cmd_pairing_confirm cp;
+	int ret;
+	u8 res[16], reason;
+
+	BT_DBG("conn %p", conn);
+
+	tfm = crypto_alloc_blkcipher("ecb(aes)", 0, CRYPTO_ALG_ASYNC);
+	if (IS_ERR(tfm)) {
+		reason = SMP_UNSPECIFIED;
+		goto error;
+	}
+
+	smp->tfm = tfm;
+
+	if (conn->hcon->out)
+		ret = smp_c1(tfm, smp->tk, smp->prnd, smp->preq, smp->prsp, 0,
+				conn->src, conn->hcon->dst_type, conn->dst,
+				res);
+	else
+		ret = smp_c1(tfm, smp->tk, smp->prnd, smp->preq, smp->prsp,
+				conn->hcon->dst_type, conn->dst, 0, conn->src,
+				res);
+	if (ret) {
+		reason = SMP_UNSPECIFIED;
+		goto error;
+	}
+
+	swap128(res, cp.confirm_val);
+	smp_send_cmd(smp->conn, SMP_CMD_PAIRING_CONFIRM, sizeof(cp), &cp);
+
+	return;
+
+error:
+	smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(reason), &reason);
+	smp_chan_destroy(conn);
+}
+
+static void random_work(struct work_struct *work)
+{
+	struct smp_chan *smp = container_of(work, struct smp_chan, random);
+	struct l2cap_conn *conn = smp->conn;
+	struct hci_conn *hcon = conn->hcon;
+	struct crypto_blkcipher *tfm = smp->tfm;
+	u8 reason, confirm[16], res[16], key[16];
+	int ret;
+
+	if (IS_ERR_OR_NULL(tfm)) {
+		reason = SMP_UNSPECIFIED;
+		goto error;
+	}
+
+	BT_DBG("conn %p %s", conn, conn->hcon->out ? "master" : "slave");
+
+	if (hcon->out)
+		ret = smp_c1(tfm, smp->tk, smp->rrnd, smp->preq, smp->prsp, 0,
+				conn->src, hcon->dst_type, conn->dst,
+				res);
+	else
+		ret = smp_c1(tfm, smp->tk, smp->rrnd, smp->preq, smp->prsp,
+				hcon->dst_type, conn->dst, 0, conn->src,
+				res);
+	if (ret) {
+		reason = SMP_UNSPECIFIED;
+		goto error;
+	}
+
+	swap128(res, confirm);
+
+	if (memcmp(smp->pcnf, confirm, sizeof(smp->pcnf)) != 0) {
+		BT_ERR("Pairing failed (confirmation values mismatch)");
+		reason = SMP_CONFIRM_FAILED;
+		goto error;
+	}
+
+	if (hcon->out) {
+		u8 stk[16], rand[8];
+		__le16 ediv;
+
+		memset(rand, 0, sizeof(rand));
+		ediv = 0;
+
+		smp_s1(tfm, smp->tk, smp->rrnd, smp->prnd, key);
+		swap128(key, stk);
+
+		memset(stk + smp->smp_key_size, 0,
+				SMP_MAX_ENC_KEY_SIZE - smp->smp_key_size);
+
+		if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, &hcon->pend)) {
+			reason = SMP_UNSPECIFIED;
+			goto error;
+		}
+
+		hci_le_start_enc(hcon, ediv, rand, stk);
+		hcon->enc_key_size = smp->smp_key_size;
+	} else {
+		u8 stk[16], r[16], rand[8];
+		__le16 ediv;
+
+		memset(rand, 0, sizeof(rand));
+		ediv = 0;
+
+		swap128(smp->prnd, r);
+		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(r), r);
+
+		smp_s1(tfm, smp->tk, smp->prnd, smp->rrnd, key);
+		swap128(key, stk);
+
+		memset(stk + smp->smp_key_size, 0,
+				SMP_MAX_ENC_KEY_SIZE - smp->smp_key_size);
+
+		hci_add_ltk(hcon->hdev, 0, conn->dst, smp->smp_key_size,
+							ediv, rand, stk);
+	}
+
+	return;
+
+error:
+	smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(reason), &reason);
+	smp_chan_destroy(conn);
+}
+
+static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
+{
+	struct smp_chan *smp;
+
+	smp = kzalloc(sizeof(struct smp_chan), GFP_ATOMIC);
+	if (!smp)
+		return NULL;
+
+	INIT_WORK(&smp->confirm, confirm_work);
+	INIT_WORK(&smp->random, random_work);
+
+	smp->conn = conn;
+	conn->smp_chan = smp;
+
+	hci_conn_hold(conn->hcon);
+
+	return smp;
+}
+
+void smp_chan_destroy(struct l2cap_conn *conn)
+{
+	kfree(conn->smp_chan);
+	hci_conn_put(conn->hcon);
+}
+
 static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_cmd_pairing rsp, *req = (void *) skb->data;
-	struct smp_chan *smp = conn->smp_chan;
+	struct smp_chan *smp;
 	u8 key_size;
+	int ret;
 
 	BT_DBG("conn %p", conn);
 
 	if (!test_and_set_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->pend))
-		hci_conn_hold(conn->hcon);
+		smp = smp_chan_create(conn);
+
+	smp = conn->smp_chan;
 
 	smp->preq[0] = SMP_CMD_PAIRING_REQ;
 	memcpy(&smp->preq[1], req, sizeof(*req));
@@ -271,6 +425,10 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	/* Just works */
 	memset(smp->tk, 0, sizeof(smp->tk));
 
+	ret = smp_rand(smp->prnd);
+	if (ret)
+		return SMP_UNSPECIFIED;
+
 	smp->prsp[0] = SMP_CMD_PAIRING_RSP;
 	memcpy(&smp->prsp[1], &rsp, sizeof(rsp));
 
@@ -282,12 +440,10 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_cmd_pairing *req, *rsp = (void *) skb->data;
-	struct smp_cmd_pairing_confirm cp;
 	struct smp_chan *smp = conn->smp_chan;
-	struct crypto_blkcipher *tfm = smp->tfm;
-
+	struct hci_dev *hdev = conn->hcon->hdev;
+	u8 key_size;
 	int ret;
-	u8 res[16], key_size;
 
 	BT_DBG("conn %p", conn);
 
@@ -305,21 +461,14 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 	/* Just works */
 	memset(smp->tk, 0, sizeof(smp->tk));
 
-	smp->prsp[0] = SMP_CMD_PAIRING_RSP;
-	memcpy(&smp->prsp[1], rsp, sizeof(*rsp));
-
 	ret = smp_rand(smp->prnd);
 	if (ret)
 		return SMP_UNSPECIFIED;
 
-	ret = smp_c1(tfm, smp->tk, smp->prnd, smp->preq, smp->prsp, 0,
-			conn->src, conn->hcon->dst_type, conn->dst, res);
-	if (ret)
-		return SMP_UNSPECIFIED;
-
-	swap128(res, cp.confirm_val);
+	smp->prsp[0] = SMP_CMD_PAIRING_RSP;
+	memcpy(&smp->prsp[1], rsp, sizeof(*rsp));
 
-	smp_send_cmd(conn, SMP_CMD_PAIRING_CONFIRM, sizeof(cp), &cp);
+	queue_work(hdev->workqueue, &smp->confirm);
 
 	return 0;
 }
@@ -327,7 +476,7 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_chan *smp = conn->smp_chan;
-	struct crypto_blkcipher *tfm = smp->tfm;
+	struct hci_dev *hdev = conn->hcon->hdev;
 
 	BT_DBG("conn %p %s", conn, conn->hcon->out ? "master" : "slave");
 
@@ -341,23 +490,7 @@ static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(random),
 								random);
 	} else {
-		struct smp_cmd_pairing_confirm cp;
-		int ret;
-		u8 res[16];
-
-		ret = smp_rand(smp->prnd);
-		if (ret)
-			return SMP_UNSPECIFIED;
-
-		ret = smp_c1(tfm, smp->tk, smp->prnd, smp->preq, smp->prsp,
-						conn->hcon->dst_type, conn->dst,
-						0, conn->src, res);
-		if (ret)
-			return SMP_CONFIRM_FAILED;
-
-		swap128(res, cp.confirm_val);
-
-		smp_send_cmd(conn, SMP_CMD_PAIRING_CONFIRM, sizeof(cp), &cp);
+		queue_work(hdev->workqueue, &smp->confirm);
 	}
 
 	return 0;
@@ -365,72 +498,15 @@ static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 
 static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 {
-	struct hci_conn *hcon = conn->hcon;
 	struct smp_chan *smp = conn->smp_chan;
-	struct crypto_blkcipher *tfm = smp->tfm;
-	int ret;
-	u8 key[16], res[16], random[16], confirm[16];
-
-	swap128(skb->data, random);
-	skb_pull(skb, sizeof(random));
+	struct hci_dev *hdev = conn->hcon->hdev;
 
-	if (conn->hcon->out)
-		ret = smp_c1(tfm, smp->tk, random, smp->preq, smp->prsp, 0,
-				conn->src, conn->hcon->dst_type, conn->dst,
-				res);
-	else
-		ret = smp_c1(tfm, smp->tk, random, smp->preq, smp->prsp,
-				conn->hcon->dst_type, conn->dst, 0, conn->src,
-				res);
-	if (ret)
-		return SMP_UNSPECIFIED;
-
-	BT_DBG("conn %p %s", conn, conn->hcon->out ? "master" : "slave");
-
-	swap128(res, confirm);
-
-	if (memcmp(smp->pcnf, confirm, sizeof(smp->pcnf)) != 0) {
-		BT_ERR("Pairing failed (confirmation values mismatch)");
-		return SMP_CONFIRM_FAILED;
-	}
-
-	if (conn->hcon->out) {
-		u8 stk[16], rand[8];
-		__le16 ediv;
-
-		memset(rand, 0, sizeof(rand));
-		ediv = 0;
-
-		smp_s1(tfm, smp->tk, random, smp->prnd, key);
-		swap128(key, stk);
-
-		memset(stk + smp->smp_key_size, 0,
-				SMP_MAX_ENC_KEY_SIZE - smp->smp_key_size);
-
-		if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, &hcon->pend))
-			return SMP_UNSPECIFIED;
-
-		hci_le_start_enc(hcon, ediv, rand, stk);
-		hcon->enc_key_size = smp->smp_key_size;
-	} else {
-		u8 stk[16], r[16], rand[8];
-		__le16 ediv;
-
-		memset(rand, 0, sizeof(rand));
-		ediv = 0;
-
-		swap128(smp->prnd, r);
-		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(r), r);
-
-		smp_s1(tfm, smp->tk, smp->prnd, random, key);
-		swap128(key, stk);
+	BT_DBG("conn %p", conn);
 
-		memset(stk + smp->smp_key_size, 0,
-				SMP_MAX_ENC_KEY_SIZE - smp->smp_key_size);
+	swap128(skb->data, smp->rrnd);
+	skb_pull(skb, sizeof(smp->rrnd));
 
-		hci_add_ltk(conn->hcon->hdev, 0, conn->dst, smp->smp_key_size,
-							ediv, rand, stk);
-	}
+	queue_work(hdev->workqueue, &smp->random);
 
 	return 0;
 }
@@ -440,14 +516,14 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct smp_cmd_security_req *rp = (void *) skb->data;
 	struct smp_cmd_pairing cp;
 	struct hci_conn *hcon = conn->hcon;
-	struct smp_chan *smp = conn->smp_chan;
+	struct smp_chan *smp;
 
 	BT_DBG("conn %p", conn);
 
 	if (test_and_set_bit(HCI_CONN_LE_SMP_PEND, &hcon->pend))
 		return 0;
 
-	hci_conn_hold(hcon);
+	smp = smp_chan_create(conn);
 
 	skb_pull(skb, sizeof(*rp));
 
@@ -502,8 +578,7 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 	if (test_and_set_bit(HCI_CONN_LE_SMP_PEND, &hcon->pend))
 		return 0;
 
-	/* While SMP is going on */
-	hci_conn_hold(hcon);
+	smp = smp_chan_create(conn);
 
 	authreq = seclevel_to_authreq(sec_level);
 
@@ -710,7 +785,7 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 	if (conn->hcon->out || force) {
 		clear_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->pend);
 		del_timer(&conn->security_timer);
-		hci_conn_put(conn->hcon);
+		smp_chan_destroy(conn);
 	}
 
 	return 0;
-- 
1.7.6.1

