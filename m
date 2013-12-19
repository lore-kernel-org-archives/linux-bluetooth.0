Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/6] emulator: Add psm handling to bthost
Date: Thu, 19 Dec 2013 10:30:01 +0100
Message-Id: <1387445406-20324-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Store psm of l2cap connections. We retrieve psm from
connection request frame.
---
 emulator/bthost.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index b05072a..430108e 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -79,6 +79,7 @@ struct btconn {
 struct l2conn {
 	uint16_t scid;
 	uint16_t dcid;
+	uint16_t psm;
 	struct l2conn *next;
 };
 
@@ -154,7 +155,8 @@ static struct btconn *bthost_find_conn(struct bthost *bthost, uint16_t handle)
 }
 
 static void bthost_add_l2cap_conn(struct bthost *bthost, struct btconn *conn,
-						uint16_t scid, uint16_t dcid)
+						uint16_t scid, uint16_t dcid,
+						uint16_t psm)
 {
 	struct l2conn *l2conn;
 
@@ -164,6 +166,7 @@ static void bthost_add_l2cap_conn(struct bthost *bthost, struct btconn *conn,
 
 	memset(l2conn, 0, sizeof(*l2conn));
 
+	l2conn->psm = psm;
 	l2conn->scid = scid;
 	l2conn->dcid = dcid;
 
@@ -376,6 +379,15 @@ bool bthost_l2cap_req(struct bthost *bthost, uint16_t handle, uint8_t code,
 	if (!conn)
 		return false;
 
+	if (code == BT_L2CAP_PDU_CONN_REQ &&
+			len == sizeof(struct bt_l2cap_pdu_conn_req)) {
+		const struct bt_l2cap_pdu_conn_req *req = data;
+
+		bthost_add_l2cap_conn(bthost, conn, le16_to_cpu(req->scid),
+							le16_to_cpu(req->scid),
+							le16_to_cpu(req->psm));
+	}
+
 	ident = l2cap_sig_send(bthost, conn, code, 0, data, len);
 	if (!ident)
 		return false;
@@ -737,7 +749,8 @@ static bool l2cap_conn_req(struct bthost *bthost, struct btconn *conn,
 		struct bt_l2cap_pdu_config_req conf_req;
 
 		bthost_add_l2cap_conn(bthost, conn, le16_to_cpu(rsp.dcid),
-							le16_to_cpu(rsp.scid));
+							le16_to_cpu(rsp.scid),
+							le16_to_cpu(psm));
 
 		memset(&conf_req, 0, sizeof(conf_req));
 		conf_req.dcid = rsp.dcid;
@@ -753,12 +766,16 @@ static bool l2cap_conn_rsp(struct bthost *bthost, struct btconn *conn,
 				uint8_t ident, const void *data, uint16_t len)
 {
 	const struct bt_l2cap_pdu_conn_rsp *rsp = data;
+	struct l2conn *l2conn;
 
 	if (len < sizeof(*rsp))
 		return false;
 
-	bthost_add_l2cap_conn(bthost, conn, le16_to_cpu(rsp->scid),
-						le16_to_cpu(rsp->dcid));
+	l2conn = btconn_find_l2cap_conn_by_scid(conn, le16_to_cpu(rsp->scid));
+	if (l2conn)
+		l2conn->dcid = le16_to_cpu(rsp->dcid);
+	else
+		return false;
 
 	if (le16_to_cpu(rsp->result) == 0x0001) {
 		struct bt_l2cap_pdu_config_req req;
@@ -1013,8 +1030,8 @@ static bool l2cap_le_conn_rsp(struct bthost *bthost, struct btconn *conn,
 
 	if (len < sizeof(*rsp))
 		return false;
-
-	bthost_add_l2cap_conn(bthost, conn, 0, le16_to_cpu(rsp->dcid));
+	/* TODO add l2cap connection before with proper psm */
+	bthost_add_l2cap_conn(bthost, conn, 0, le16_to_cpu(rsp->dcid), 0);
 
 	return true;
 }
-- 
1.8.3.1

