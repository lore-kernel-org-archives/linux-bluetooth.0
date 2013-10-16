Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 3/7] Bluetooth: Remove socket lock from l2cap_state_change()
Date: Wed, 16 Oct 2013 16:08:31 -0300
Message-Id: <1381950515-25256-3-git-send-email-gustavo@padovan.org>
In-Reply-To: <1381950515-25256-1-git-send-email-gustavo@padovan.org>
References: <1381950515-25256-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

This simplify and make safer the state change handling inside l2cap_core.c.
we got rid of __l2cap_state_change(). And l2cap_state_change() doesn't lock
the socket anymore, instead the socket is locked inside the ops callback for
state change in l2cap_sock.c.

It makes the code safer because in some we were using a unlocked version,
and now we are calls to l2cap_state_change(), when dealing with sockets, use
the locked version.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/l2cap_core.c | 31 +++++++------------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 95e78ca..8c757c0 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -223,7 +223,7 @@ static u16 l2cap_alloc_cid(struct l2cap_conn *conn)
 	return 0;
 }
 
-static void __l2cap_state_change(struct l2cap_chan *chan, int state)
+static void l2cap_state_change(struct l2cap_chan *chan, int state)
 {
 	BT_DBG("chan %p %s -> %s", chan, state_to_string(chan->state),
 	       state_to_string(state));
@@ -232,33 +232,16 @@ static void __l2cap_state_change(struct l2cap_chan *chan, int state)
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
 static inline void l2cap_state_change_and_error(struct l2cap_chan *chan,
 						int state, int err)
 {
-	struct sock *sk = chan->sk;
-
-	lock_sock(sk);
 	chan->state = state;
 	chan->ops->state_change(chan, chan->state, err);
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
@@ -3779,7 +3762,7 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE) {
 		if (l2cap_chan_check_security(chan)) {
 			if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
-				__l2cap_state_change(chan, BT_CONNECT2);
+				l2cap_state_change(chan, BT_CONNECT2);
 				result = L2CAP_CR_PEND;
 				status = L2CAP_CS_AUTHOR_PEND;
 				chan->ops->defer(chan);
@@ -3789,21 +3772,21 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 				 * physical link is up.
 				 */
 				if (amp_id == AMP_ID_BREDR) {
-					__l2cap_state_change(chan, BT_CONFIG);
+					l2cap_state_change(chan, BT_CONFIG);
 					result = L2CAP_CR_SUCCESS;
 				} else {
-					__l2cap_state_change(chan, BT_CONNECT2);
+					l2cap_state_change(chan, BT_CONNECT2);
 					result = L2CAP_CR_PEND;
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
@@ -4730,7 +4713,7 @@ static void l2cap_do_create(struct l2cap_chan *chan, int result,
 			       sizeof(rsp), &rsp);
 
 		if (result == L2CAP_CR_SUCCESS) {
-			__l2cap_state_change(chan, BT_CONFIG);
+			l2cap_state_change(chan, BT_CONFIG);
 			set_bit(CONF_REQ_SENT, &chan->conf_state);
 			l2cap_send_cmd(chan->conn, l2cap_get_ident(chan->conn),
 				       L2CAP_CONF_REQ,
-- 
1.8.3.1

