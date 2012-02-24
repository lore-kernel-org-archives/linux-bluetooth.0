Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: Remove duplicated code in l2cap conn req
Date: Fri, 24 Feb 2012 16:00:00 +0200
Message-Id: <1330092000-9420-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

The same sequence sending L2CAP Connection Request was
used in several places. Using subroutine makes those
places easy to read.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   49 +++++++++++++++++--------------------------
 1 files changed, 19 insertions(+), 30 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5f4cfea..e9fadce 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -667,6 +667,21 @@ static inline int __l2cap_no_conn_pending(struct l2cap_chan *chan)
 	return !test_bit(CONF_CONNECT_PEND, &chan->conf_state);
 }
 
+static void l2cap_send_conn_req(struct l2cap_chan *chan)
+{
+	struct l2cap_conn *conn = chan->conn;
+	struct l2cap_conn_req req;
+
+	req.scid = cpu_to_le16(chan->scid);
+	req.psm  = chan->psm;
+
+	chan->ident = l2cap_get_ident(conn);
+
+	set_bit(CONF_CONNECT_PEND, &chan->conf_state);
+
+	l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_REQ, sizeof(req), &req);
+}
+
 static void l2cap_do_start(struct l2cap_chan *chan)
 {
 	struct l2cap_conn *conn = chan->conn;
@@ -676,17 +691,8 @@ static void l2cap_do_start(struct l2cap_chan *chan)
 			return;
 
 		if (l2cap_chan_check_security(chan) &&
-				__l2cap_no_conn_pending(chan)) {
-			struct l2cap_conn_req req;
-			req.scid = cpu_to_le16(chan->scid);
-			req.psm  = chan->psm;
-
-			chan->ident = l2cap_get_ident(conn);
-			set_bit(CONF_CONNECT_PEND, &chan->conf_state);
-
-			l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_REQ,
-							sizeof(req), &req);
-		}
+				__l2cap_no_conn_pending(chan))
+			l2cap_send_conn_req(chan);
 	} else {
 		struct l2cap_info_req req;
 		req.type = cpu_to_le16(L2CAP_IT_FEAT_MASK);
@@ -763,8 +769,6 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 		}
 
 		if (chan->state == BT_CONNECT) {
-			struct l2cap_conn_req req;
-
 			if (!l2cap_chan_check_security(chan) ||
 					!__l2cap_no_conn_pending(chan)) {
 				l2cap_chan_unlock(chan);
@@ -779,14 +783,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 				continue;
 			}
 
-			req.scid = cpu_to_le16(chan->scid);
-			req.psm  = chan->psm;
-
-			chan->ident = l2cap_get_ident(conn);
-			set_bit(CONF_CONNECT_PEND, &chan->conf_state);
-
-			l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_REQ,
-							sizeof(req), &req);
+			l2cap_send_conn_req(chan);
 
 		} else if (chan->state == BT_CONNECT2) {
 			struct l2cap_conn_rsp rsp;
@@ -4609,15 +4606,7 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 
 		if (chan->state == BT_CONNECT) {
 			if (!status) {
-				struct l2cap_conn_req req;
-				req.scid = cpu_to_le16(chan->scid);
-				req.psm  = chan->psm;
-
-				chan->ident = l2cap_get_ident(conn);
-				set_bit(CONF_CONNECT_PEND, &chan->conf_state);
-
-				l2cap_send_cmd(conn, chan->ident,
-					L2CAP_CONN_REQ, sizeof(req), &req);
+				l2cap_send_conn_req(chan);
 			} else {
 				__clear_chan_timer(chan);
 				__set_chan_timer(chan,
-- 
1.7.9

