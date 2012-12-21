Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [RFC -v2 10/16] Bluetooth: Remove socket lock from state_change() in l2cap_core
Date: Fri, 21 Dec 2012 16:10:53 -0200
Message-Id: <1356113459-7932-11-git-send-email-gustavo@padovan.org>
In-Reply-To: <1356113459-7932-1-git-send-email-gustavo@padovan.org>
References: <1356113459-7932-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

This simplifies a lot the state change handling inside l2cap_core.c,
we got rid of __l2cap_state_change() and l2cap_state_change() doesn't lock
the socket anymore, instead the socket is locked inside the ops user code
in l2cap_sock.c.

In some places we were not using the locked version, and now we are using
it. There is no side effect in locking the socket in these places.

Handle the operation of lock the socket to ops user benefit A2MP, since
there is no socket lock there it doesn't need any special function in
l2cap work without touching socket locks.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/l2cap_core.c | 32 +++++++-------------------------
 net/bluetooth/l2cap_sock.c |  4 ++++
 2 files changed, 11 insertions(+), 25 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 110a702..2c4458a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -210,7 +210,7 @@ static u16 l2cap_alloc_cid(struct l2cap_conn *conn)
 	return 0;
 }
 
-static void __l2cap_state_change(struct l2cap_chan *chan, int state)
+static void l2cap_state_change(struct l2cap_chan *chan, int state)
 {
 	BT_DBG("chan %p %s -> %s", chan, state_to_string(chan->state),
 	       state_to_string(state));
@@ -219,33 +219,16 @@ static void __l2cap_state_change(struct l2cap_chan *chan, int state)
 	chan->ops->state_change(chan, state, 0);
 }
 
-static void l2cap_state_change(struct l2cap_chan *chan, int state)
-{
-	struct sock *sk = chan->sk;
-
-	lock_sock(sk);
-	__l2cap_state_change(chan, state);
-	release_sock(sk);
-}
-
 static void l2cap_state_change_and_error(struct l2cap_chan *chan, int state,
 					 int err)
 {
-	struct sock *sk = chan->sk;
-
-	lock_sock(sk);
 	chan->state = state;
 	chan->ops->state_change(chan, state, err);
-	release_sock(sk);
 }
 
 static inline void l2cap_chan_set_err(struct l2cap_chan *chan, int err)
 {
-	struct sock *sk = chan->sk;
-
-	lock_sock(sk);
 	chan->ops->state_change(chan, chan->state, err);
-	release_sock(sk);
 }
 
 static void __set_retrans_timer(struct l2cap_chan *chan)
@@ -1219,7 +1202,6 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 	mutex_lock(&conn->chan_lock);
 
 	list_for_each_entry_safe(chan, tmp, &conn->chan_l, list) {
-		struct sock *sk = chan->sk;
 
 		l2cap_chan_lock(chan);
 
@@ -3639,7 +3621,7 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE) {
 		if (l2cap_chan_check_security(chan)) {
 			if (test_bit(CONN_DEFER_SETUP, &chan->conn_state)) {
-				__l2cap_state_change(chan, BT_CONNECT2);
+				l2cap_state_change(chan, BT_CONNECT2);
 				result = L2CAP_CR_PEND;
 				status = L2CAP_CS_AUTHOR_PEND;
 				chan->ops->defer(chan);
@@ -3649,21 +3631,21 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 				 * physical link is up.
 				 */
 				if (amp_id) {
-					__l2cap_state_change(chan, BT_CONNECT2);
+					l2cap_state_change(chan, BT_CONNECT2);
 					result = L2CAP_CR_PEND;
 				} else {
-					__l2cap_state_change(chan, BT_CONFIG);
+					l2cap_state_change(chan, BT_CONFIG);
 					result = L2CAP_CR_SUCCESS;
 				}
 				status = L2CAP_CS_NO_INFO;
 			}
 		} else {
-			__l2cap_state_change(chan, BT_CONNECT2);
+			l2cap_state_change(chan, BT_CONNECT2);
 			result = L2CAP_CR_PEND;
 			status = L2CAP_CS_AUTHEN_PEND;
 		}
 	} else {
-		__l2cap_state_change(chan, BT_CONNECT2);
+		l2cap_state_change(chan, BT_CONNECT2);
 		result = L2CAP_CR_PEND;
 		status = L2CAP_CS_NO_INFO;
 	}
@@ -4542,7 +4524,7 @@ static void l2cap_do_create(struct l2cap_chan *chan, int result,
 			       sizeof(rsp), &rsp);
 
 		if (result == L2CAP_CR_SUCCESS) {
-			__l2cap_state_change(chan, BT_CONFIG);
+			l2cap_state_change(chan, BT_CONFIG);
 			set_bit(CONF_REQ_SENT, &chan->conf_state);
 			l2cap_send_cmd(chan->conn, l2cap_get_ident(chan->conn),
 				       L2CAP_CONF_REQ,
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 6a95d37..cf8f187 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1052,10 +1052,14 @@ static void l2cap_sock_state_change_cb(struct l2cap_chan *chan, int state,
 {
 	struct sock *sk = chan->data;
 
+	lock_sock(sk);
+
 	sk->sk_state = state;
 
 	if (err)
 		sk->sk_err = err;
+
+	release_sock(sk);
 }
 
 static struct sk_buff *l2cap_sock_alloc_skb_cb(struct l2cap_chan *chan,
-- 
1.8.0.2

