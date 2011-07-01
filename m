Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 05/12] Bluetooth: Fix SM pairing parameters negotiation
Date: Fri,  1 Jul 2011 16:07:40 -0300
Message-Id: <1309547267-9514-6-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1309547267-9514-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1309547267-9514-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Before implementing SM key distribution, the pairing features
exchange must be better negotiated, taking into account some
features of the host and connection requirements.

If we are in the "not pairable" state, it makes no sense to
exchange any key. This allows for simplification of the key
negociation method.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/smp.c |   40 ++++++++++++++++++++++++++++++----------
 1 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 1863c574..c7a0cbe 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -197,14 +197,34 @@ static __u8 seclevel_to_authreq(__u8 level)
 }
 
 static void build_pairing_cmd(struct l2cap_conn *conn,
-				struct smp_cmd_pairing *cmd, __u8 authreq)
+				struct smp_cmd_pairing *req,
+				struct smp_cmd_pairing *rsp,
+				__u8 authreq)
 {
-	cmd->io_capability = conn->hcon->io_capability;
-	cmd->oob_flag = SMP_OOB_NOT_PRESENT;
-	cmd->max_key_size = SMP_MAX_ENC_KEY_SIZE;
-	cmd->init_key_dist = SMP_DIST_ENC_KEY | SMP_DIST_ID_KEY | SMP_DIST_SIGN;
-	cmd->resp_key_dist = SMP_DIST_ENC_KEY | SMP_DIST_ID_KEY | SMP_DIST_SIGN;
-	cmd->auth_req = authreq;
+	u8 dist_keys;
+
+	dist_keys = 0;
+	if (test_bit(HCI_PAIRABLE, &conn->hcon->hdev->flags)) {
+		dist_keys = SMP_DIST_ENC_KEY | SMP_DIST_ID_KEY | SMP_DIST_SIGN;
+		authreq |= SMP_AUTH_BONDING;
+	}
+
+	if (rsp == NULL) {
+		req->io_capability = conn->hcon->io_capability;
+		req->oob_flag = SMP_OOB_NOT_PRESENT;
+		req->max_key_size = SMP_MAX_ENC_KEY_SIZE;
+		req->init_key_dist = dist_keys;
+		req->resp_key_dist = dist_keys;
+		req->auth_req = authreq;
+		return;
+	}
+
+	rsp->io_capability = conn->hcon->io_capability;
+	rsp->oob_flag = SMP_OOB_NOT_PRESENT;
+	rsp->max_key_size = SMP_MAX_ENC_KEY_SIZE;
+	rsp->init_key_dist = req->init_key_dist & dist_keys;
+	rsp->resp_key_dist = req->resp_key_dist & dist_keys;
+	rsp->auth_req = authreq;
 }
 
 static u8 check_enc_key_size(struct l2cap_conn *conn, __u8 max_key_size)
@@ -233,7 +253,7 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 		return SMP_OOB_NOT_AVAIL;
 
 	/* We didn't start the pairing, so no requirements */
-	build_pairing_cmd(conn, &rsp, SMP_AUTH_NONE);
+	build_pairing_cmd(conn, req, &rsp, SMP_AUTH_NONE);
 
 	key_size = min(req->max_key_size, rsp.max_key_size);
 	if (check_enc_key_size(conn, key_size))
@@ -412,7 +432,7 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	skb_pull(skb, sizeof(*rp));
 
 	memset(&cp, 0, sizeof(cp));
-	build_pairing_cmd(conn, &cp, rp->auth_req);
+	build_pairing_cmd(conn, &cp, NULL, rp->auth_req);
 
 	conn->preq[0] = SMP_CMD_PAIRING_REQ;
 	memcpy(&conn->preq[1], &cp, sizeof(cp));
@@ -451,7 +471,7 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 	if (hcon->link_mode & HCI_LM_MASTER) {
 		struct smp_cmd_pairing cp;
 
-		build_pairing_cmd(conn, &cp, authreq);
+		build_pairing_cmd(conn, &cp, NULL, authreq);
 		conn->preq[0] = SMP_CMD_PAIRING_REQ;
 		memcpy(&conn->preq[1], &cp, sizeof(cp));
 
-- 
1.7.6

