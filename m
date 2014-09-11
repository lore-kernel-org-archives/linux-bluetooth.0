Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/6] Bluetooth: Fix L2CAP information request handling for fixed channels
Date: Wed, 10 Sep 2014 17:37:46 -0700
Message-Id: <1410395866-24301-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1410395866-24301-1-git-send-email-johan.hedberg@gmail.com>
References: <1410395866-24301-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Even if we have no connection-oriented channels we should perform the
L2CAP Information Request procedures before notifying L2CAP channels of
the connection. This is so that the L2CAP channel implementations can
perform checks on what the remote side supports (e.g. does it support
the fixed channel in question).

So far the code has relied on the l2cap_do_start() function to initiate
the Information Request, however l2cap_do_start() is used on a
per-channel basis and only for connection-oriented channels. This means
that if there are no connection-oriented channels on the system we would
never start the Information Request procedure.

This patch creates a new l2cap_request_info() helper function to
initiate the Information Request procedure, and ensures that it is
called whenever a BR/EDR connection has been established. The patch also
updates fixed channels to be notified of connection readiness only once
the Information Request procedure has completed.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 53 +++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b71430caab4a..8d53fc57faba 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1283,6 +1283,24 @@ static void l2cap_start_connection(struct l2cap_chan *chan)
 	}
 }
 
+static void l2cap_request_info(struct l2cap_conn *conn)
+{
+	struct l2cap_info_req req;
+
+	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
+		return;
+
+	req.type = cpu_to_le16(L2CAP_IT_FEAT_MASK);
+
+	conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_SENT;
+	conn->info_ident = l2cap_get_ident(conn);
+
+	schedule_delayed_work(&conn->info_timer, L2CAP_INFO_TIMEOUT);
+
+	l2cap_send_cmd(conn, conn->info_ident, L2CAP_INFO_REQ,
+		       sizeof(req), &req);
+}
+
 static void l2cap_do_start(struct l2cap_chan *chan)
 {
 	struct l2cap_conn *conn = chan->conn;
@@ -1292,26 +1310,17 @@ static void l2cap_do_start(struct l2cap_chan *chan)
 		return;
 	}
 
-	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT) {
-		if (!(conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE))
-			return;
-
-		if (l2cap_chan_check_security(chan, true) &&
-		    __l2cap_no_conn_pending(chan)) {
-			l2cap_start_connection(chan);
-		}
-	} else {
-		struct l2cap_info_req req;
-		req.type = cpu_to_le16(L2CAP_IT_FEAT_MASK);
-
-		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_SENT;
-		conn->info_ident = l2cap_get_ident(conn);
+	if (!(conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)) {
+		l2cap_request_info(conn);
+		return;
+	}
 
-		schedule_delayed_work(&conn->info_timer, L2CAP_INFO_TIMEOUT);
+	if (!(conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE))
+		return;
 
-		l2cap_send_cmd(conn, conn->info_ident, L2CAP_INFO_REQ,
-			       sizeof(req), &req);
-	}
+	if (l2cap_chan_check_security(chan, true) &&
+	    __l2cap_no_conn_pending(chan))
+		l2cap_start_connection(chan);
 }
 
 static inline int l2cap_mode_supported(__u8 mode, __u32 feat_mask)
@@ -1370,6 +1379,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 		l2cap_chan_lock(chan);
 
 		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
+			l2cap_chan_ready(chan);
 			l2cap_chan_unlock(chan);
 			continue;
 		}
@@ -1474,6 +1484,9 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 
 	BT_DBG("conn %p", conn);
 
+	if (hcon->type == ACL_LINK)
+		l2cap_request_info(conn);
+
 	mutex_lock(&conn->chan_lock);
 
 	list_for_each_entry(chan, &conn->chan_l, list) {
@@ -1488,8 +1501,8 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 		if (hcon->type == LE_LINK) {
 			l2cap_le_start(chan);
 		} else if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
-			l2cap_chan_ready(chan);
-
+			if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE)
+				l2cap_chan_ready(chan);
 		} else if (chan->state == BT_CONNECT) {
 			l2cap_do_start(chan);
 		}
-- 
1.9.3

