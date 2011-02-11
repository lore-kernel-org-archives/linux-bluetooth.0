Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [bluetooth-next -v2 12/24] Bluetooth: simple SMP pairing negotiation
Date: Thu, 10 Feb 2011 22:38:57 -0300
Message-Id: <1297388349-14878-13-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1297388349-14878-12-git-send-email-vinicius.gomes@openbossa.org>
References: <1297388349-14878-1-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-2-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-3-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-4-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-5-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-6-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-7-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-8-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-9-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-10-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-11-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-12-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

This implementation only exchanges SMP messages between the Host and the
Remote. No keys are being generated. TK and STK generation will be
provided in further patches.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/smp.c |  106 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 101 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 8b67a56..9a75891 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -64,6 +64,93 @@ static void smp_send_cmd(struct l2cap_conn *conn, u8 code, u16 len, void *data)
 	hci_send_acl(conn->hcon, skb, 0);
 }
 
+static void smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
+{
+	struct smp_cmd_pairing *rp = (void *) skb->data;
+
+	BT_DBG("conn %p", conn);
+
+	skb_pull(skb, sizeof(*rp));
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
+	BT_DBG("conn %p", conn);
+
+	memset(&cp, 0, sizeof(cp));
+
+	smp_send_cmd(conn, SMP_CMD_PAIRING_CONFIRM, sizeof(cp), &cp);
+}
+
+static void smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
+{
+	BT_DBG("conn %p %s", conn, conn->hcon->out ? "master" : "slave");
+
+	if (conn->hcon->out) {
+		struct smp_cmd_pairing_random random;
+
+		memset(&random, 0, sizeof(random));
+
+		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(random),
+								&random);
+	} else {
+		struct smp_cmd_pairing_confirm confirm;
+
+		memset(&confirm, 0, sizeof(confirm));
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
+	BT_DBG("conn %p %s", conn, conn->hcon->out ? "master" : "slave");
+
+	skb_pull(skb, sizeof(cp));
+
+	if (conn->hcon->out) {
+		/* FIXME: start encryption */
+	} else {
+		memset(&cp, 0, sizeof(cp));
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
+	BT_DBG("conn %p", conn);
+
+	skb_pull(skb, sizeof(*rp));
+	memset(&cp, 0, sizeof(cp));
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
 int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 {
 	__u8 authreq;
@@ -114,24 +201,33 @@ int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	switch (code) {
 	case SMP_CMD_PAIRING_REQ:
-		reason = SMP_PAIRING_NOTSUPP;
-		smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(reason),
-								&reason);
-		err = -EOPNOTSUPP;
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
1.7.4

