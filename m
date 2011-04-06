Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [bluetooth-next 06/15] Bluetooth: Add SMP confirmation structs
Date: Tue,  5 Apr 2011 22:51:47 -0300
Message-Id: <1302054716-24534-7-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1302054716-24534-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1302054716-24534-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

This patch adds initial support for verifying the confirmation value
that the remote side has sent.

Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/l2cap.h |    5 +++++
 net/bluetooth/smp.c           |   17 +++++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 2b9ca0d..dc4aa63 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -305,6 +305,11 @@ struct l2cap_conn {
 
 	__u8		disc_reason;
 
+	__u8		preq[7]; /* SMP Pairing Request */
+	__u8		prsp[7]; /* SMP Pairing Response */
+	__u8		prnd[16]; /* SMP Pairing Random */
+	__u8		pcnf[16]; /* SMP Pairing Confirm */
+
 	struct l2cap_chan_list chan_list;
 };
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 58047e8..7fa3542 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -192,6 +192,8 @@ static void smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	BT_DBG("conn %p", conn);
 
+	conn->preq[0] = SMP_CMD_PAIRING_REQ;
+	memcpy(&conn->preq[1], rp, sizeof(*rp));
 	skb_pull(skb, sizeof(*rp));
 
 	rp->io_capability = 0x00;
@@ -201,17 +203,25 @@ static void smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	rp->resp_key_dist = 0x00;
 	rp->auth_req &= (SMP_AUTH_BONDING | SMP_AUTH_MITM);
 
+	conn->prsp[0] = SMP_CMD_PAIRING_RSP;
+	memcpy(&conn->prsp[1], rp, sizeof(*rp));
+
 	smp_send_cmd(conn, SMP_CMD_PAIRING_RSP, sizeof(*rp), rp);
 }
 
 static void smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 {
+	struct smp_cmd_pairing *rp = (void *) skb->data;
 	struct smp_cmd_pairing_confirm cp;
 
 	BT_DBG("conn %p", conn);
 
 	memset(&cp, 0, sizeof(cp));
 
+	conn->prsp[0] = SMP_CMD_PAIRING_RSP;
+	memcpy(&conn->prsp[1], rp, sizeof(*rp));
+	skb_pull(skb, sizeof(*rp));
+
 	smp_send_cmd(conn, SMP_CMD_PAIRING_CONFIRM, sizeof(cp), &cp);
 }
 
@@ -271,6 +281,9 @@ static void smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	cp.resp_key_dist = 0x00;
 	cp.auth_req = rp->auth_req & (SMP_AUTH_BONDING | SMP_AUTH_MITM);
 
+	conn->preq[0] = SMP_CMD_PAIRING_REQ;
+	memcpy(&conn->preq[1], &cp, sizeof(cp));
+
 	smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
 }
 
@@ -307,6 +320,10 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 		cp.init_key_dist = 0x00;
 		cp.resp_key_dist = 0x00;
 		cp.auth_req = authreq;
+
+		conn->preq[0] = SMP_CMD_PAIRING_REQ;
+		memcpy(&conn->preq[1], &cp, sizeof(cp));
+
 		smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
 	} else {
 		struct smp_cmd_security_req cp;
-- 
1.7.4.1

