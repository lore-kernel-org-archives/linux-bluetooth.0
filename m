Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 1/4] Bluetooth: Move SMP fields to a separate structure
Date: Fri, 19 Aug 2011 21:00:12 -0300
Message-Id: <1313798415-8555-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The objective is to make the core to have as little as possible
information about SMP procedures and logic. Now, all the SMP
specific information is hidden from the core.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    2 -
 include/net/bluetooth/l2cap.h    |   10 +--
 net/bluetooth/hci_core.c         |    8 ---
 net/bluetooth/smp.c              |  118 ++++++++++++++++++++-----------------
 4 files changed, 67 insertions(+), 71 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6e68e43..cc1ea91 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -195,8 +195,6 @@ struct hci_dev {
 
 	__u16			init_last_cmd;
 
-	struct crypto_blkcipher	*tfm;
-
 	struct inquiry_cache	inq_cache;
 	struct hci_conn_hash	conn_hash;
 	struct list_head	blacklist;
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 6fa1140..00e42aa 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -386,6 +386,8 @@ struct l2cap_ops {
 	void			(*state_change) (void *data, int state);
 };
 
+struct smp_chan;
+
 struct l2cap_conn {
 	struct hci_conn	*hcon;
 
@@ -409,14 +411,8 @@ struct l2cap_conn {
 
 	__u8		disc_reason;
 
-	__u8		preq[7]; /* SMP Pairing Request */
-	__u8		prsp[7]; /* SMP Pairing Response */
-	__u8		prnd[16]; /* SMP Pairing Random */
-	__u8		pcnf[16]; /* SMP Pairing Confirm */
-	__u8		tk[16]; /* SMP Temporary Key */
-	__u8		smp_key_size;
-
 	struct timer_list security_timer;
+	struct smp_chan *smp_chan;
 
 	struct list_head chan_l;
 	rwlock_t	chan_lock;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 56943ad..534a271 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1523,11 +1523,6 @@ int hci_register_dev(struct hci_dev *hdev)
 	if (!hdev->workqueue)
 		goto nomem;
 
-	hdev->tfm = crypto_alloc_blkcipher("ecb(aes)", 0, CRYPTO_ALG_ASYNC);
-	if (IS_ERR(hdev->tfm))
-		BT_INFO("Failed to load transform for ecb(aes): %ld",
-							PTR_ERR(hdev->tfm));
-
 	hci_register_sysfs(hdev);
 
 	hdev->rfkill = rfkill_alloc(hdev->name, &hdev->dev,
@@ -1576,9 +1571,6 @@ int hci_unregister_dev(struct hci_dev *hdev)
 					!test_bit(HCI_SETUP, &hdev->flags))
 		mgmt_index_removed(hdev->id);
 
-	if (!IS_ERR(hdev->tfm))
-		crypto_free_blkcipher(hdev->tfm);
-
 	hci_notify(hdev, HCI_DEV_UNREG);
 
 	if (hdev->rfkill) {
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index f0c67f6..f911930 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -30,6 +30,16 @@
 
 #define SMP_TIMEOUT 30000 /* 30 seconds */
 
+struct smp_chan {
+	u8		preq[7]; /* SMP Pairing Request */
+	u8		prsp[7]; /* SMP Pairing Response */
+	u8		prnd[16]; /* SMP Pairing Random */
+	u8		pcnf[16]; /* SMP Pairing Confirm */
+	u8		tk[16]; /* SMP Temporary Key */
+	u8		smp_key_size;
+	struct crypto_blkcipher	*tfm;
+};
+
 static inline void swap128(u8 src[16], u8 dst[16])
 {
 	int i;
@@ -232,11 +242,13 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 
 static u8 check_enc_key_size(struct l2cap_conn *conn, __u8 max_key_size)
 {
+	struct smp_chan *smp = conn->smp_chan;
+
 	if ((max_key_size > SMP_MAX_ENC_KEY_SIZE) ||
 			(max_key_size < SMP_MIN_ENC_KEY_SIZE))
 		return SMP_ENC_KEY_SIZE;
 
-	conn->smp_key_size = max_key_size;
+	smp->smp_key_size = max_key_size;
 
 	return 0;
 }
@@ -244,6 +256,7 @@ static u8 check_enc_key_size(struct l2cap_conn *conn, __u8 max_key_size)
 static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_cmd_pairing rsp, *req = (void *) skb->data;
+	struct smp_chan *smp = conn->smp_chan;
 	u8 key_size;
 
 	BT_DBG("conn %p", conn);
@@ -251,8 +264,8 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (!test_and_set_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->pend))
 		hci_conn_hold(conn->hcon);
 
-	conn->preq[0] = SMP_CMD_PAIRING_REQ;
-	memcpy(&conn->preq[1], req, sizeof(*req));
+	smp->preq[0] = SMP_CMD_PAIRING_REQ;
+	memcpy(&smp->preq[1], req, sizeof(*req));
 	skb_pull(skb, sizeof(*req));
 
 	if (req->oob_flag)
@@ -266,10 +279,10 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 		return SMP_ENC_KEY_SIZE;
 
 	/* Just works */
-	memset(conn->tk, 0, sizeof(conn->tk));
+	memset(smp->tk, 0, sizeof(smp->tk));
 
-	conn->prsp[0] = SMP_CMD_PAIRING_RSP;
-	memcpy(&conn->prsp[1], &rsp, sizeof(rsp));
+	smp->prsp[0] = SMP_CMD_PAIRING_RSP;
+	memcpy(&smp->prsp[1], &rsp, sizeof(rsp));
 
 	smp_send_cmd(conn, SMP_CMD_PAIRING_RSP, sizeof(rsp), &rsp);
 
@@ -280,7 +293,9 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_cmd_pairing *req, *rsp = (void *) skb->data;
 	struct smp_cmd_pairing_confirm cp;
-	struct crypto_blkcipher *tfm = conn->hcon->hdev->tfm;
+	struct smp_chan *smp = conn->smp_chan;
+	struct crypto_blkcipher *tfm = smp->tfm;
+
 	int ret;
 	u8 res[16], key_size;
 
@@ -288,7 +303,7 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	skb_pull(skb, sizeof(*rsp));
 
-	req = (void *) &conn->preq[1];
+	req = (void *) &smp->preq[1];
 
 	key_size = min(req->max_key_size, rsp->max_key_size);
 	if (check_enc_key_size(conn, key_size))
@@ -298,16 +313,16 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 		return SMP_OOB_NOT_AVAIL;
 
 	/* Just works */
-	memset(conn->tk, 0, sizeof(conn->tk));
+	memset(smp->tk, 0, sizeof(smp->tk));
 
-	conn->prsp[0] = SMP_CMD_PAIRING_RSP;
-	memcpy(&conn->prsp[1], rsp, sizeof(*rsp));
+	smp->prsp[0] = SMP_CMD_PAIRING_RSP;
+	memcpy(&smp->prsp[1], rsp, sizeof(*rsp));
 
-	ret = smp_rand(conn->prnd);
+	ret = smp_rand(smp->prnd);
 	if (ret)
 		return SMP_UNSPECIFIED;
 
-	ret = smp_c1(tfm, conn->tk, conn->prnd, conn->preq, conn->prsp, 0,
+	ret = smp_c1(tfm, smp->tk, smp->prnd, smp->preq, smp->prsp, 0,
 			conn->src, conn->hcon->dst_type, conn->dst, res);
 	if (ret)
 		return SMP_UNSPECIFIED;
@@ -321,17 +336,18 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 
 static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 {
-	struct crypto_blkcipher *tfm = conn->hcon->hdev->tfm;
+	struct smp_chan *smp = conn->smp_chan;
+	struct crypto_blkcipher *tfm = smp->tfm;
 
 	BT_DBG("conn %p %s", conn, conn->hcon->out ? "master" : "slave");
 
-	memcpy(conn->pcnf, skb->data, sizeof(conn->pcnf));
-	skb_pull(skb, sizeof(conn->pcnf));
+	memcpy(smp->pcnf, skb->data, sizeof(smp->pcnf));
+	skb_pull(skb, sizeof(smp->pcnf));
 
 	if (conn->hcon->out) {
 		u8 random[16];
 
-		swap128(conn->prnd, random);
+		swap128(smp->prnd, random);
 		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(random),
 								random);
 	} else {
@@ -339,11 +355,11 @@ static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 		int ret;
 		u8 res[16];
 
-		ret = smp_rand(conn->prnd);
+		ret = smp_rand(smp->prnd);
 		if (ret)
 			return SMP_UNSPECIFIED;
 
-		ret = smp_c1(tfm, conn->tk, conn->prnd, conn->preq, conn->prsp,
+		ret = smp_c1(tfm, smp->tk, smp->prnd, smp->preq, smp->prsp,
 						conn->hcon->dst_type, conn->dst,
 						0, conn->src, res);
 		if (ret)
@@ -360,7 +376,8 @@ static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct hci_conn *hcon = conn->hcon;
-	struct crypto_blkcipher *tfm = hcon->hdev->tfm;
+	struct smp_chan *smp = conn->smp_chan;
+	struct crypto_blkcipher *tfm = smp->tfm;
 	int ret;
 	u8 key[16], res[16], random[16], confirm[16];
 
@@ -368,11 +385,11 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	skb_pull(skb, sizeof(random));
 
 	if (conn->hcon->out)
-		ret = smp_c1(tfm, conn->tk, random, conn->preq, conn->prsp, 0,
+		ret = smp_c1(tfm, smp->tk, random, smp->preq, smp->prsp, 0,
 				conn->src, conn->hcon->dst_type, conn->dst,
 				res);
 	else
-		ret = smp_c1(tfm, conn->tk, random, conn->preq, conn->prsp,
+		ret = smp_c1(tfm, smp->tk, random, smp->preq, smp->prsp,
 				conn->hcon->dst_type, conn->dst, 0, conn->src,
 				res);
 	if (ret)
@@ -382,7 +399,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	swap128(res, confirm);
 
-	if (memcmp(conn->pcnf, confirm, sizeof(conn->pcnf)) != 0) {
+	if (memcmp(smp->pcnf, confirm, sizeof(smp->pcnf)) != 0) {
 		BT_ERR("Pairing failed (confirmation values mismatch)");
 		return SMP_CONFIRM_FAILED;
 	}
@@ -394,17 +411,17 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 		memset(rand, 0, sizeof(rand));
 		ediv = 0;
 
-		smp_s1(tfm, conn->tk, random, conn->prnd, key);
+		smp_s1(tfm, smp->tk, random, smp->prnd, key);
 		swap128(key, stk);
 
-		memset(stk + conn->smp_key_size, 0,
-				SMP_MAX_ENC_KEY_SIZE - conn->smp_key_size);
+		memset(stk + smp->smp_key_size, 0,
+				SMP_MAX_ENC_KEY_SIZE - smp->smp_key_size);
 
 		if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, &hcon->pend))
 			return SMP_UNSPECIFIED;
 
 		hci_le_start_enc(hcon, ediv, rand, stk);
-		hcon->enc_key_size = conn->smp_key_size;
+		hcon->enc_key_size = smp->smp_key_size;
 	} else {
 		u8 stk[16], r[16], rand[8];
 		__le16 ediv;
@@ -412,16 +429,16 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 		memset(rand, 0, sizeof(rand));
 		ediv = 0;
 
-		swap128(conn->prnd, r);
+		swap128(smp->prnd, r);
 		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(r), r);
 
-		smp_s1(tfm, conn->tk, conn->prnd, random, key);
+		smp_s1(tfm, smp->tk, smp->prnd, random, key);
 		swap128(key, stk);
 
-		memset(stk + conn->smp_key_size, 0,
-				SMP_MAX_ENC_KEY_SIZE - conn->smp_key_size);
+		memset(stk + smp->smp_key_size, 0,
+				SMP_MAX_ENC_KEY_SIZE - smp->smp_key_size);
 
-		hci_add_ltk(conn->hcon->hdev, 0, conn->dst, conn->smp_key_size,
+		hci_add_ltk(conn->hcon->hdev, 0, conn->dst, smp->smp_key_size,
 							ediv, rand, stk);
 	}
 
@@ -433,6 +450,7 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct smp_cmd_security_req *rp = (void *) skb->data;
 	struct smp_cmd_pairing cp;
 	struct hci_conn *hcon = conn->hcon;
+	struct smp_chan *smp = conn->smp_chan;
 
 	BT_DBG("conn %p", conn);
 
@@ -446,8 +464,8 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	memset(&cp, 0, sizeof(cp));
 	build_pairing_cmd(conn, &cp, NULL, rp->auth_req);
 
-	conn->preq[0] = SMP_CMD_PAIRING_REQ;
-	memcpy(&conn->preq[1], &cp, sizeof(cp));
+	smp->preq[0] = SMP_CMD_PAIRING_REQ;
+	memcpy(&smp->preq[1], &cp, sizeof(cp));
 
 	smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
 
@@ -457,6 +475,7 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 {
 	struct hci_conn *hcon = conn->hcon;
+	struct smp_chan *smp = conn->smp_chan;
 	__u8 authreq;
 
 	BT_DBG("conn %p hcon %p level 0x%2.2x", conn, hcon, sec_level);
@@ -464,9 +483,6 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 	if (!lmp_host_le_capable(hcon->hdev))
 		return 1;
 
-	if (IS_ERR(hcon->hdev->tfm))
-		return 1;
-
 	if (sec_level == BT_SECURITY_LOW)
 		return 1;
 
@@ -505,8 +521,8 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 		struct smp_cmd_pairing cp;
 
 		build_pairing_cmd(conn, &cp, NULL, authreq);
-		conn->preq[0] = SMP_CMD_PAIRING_REQ;
-		memcpy(&conn->preq[1], &cp, sizeof(cp));
+		smp->preq[0] = SMP_CMD_PAIRING_REQ;
+		memcpy(&smp->preq[1], &cp, sizeof(cp));
 
 		smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
 	} else {
@@ -524,10 +540,11 @@ done:
 static int smp_cmd_encrypt_info(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_cmd_encrypt_info *rp = (void *) skb->data;
+	struct smp_chan *smp = conn->smp_chan;
 
 	skb_pull(skb, sizeof(*rp));
 
-	memcpy(conn->tk, rp->ltk, sizeof(conn->tk));
+	memcpy(smp->tk, rp->ltk, sizeof(smp->tk));
 
 	return 0;
 }
@@ -535,11 +552,12 @@ static int smp_cmd_encrypt_info(struct l2cap_conn *conn, struct sk_buff *skb)
 static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_cmd_master_ident *rp = (void *) skb->data;
+	struct smp_chan *smp = conn->smp_chan;
 
 	skb_pull(skb, sizeof(*rp));
 
-	hci_add_ltk(conn->hcon->hdev, 1, conn->src, conn->smp_key_size,
-						rp->ediv, rp->rand, conn->tk);
+	hci_add_ltk(conn->hcon->hdev, 1, conn->src, smp->smp_key_size,
+						rp->ediv, rp->rand, smp->tk);
 
 	smp_distribute_keys(conn, 1);
 
@@ -558,12 +576,6 @@ int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
 		goto done;
 	}
 
-	if (IS_ERR(conn->hcon->hdev->tfm)) {
-		err = PTR_ERR(conn->hcon->hdev->tfm);
-		reason = SMP_PAIRING_NOTSUPP;
-		goto done;
-	}
-
 	skb_pull(skb, sizeof(code));
 
 	switch (code) {
@@ -627,23 +639,21 @@ done:
 int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 {
 	struct smp_cmd_pairing *req, *rsp;
+	struct smp_chan *smp = conn->smp_chan;
 	__u8 *keydist;
 
 	BT_DBG("conn %p force %d", conn, force);
 
-	if (IS_ERR(conn->hcon->hdev->tfm))
-		return PTR_ERR(conn->hcon->hdev->tfm);
-
 	if (!test_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->pend))
 		return 0;
 
-	rsp = (void *) &conn->prsp[1];
+	rsp = (void *) &smp->prsp[1];
 
 	/* The responder sends its keys first */
 	if (!force && conn->hcon->out && (rsp->resp_key_dist & 0x07))
 		return 0;
 
-	req = (void *) &conn->preq[1];
+	req = (void *) &smp->preq[1];
 
 	if (conn->hcon->out) {
 		keydist = &rsp->init_key_dist;
@@ -667,7 +677,7 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 
 		smp_send_cmd(conn, SMP_CMD_ENCRYPT_INFO, sizeof(enc), &enc);
 
-		hci_add_ltk(conn->hcon->hdev, 1, conn->dst, conn->smp_key_size,
+		hci_add_ltk(conn->hcon->hdev, 1, conn->dst, smp->smp_key_size,
 						ediv, ident.rand, enc.ltk);
 
 		ident.ediv = cpu_to_le16(ediv);
-- 
1.7.6

