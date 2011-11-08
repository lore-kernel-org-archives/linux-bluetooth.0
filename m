Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH -v2 1/2] Bluetooth: Rename l2cap_check_security()
Date: Tue,  8 Nov 2011 19:11:25 -0200
Message-Id: <1320786686-1599-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

rename to l2cap_chan_check_security() to make it consistent with other
l2cap_exported functions. This function will be exported in a later
commit.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/l2cap_core.c    |   12 ++++++------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index fdb2b78..5ff38e9 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -810,5 +810,6 @@ int l2cap_chan_connect(struct l2cap_chan *chan);
 int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 								u32 priority);
 void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
+int l2cap_chan_check_security(struct l2cap_chan *chan);
 
 #endif /* __L2CAP_H */
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 1200814..6a5c1b2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -516,7 +516,7 @@ static inline u8 l2cap_get_auth_type(struct l2cap_chan *chan)
 }
 
 /* Service level security */
-static inline int l2cap_check_security(struct l2cap_chan *chan)
+int l2cap_chan_check_security(struct l2cap_chan *chan)
 {
 	struct l2cap_conn *conn = chan->conn;
 	__u8 auth_type;
@@ -662,7 +662,7 @@ static void l2cap_do_start(struct l2cap_chan *chan)
 		if (!(conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE))
 			return;
 
-		if (l2cap_check_security(chan) &&
+		if (l2cap_chan_check_security(chan) &&
 				__l2cap_no_conn_pending(chan)) {
 			struct l2cap_conn_req req;
 			req.scid = cpu_to_le16(chan->scid);
@@ -752,7 +752,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 		if (chan->state == BT_CONNECT) {
 			struct l2cap_conn_req req;
 
-			if (!l2cap_check_security(chan) ||
+			if (!l2cap_chan_check_security(chan) ||
 					!__l2cap_no_conn_pending(chan)) {
 				bh_unlock_sock(sk);
 				continue;
@@ -785,7 +785,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 			rsp.scid = cpu_to_le16(chan->dcid);
 			rsp.dcid = cpu_to_le16(chan->scid);
 
-			if (l2cap_check_security(chan)) {
+			if (l2cap_chan_check_security(chan)) {
 				if (bt_sk(sk)->defer_setup) {
 					struct sock *parent = bt_sk(sk)->parent;
 					rsp.result = cpu_to_le16(L2CAP_CR_PEND);
@@ -1179,7 +1179,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan)
 	if (hcon->state == BT_CONNECTED) {
 		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
 			__clear_chan_timer(chan);
-			if (l2cap_check_security(chan))
+			if (l2cap_chan_check_security(chan))
 				l2cap_state_change(chan, BT_CONNECTED);
 		} else
 			l2cap_do_start(chan);
@@ -2580,7 +2580,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	chan->ident = cmd->ident;
 
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE) {
-		if (l2cap_check_security(chan)) {
+		if (l2cap_chan_check_security(chan)) {
 			if (bt_sk(sk)->defer_setup) {
 				l2cap_state_change(chan, BT_CONNECT2);
 				result = L2CAP_CR_PEND;
-- 
1.7.6.4

