Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [bluetooth-next 15/15] Bluetooth: Add key size checks for SMP
Date: Tue,  5 Apr 2011 22:51:56 -0300
Message-Id: <1302054716-24534-16-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1302054716-24534-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1302054716-24534-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements a check in smp cmd pairing request and pairing
response to verify if encryption key maximum size is compatible in both
slave and master when SMP Pairing is requested. Keys are also masked to
the correct negotiated size.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
---
 include/net/bluetooth/l2cap.h |    1 +
 include/net/bluetooth/smp.h   |    3 ++
 net/bluetooth/smp.c           |   54 +++++++++++++++++++++++++++++++----------
 3 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index a542757..5505c4d 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -310,6 +310,7 @@ struct l2cap_conn {
 	__u8		prnd[16]; /* SMP Pairing Random */
 	__u8		pcnf[16]; /* SMP Pairing Confirm */
 	__u8		tk[16]; /* SMP Temporary Key */
+	__u8		smp_key_size;
 
 	struct timer_list security_timer;
 
diff --git a/include/net/bluetooth/smp.h b/include/net/bluetooth/smp.h
index 111853a..4fb7d19 100644
--- a/include/net/bluetooth/smp.h
+++ b/include/net/bluetooth/smp.h
@@ -112,6 +112,9 @@ struct smp_cmd_security_req {
 #define SMP_UNSPECIFIED		0x08
 #define SMP_REPEATED_ATTEMPTS		0x09
 
+#define SMP_MIN_ENC_KEY_SIZE		7
+#define SMP_MAX_ENC_KEY_SIZE		16
+
 /* SMP Commands */
 int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level);
 int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb);
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 96e8b3f..0ea639c 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -205,35 +205,51 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 {
 	cmd->io_capability = SMP_IO_NO_INPUT_OUTPUT;
 	cmd->oob_flag = SMP_OOB_NOT_PRESENT;
-	cmd->max_key_size = 16;
+	cmd->max_key_size = SMP_MAX_ENC_KEY_SIZE;
 	cmd->init_key_dist = 0x00;
 	cmd->resp_key_dist = 0x00;
 	cmd->auth_req = authreq;
 }
 
+static u8 check_enc_key_size(struct l2cap_conn *conn, __u8 max_key_size)
+{
+	if ((max_key_size > SMP_MAX_ENC_KEY_SIZE) ||
+			(max_key_size < SMP_MIN_ENC_KEY_SIZE))
+		return SMP_ENC_KEY_SIZE;
+
+	conn->smp_key_size = max_key_size;
+
+	return 0;
+}
+
 static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 {
-	struct smp_cmd_pairing *rp = (void *) skb->data;
+	struct smp_cmd_pairing rsp, *req = (void *) skb->data;
+	u8 key_size;
 
 	BT_DBG("conn %p", conn);
 
 	conn->preq[0] = SMP_CMD_PAIRING_REQ;
-	memcpy(&conn->preq[1], rp, sizeof(*rp));
-	skb_pull(skb, sizeof(*rp));
+	memcpy(&conn->preq[1], req, sizeof(*req));
+	skb_pull(skb, sizeof(*req));
 
-	if (rp->oob_flag)
+	if (req->oob_flag)
 		return SMP_OOB_NOT_AVAIL;
 
 	/* We didn't start the pairing, so no requirements */
-	build_pairing_cmd(conn, rp, SMP_AUTH_NONE);
+	build_pairing_cmd(conn, &rsp, SMP_AUTH_NONE);
+
+	key_size = min(req->max_key_size, rsp.max_key_size);
+	if (check_enc_key_size(conn, key_size))
+		return SMP_ENC_KEY_SIZE;
 
 	/* Just works */
 	memset(conn->tk, 0, sizeof(conn->tk));
 
 	conn->prsp[0] = SMP_CMD_PAIRING_RSP;
-	memcpy(&conn->prsp[1], rp, sizeof(*rp));
+	memcpy(&conn->prsp[1], &rsp, sizeof(rsp));
 
-	smp_send_cmd(conn, SMP_CMD_PAIRING_RSP, sizeof(*rp), rp);
+	smp_send_cmd(conn, SMP_CMD_PAIRING_RSP, sizeof(rsp), &rsp);
 
 	mod_timer(&conn->security_timer, jiffies +
 					msecs_to_jiffies(SMP_TIMEOUT));
@@ -243,24 +259,30 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 {
-	struct smp_cmd_pairing *rp = (void *) skb->data;
+	struct smp_cmd_pairing *req, *rsp = (void *) skb->data;
 	struct smp_cmd_pairing_confirm cp;
 	struct crypto_blkcipher *tfm = conn->hcon->hdev->tfm;
 	int ret;
-	u8 res[16];
+	u8 res[16], key_size;
 
 	BT_DBG("conn %p", conn);
 
-	skb_pull(skb, sizeof(*rp));
+	skb_pull(skb, sizeof(*rsp));
+
+	req = (void *) &conn->preq[1];
 
-	if (rp->oob_flag)
+	key_size = min(req->max_key_size, rsp->max_key_size);
+	if (check_enc_key_size(conn, key_size))
+		return SMP_ENC_KEY_SIZE;
+
+	if (rsp->oob_flag)
 		return SMP_OOB_NOT_AVAIL;
 
 	/* Just works */
 	memset(conn->tk, 0, sizeof(conn->tk));
 
 	conn->prsp[0] = SMP_CMD_PAIRING_RSP;
-	memcpy(&conn->prsp[1], rp, sizeof(*rp));
+	memcpy(&conn->prsp[1], rsp, sizeof(*rsp));
 
 	ret = smp_rand(conn->prnd);
 	if (ret)
@@ -352,6 +374,9 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 		smp_s1(tfm, conn->tk, random, conn->prnd, key);
 		swap128(key, hcon->ltk);
 
+		memset(hcon->ltk + conn->smp_key_size, 0,
+				SMP_MAX_ENC_KEY_SIZE - conn->smp_key_size);
+
 		hci_le_start_enc(hcon, hcon->ltk);
 
 		hex_dump_to_buffer(key, sizeof(key), 16, 1, buf,
@@ -366,6 +391,9 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 		smp_s1(tfm, conn->tk, conn->prnd, random, key);
 		swap128(key, hcon->ltk);
 
+		memset(hcon->ltk + conn->smp_key_size, 0,
+				SMP_MAX_ENC_KEY_SIZE - conn->smp_key_size);
+
 		hex_dump_to_buffer(key, sizeof(key), 16, 1, buf,
 							sizeof(buf), 0);
 		BT_DBG("key %s", buf);
-- 
1.7.4.1

