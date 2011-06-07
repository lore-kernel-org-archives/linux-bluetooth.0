Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [bluetooth-next v3 06/16] Bluetooth: Add SMP confirmation structs
Date: Tue,  7 Jun 2011 18:46:35 -0300
Message-Id: <1307483205-1518-7-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1307483205-1518-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1307483205-1518-1-git-send-email-vinicius.gomes@openbossa.org>
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
index 0529d27..36f5b0d 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -379,6 +379,11 @@ struct l2cap_conn {
 
 	__u8		disc_reason;
 
+	__u8		preq[7]; /* SMP Pairing Request */
+	__u8		prsp[7]; /* SMP Pairing Response */
+	__u8		prnd[16]; /* SMP Pairing Random */
+	__u8		pcnf[16]; /* SMP Pairing Confirm */
+
 	struct list_head chan_l;
 	rwlock_t	chan_lock;
 };
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 57fc7d0..fa22f4a 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -187,6 +187,8 @@ static void smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	BT_DBG("conn %p", conn);
 
+	conn->preq[0] = SMP_CMD_PAIRING_REQ;
+	memcpy(&conn->preq[1], rp, sizeof(*rp));
 	skb_pull(skb, sizeof(*rp));
 
 	rp->io_capability = 0x00;
@@ -196,17 +198,25 @@ static void smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
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
 
@@ -266,6 +276,9 @@ static void smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	cp.resp_key_dist = 0x00;
 	cp.auth_req = rp->auth_req & (SMP_AUTH_BONDING | SMP_AUTH_MITM);
 
+	conn->preq[0] = SMP_CMD_PAIRING_REQ;
+	memcpy(&conn->preq[1], &cp, sizeof(cp));
+
 	smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
 }
 
@@ -303,6 +316,10 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
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
1.7.5.4

