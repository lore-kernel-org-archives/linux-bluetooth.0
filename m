Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [bluetooth-next v2 07/16] Bluetooth: Add SMP confirmation checks methods
Date: Thu,  2 Jun 2011 17:32:09 -0300
Message-Id: <1307046738-19588-8-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1307046738-19588-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1307046738-19588-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

This patch includes support for generating and sending the random value
used to produce the confirmation value.

Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/smp.c           |   94 ++++++++++++++++++++++++++++++++++------
 2 files changed, 81 insertions(+), 14 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 36f5b0d..12f6c19 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -383,6 +383,7 @@ struct l2cap_conn {
 	__u8		prsp[7]; /* SMP Pairing Response */
 	__u8		prnd[16]; /* SMP Pairing Random */
 	__u8		pcnf[16]; /* SMP Pairing Confirm */
+	__u8		tk[16]; /* SMP Temporary Key */
 
 	struct list_head chan_l;
 	rwlock_t	chan_lock;
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index fa22f4a..dfb9b63 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -198,6 +198,9 @@ static void smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	rp->resp_key_dist = 0x00;
 	rp->auth_req &= (SMP_AUTH_BONDING | SMP_AUTH_MITM);
 
+	/* Just works */
+	memset(conn->tk, 0, sizeof(conn->tk));
+
 	conn->prsp[0] = SMP_CMD_PAIRING_RSP;
 	memcpy(&conn->prsp[1], rp, sizeof(*rp));
 
@@ -208,54 +211,117 @@ static void smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_cmd_pairing *rp = (void *) skb->data;
 	struct smp_cmd_pairing_confirm cp;
+	struct crypto_blkcipher *tfm = conn->hcon->hdev->tfm;
+	int ret;
+	u8 res[16];
 
 	BT_DBG("conn %p", conn);
 
-	memset(&cp, 0, sizeof(cp));
+	/* Just works */
+	memset(conn->tk, 0, sizeof(conn->tk));
 
 	conn->prsp[0] = SMP_CMD_PAIRING_RSP;
 	memcpy(&conn->prsp[1], rp, sizeof(*rp));
 	skb_pull(skb, sizeof(*rp));
 
+	ret = smp_rand(conn->prnd);
+	if (ret)
+		return;
+
+	ret = smp_c1(tfm, conn->tk, conn->prnd, conn->preq, conn->prsp, 0,
+			conn->src, 0, conn->dst, res);
+	if (ret)
+		return;
+
+	swap128(res, cp.confirm_val);
+
 	smp_send_cmd(conn, SMP_CMD_PAIRING_CONFIRM, sizeof(cp), &cp);
 }
 
 static void smp_cmd_pairing_confirm(struct l2cap_conn *conn,
 							struct sk_buff *skb)
 {
+	struct crypto_blkcipher *tfm = conn->hcon->hdev->tfm;
+
 	BT_DBG("conn %p %s", conn, conn->hcon->out ? "master" : "slave");
 
-	if (conn->hcon->out) {
-		struct smp_cmd_pairing_random random;
+	memcpy(conn->pcnf, skb->data, sizeof(conn->pcnf));
+	skb_pull(skb, sizeof(conn->pcnf));
 
-		memset(&random, 0, sizeof(random));
+	if (conn->hcon->out) {
+		u8 random[16];
 
+		swap128(conn->prnd, random);
 		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(random),
-								&random);
+								random);
 	} else {
-		struct smp_cmd_pairing_confirm confirm;
+		struct smp_cmd_pairing_confirm cp;
+		int ret;
+		u8 res[16];
 
-		memset(&confirm, 0, sizeof(confirm));
+		ret = smp_rand(conn->prnd);
+		if (ret)
+			return;
 
-		smp_send_cmd(conn, SMP_CMD_PAIRING_CONFIRM, sizeof(confirm),
-								&confirm);
+		ret = smp_c1(tfm, conn->tk, conn->prnd, conn->preq, conn->prsp,
+					0, conn->dst, 0, conn->src, res);
+		if (ret)
+			return;
+
+		swap128(res, cp.confirm_val);
+
+		smp_send_cmd(conn, SMP_CMD_PAIRING_CONFIRM, sizeof(cp), &cp);
 	}
 }
 
 static void smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 {
-	struct smp_cmd_pairing_random cp;
+	struct crypto_blkcipher *tfm = conn->hcon->hdev->tfm;
+	int ret;
+	u8 key[16], res[16], random[16], confirm[16], buf[128];
+
+	swap128(skb->data, random);
+	skb_pull(skb, sizeof(random));
+
+	if (conn->hcon->out)
+		ret = smp_c1(tfm, conn->tk, random, conn->preq, conn->prsp, 0,
+				conn->src, 0, conn->dst, res);
+	else
+		ret = smp_c1(tfm, conn->tk, random, conn->preq, conn->prsp, 0,
+				conn->dst, 0, conn->src, res);
+	if (ret)
+		return;
 
 	BT_DBG("conn %p %s", conn, conn->hcon->out ? "master" : "slave");
 
-	skb_pull(skb, sizeof(cp));
+	swap128(res, confirm);
+
+	if (memcmp(conn->pcnf, confirm, sizeof(conn->pcnf)) != 0) {
+		struct smp_cmd_pairing_fail cp;
+
+		BT_ERR("Pairing failed (confirmation values mismatch)");
+		cp.reason = SMP_CONFIRM_FAILED;
+		smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(cp), &cp);
+		return;
+	}
 
 	if (conn->hcon->out) {
-		/* FIXME: start encryption */
+		smp_s1(tfm, conn->tk, random, conn->prnd, key);
+
+		hex_dump_to_buffer(key, sizeof(key), 16, 1, buf,
+							sizeof(buf), 0);
+		BT_DBG("key %s", buf);
 	} else {
-		memset(&cp, 0, sizeof(cp));
+		u8 r[16];
+
+		swap128(conn->prnd, r);
+		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(r), r);
+
+		smp_s1(tfm, conn->tk, conn->prnd, random, key);
 
-		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(cp), &cp);
+		hex_dump_to_buffer(key, sizeof(key), 16, 1, buf,
+							sizeof(buf), 0);
+		BT_DBG("key %s", buf);
 	}
 }
 
-- 
1.7.5.1

