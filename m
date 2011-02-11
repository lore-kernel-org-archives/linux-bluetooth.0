Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [bluetooth-next -v2 15/24] Bluetooth: Add SMP confirmation structs
Date: Thu, 10 Feb 2011 22:39:00 -0300
Message-Id: <1297388349-14878-16-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1297388349-14878-15-git-send-email-vinicius.gomes@openbossa.org>
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
 <1297388349-14878-13-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-14-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-15-git-send-email-vinicius.gomes@openbossa.org>
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
index 031e9cd..ceea46d 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -290,6 +290,11 @@ struct l2cap_conn {
 
 	__u8		disc_reason;
 
+	__u8		preq[7];
+	__u8		pres[7];
+	__u8		prnd[16];
+	__u8		pcnf[16];
+
 	struct l2cap_chan_list chan_list;
 };
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 80a3c7e..256eeef 100644
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
 	rp->auth_req &= 0x05;
 
+	conn->pres[0] = SMP_CMD_PAIRING_RSP;
+	memcpy(&conn->pres[1], rp, sizeof(*rp));
+
 	smp_send_cmd(conn, SMP_CMD_PAIRING_RSP, sizeof(*rp), rp);
 }
 
 static void smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 {
+	struct smp_cmd_pairing *rp = (void *) skb->data;
 	struct smp_cmd_pairing_confirm cp;
 
 	BT_DBG("conn %p", conn);
 
 	memset(&cp, 0, sizeof(cp));
 
+	conn->pres[0] = SMP_CMD_PAIRING_RSP;
+	memcpy(&conn->pres[1], rp, sizeof(*rp));
+	skb_pull(skb, sizeof(*rp));
+
 	smp_send_cmd(conn, SMP_CMD_PAIRING_CONFIRM, sizeof(cp), &cp);
 }
 
@@ -270,6 +280,9 @@ static void smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	cp.resp_key_dist = 0x00;
 	cp.auth_req = rp->auth_req & 0x05;
 
+	conn->preq[0] = SMP_CMD_PAIRING_REQ;
+	memcpy(&conn->preq[1], &cp, sizeof(cp));
+
 	smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
 }
 
@@ -306,6 +319,10 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
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
1.7.4

