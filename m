Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv4 05/16] Bluetooth: Add locked and unlocked state_change
Date: Fri, 10 Feb 2012 15:55:02 +0200
Message-Id: <1328882113-19810-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1328882113-19810-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328882113-19810-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Split to locked and unlocked versions of l2cap_state_change helping
to remove socket locks from l2cap code.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_core.c |   41 +++++++++++++++++++++++++----------------
 1 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9cb8f48..5120a1c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -225,7 +225,7 @@ static char *state_to_string(int state)
 	return "invalid state";
 }
 
-static void l2cap_state_change(struct l2cap_chan *chan, int state)
+static void __l2cap_state_change(struct l2cap_chan *chan, int state)
 {
 	BT_DBG("%p %s -> %s", chan, state_to_string(chan->state),
 						state_to_string(state));
@@ -234,6 +234,15 @@ static void l2cap_state_change(struct l2cap_chan *chan, int state)
 	chan->ops->state_change(chan->data, state);
 }
 
+static void l2cap_state_change(struct l2cap_chan *chan, int state)
+{
+	struct sock *sk = chan->sk;
+
+	lock_sock(sk);
+	__l2cap_state_change(chan, state);
+	release_sock(sk);
+}
+
 static void l2cap_chan_timeout(struct work_struct *work)
 {
 	struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
@@ -370,7 +379,7 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 		hci_conn_put(conn->hcon);
 	}
 
-	l2cap_state_change(chan, BT_CLOSED);
+	__l2cap_state_change(chan, BT_CLOSED);
 	sock_set_flag(sk, SOCK_ZAPPED);
 
 	if (err)
@@ -434,7 +443,7 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 	case BT_LISTEN:
 		l2cap_chan_cleanup_listen(sk);
 
-		l2cap_state_change(chan, BT_CLOSED);
+		__l2cap_state_change(chan, BT_CLOSED);
 		sock_set_flag(sk, SOCK_ZAPPED);
 		break;
 
@@ -725,7 +734,7 @@ static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *c
 	l2cap_send_cmd(conn, l2cap_get_ident(conn),
 			L2CAP_DISCONN_REQ, sizeof(req), &req);
 
-	l2cap_state_change(chan, BT_DISCONN);
+	__l2cap_state_change(chan, BT_DISCONN);
 	sk->sk_err = err;
 }
 
@@ -791,7 +800,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 						parent->sk_data_ready(parent, 0);
 
 				} else {
-					l2cap_state_change(chan, BT_CONFIG);
+					__l2cap_state_change(chan, BT_CONFIG);
 					rsp.result = cpu_to_le16(L2CAP_CR_SUCCESS);
 					rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);
 				}
@@ -894,7 +903,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 
 	__set_chan_timer(chan, sk->sk_sndtimeo);
 
-	l2cap_state_change(chan, BT_CONNECTED);
+	__l2cap_state_change(chan, BT_CONNECTED);
 	parent->sk_data_ready(parent, 0);
 
 clean:
@@ -911,7 +920,7 @@ static void l2cap_chan_ready(struct l2cap_chan *chan)
 	chan->conf_state = 0;
 	__clear_chan_timer(chan);
 
-	l2cap_state_change(chan, BT_CONNECTED);
+	__l2cap_state_change(chan, BT_CONNECTED);
 	sk->sk_state_change(sk);
 
 	if (parent)
@@ -943,7 +952,7 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 
 		} else if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
 			__clear_chan_timer(chan);
-			l2cap_state_change(chan, BT_CONNECTED);
+			__l2cap_state_change(chan, BT_CONNECTED);
 			sk->sk_state_change(sk);
 
 		} else if (chan->state == BT_CONNECT)
@@ -1217,14 +1226,14 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid, bdaddr_t *d
 
 	l2cap_chan_add(conn, chan);
 
-	l2cap_state_change(chan, BT_CONNECT);
+	__l2cap_state_change(chan, BT_CONNECT);
 	__set_chan_timer(chan, sk->sk_sndtimeo);
 
 	if (hcon->state == BT_CONNECTED) {
 		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
 			__clear_chan_timer(chan);
 			if (l2cap_chan_check_security(chan))
-				l2cap_state_change(chan, BT_CONNECTED);
+				__l2cap_state_change(chan, BT_CONNECTED);
 		} else
 			l2cap_do_start(chan);
 	}
@@ -2668,22 +2677,22 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE) {
 		if (l2cap_chan_check_security(chan)) {
 			if (bt_sk(sk)->defer_setup) {
-				l2cap_state_change(chan, BT_CONNECT2);
+				__l2cap_state_change(chan, BT_CONNECT2);
 				result = L2CAP_CR_PEND;
 				status = L2CAP_CS_AUTHOR_PEND;
 				parent->sk_data_ready(parent, 0);
 			} else {
-				l2cap_state_change(chan, BT_CONFIG);
+				__l2cap_state_change(chan, BT_CONFIG);
 				result = L2CAP_CR_SUCCESS;
 				status = L2CAP_CS_NO_INFO;
 			}
 		} else {
-			l2cap_state_change(chan, BT_CONNECT2);
+			__l2cap_state_change(chan, BT_CONNECT2);
 			result = L2CAP_CR_PEND;
 			status = L2CAP_CS_AUTHEN_PEND;
 		}
 	} else {
-		l2cap_state_change(chan, BT_CONNECT2);
+		__l2cap_state_change(chan, BT_CONNECT2);
 		result = L2CAP_CR_PEND;
 		status = L2CAP_CS_NO_INFO;
 	}
@@ -4574,12 +4583,12 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 					if (parent)
 						parent->sk_data_ready(parent, 0);
 				} else {
-					l2cap_state_change(chan, BT_CONFIG);
+					__l2cap_state_change(chan, BT_CONFIG);
 					res = L2CAP_CR_SUCCESS;
 					stat = L2CAP_CS_NO_INFO;
 				}
 			} else {
-				l2cap_state_change(chan, BT_DISCONN);
+				__l2cap_state_change(chan, BT_DISCONN);
 				__set_chan_timer(chan,
 					msecs_to_jiffies(L2CAP_DISC_TIMEOUT));
 				res = L2CAP_CR_SEC_BLOCK;
-- 
1.7.8.3

