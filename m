Return-Path: <cyrus@holtmann.org>
From: Anderson Briglia <anderson.briglia@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 6/6] Bluetooth: simple SMP pairing negotiation
Date: Fri, 22 Oct 2010 19:57:00 -0400
Message-Id: <1287791820-22693-7-git-send-email-anderson.briglia@openbossa.org>
In-Reply-To: <linux-bluetooth@vger.kernel.org>
References: <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

This implementation only exchanges SMP messages between the Host and the
Remote. No keys are being generated. TK and STK generation will be
provided in further patches.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/l2cap.c |  118 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 114 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 2a88f23..be91a33 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -4644,6 +4644,104 @@ done:
 	return 0;
 }
 
+static void smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
+{
+	struct smp_cmd_pairing *rp = (void *) skb->data;
+
+	BT_DBG("");
+
+	skb_pull(skb, sizeof(struct smp_cmd_pairing));
+
+	rp->io_capability = 0x00;
+	rp->oob_flag = 0x00;
+	rp->max_key_size = 16;
+	rp->init_key_dist = 0x00;
+	rp->resp_key_dist = 0x00;
+	rp->auth_req &= 0x05;
+
+	smp_send_cmd(conn, SMP_CMD_PAIRING_RSP, sizeof(*rp), rp);
+}
+
+static void smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
+{
+	struct smp_cmd_pairing_confirm cp;
+
+	BT_DBG("");
+
+	memset(&cp, 0, sizeof(struct smp_cmd_pairing_confirm));
+
+	smp_send_cmd(conn, SMP_CMD_PAIRING_CONFIRM, sizeof(cp), &cp);
+}
+
+static void smp_cmd_pairing_confirm(struct l2cap_conn *conn,
+							struct sk_buff *skb)
+{
+	BT_DBG("");
+
+	if (conn->hcon->link_mode & HCI_LM_MASTER) {
+
+		struct smp_cmd_pairing_random random;
+
+		BT_DBG("master");
+
+		memset(&random, 0, sizeof(struct smp_cmd_pairing_random));
+
+		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(random),
+								&random);
+	} else {
+		struct smp_cmd_pairing_confirm confirm;
+
+		BT_DBG("slave");
+
+		memset(&confirm, 0, sizeof(struct smp_cmd_pairing_confirm));
+
+		smp_send_cmd(conn, SMP_CMD_PAIRING_CONFIRM, sizeof(confirm),
+								&confirm);
+	}
+}
+
+static void smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
+{
+	struct smp_cmd_pairing_random cp;
+
+	BT_DBG("");
+
+	skb_pull(skb, sizeof(struct smp_cmd_pairing_random));
+
+	/* FIXME: check if random matches */
+
+	if (conn->hcon->link_mode & HCI_LM_MASTER) {
+		BT_DBG("master");
+		/* FIXME: start encryption */
+	} else {
+		BT_DBG("slave");
+
+		memset(&cp, 0, sizeof(struct smp_cmd_pairing_random));
+
+		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(cp), &cp);
+	}
+}
+
+static void smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
+{
+	struct smp_cmd_security_req *rp = (void *) skb->data;
+	struct smp_cmd_pairing cp;
+
+	BT_DBG("");
+
+	skb_pull(skb, sizeof(struct smp_cmd_security_req));
+	memset(&cp, 0, sizeof(struct smp_cmd_pairing));
+
+	cp.io_capability = 0x00;
+	cp.oob_flag = 0x00;
+	cp.max_key_size = 16;
+	cp.init_key_dist = 0x00;
+	cp.resp_key_dist = 0x00;
+	cp.auth_req = rp->auth_req & 0x05;
+
+	smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
+}
+
 static inline void smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	__u8 code = skb->data[0];
@@ -4651,25 +4749,37 @@ static inline void smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	skb_pull(skb, 1);
 
+	BT_DBG("conn %p code 0x%2.2x", conn, code);
+
 	switch (code) {
 	case SMP_CMD_PAIRING_REQ:
-		reason = SMP_PAIRING_NOTSUPP;
-		smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, 1, &reason);
-		l2cap_conn_del(conn->hcon, 0x05);
+		smp_cmd_pairing_req(conn, skb);
 		break;
 
 	case SMP_CMD_PAIRING_FAIL:
 		break;
 
 	case SMP_CMD_PAIRING_RSP:
+		smp_cmd_pairing_rsp(conn, skb);
+		break;
+
+	case SMP_CMD_SECURITY_REQ:
+		smp_cmd_security_req(conn, skb);
+		break;
+
 	case SMP_CMD_PAIRING_CONFIRM:
+		smp_cmd_pairing_confirm(conn, skb);
+		break;
+
 	case SMP_CMD_PAIRING_RANDOM:
+		smp_cmd_pairing_random(conn, skb);
+		break;
+
 	case SMP_CMD_ENCRYPT_INFO:
 	case SMP_CMD_MASTER_IDENT:
 	case SMP_CMD_IDENT_INFO:
 	case SMP_CMD_IDENT_ADDR_INFO:
 	case SMP_CMD_SIGN_INFO:
-	case SMP_CMD_SECURITY_REQ:
 	default:
 		BT_DBG("Unknown command code 0x%2.2x", code);
 
-- 
1.7.0.4

