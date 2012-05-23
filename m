Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: Add L2CAP chan ready op
Date: Wed, 23 May 2012 13:57:31 +0300
Message-Id: <1337770651-9282-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Addings ops->ready() helps to separate socket and socketless
L2CAP channels.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/l2cap_core.c    |   42 +++++++++++------------------------------
 net/bluetooth/l2cap_sock.c    |   28 +++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 31 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 7ed13e7..d89d662 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -533,6 +533,7 @@ struct l2cap_ops {
 	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
 					       unsigned long len, int nb);
 	void			(*unlink) (struct l2cap_chan *chan, int err);
+	void			(*ready) (struct l2cap_chan *chan);
 };
 
 struct l2cap_conn {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d2b16b5..838083c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -427,7 +427,7 @@ struct l2cap_chan *l2cap_chan_create(void)
 
 	atomic_set(&chan->refcnt, 1);
 
-	/* This flag is cleared in l2cap_chan_ready() */
+	/* This flag is cleared in l2cap chan ops->ready() */
 	set_bit(CONF_NOT_COMPLETE, &chan->conf_state);
 
 	BT_DBG("chan %p", chan);
@@ -996,30 +996,6 @@ static void l2cap_send_conn_req(struct l2cap_chan *chan)
 	l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_REQ, sizeof(req), &req);
 }
 
-static void l2cap_chan_ready(struct l2cap_chan *chan)
-{
-	struct sock *sk = chan->sk;
-	struct sock *parent;
-
-	lock_sock(sk);
-
-	parent = bt_sk(sk)->parent;
-
-	BT_DBG("sk %p, parent %p", sk, parent);
-
-	/* This clears all conf flags, including CONF_NOT_COMPLETE */
-	chan->conf_state = 0;
-	__clear_chan_timer(chan);
-
-	__l2cap_state_change(chan, BT_CONNECTED);
-	sk->sk_state_change(sk);
-
-	if (parent)
-		parent->sk_data_ready(parent, 0);
-
-	release_sock(sk);
-}
-
 static void l2cap_choose_conn(struct l2cap_chan *chan)
 {
 	if (__amp_capable(chan)) {
@@ -1035,7 +1011,8 @@ static void l2cap_do_start(struct l2cap_chan *chan)
 	struct l2cap_conn *conn = chan->conn;
 
 	if (conn->hcon->type == LE_LINK) {
-		l2cap_chan_ready(chan);
+		if (chan->ops->ready)
+			chan->ops->ready(chan);
 		return;
 	}
 
@@ -1306,8 +1283,8 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 
 		if (conn->hcon->type == LE_LINK) {
 			if (smp_conn_security(conn, chan->sec_level))
-				l2cap_chan_ready(chan);
-
+				if (chan->ops->ready)
+					chan->ops->ready(chan);
 		} else if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
 			struct sock *sk = chan->sk;
 			__clear_chan_timer(chan);
@@ -3703,7 +3680,8 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 		if (err < 0)
 			l2cap_send_disconn_req(chan->conn, chan, -err);
 		else
-			l2cap_chan_ready(chan);
+			if (chan->ops->ready)
+				chan->ops->ready(chan);
 
 		goto unlock;
 	}
@@ -3834,7 +3812,8 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 		if (err < 0)
 			l2cap_send_disconn_req(chan->conn, chan, -err);
 		else
-			l2cap_chan_ready(chan);
+			if (chan->ops->ready)
+				chan->ops->ready(chan);
 	}
 
 done:
@@ -5489,7 +5468,8 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 		if (chan->scid == L2CAP_CID_LE_DATA) {
 			if (!status && encrypt) {
 				chan->sec_level = hcon->sec_level;
-				l2cap_chan_ready(chan);
+				if (chan->ops->ready)
+					chan->ops->ready(chan);
 			}
 
 			l2cap_chan_unlock(chan);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index d6f481b..5eb28a2 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -979,6 +979,33 @@ static void l2cap_sock_unlink_cb(struct l2cap_chan *chan, int err)
 	release_sock(sk);
 }
 
+static void l2cap_sock_chan_ready_cb(struct l2cap_chan *chan)
+{
+	struct sock *sk = chan->sk;
+	struct sock *parent;
+
+	lock_sock(sk);
+
+	parent = bt_sk(sk)->parent;
+
+	BT_DBG("sk %p, parent %p", sk, parent);
+
+	__clear_chan_timer(chan);
+
+	/* This clears all conf flags, including CONF_NOT_COMPLETE */
+	chan->conf_state = 0;
+
+	chan->state = BT_CONNECTED;
+	sk->sk_state = BT_CONNECTED;
+
+	sk->sk_state_change(sk);
+
+	if (parent)
+		parent->sk_data_ready(parent, 0);
+
+	release_sock(sk);
+}
+
 static struct l2cap_ops l2cap_chan_ops = {
 	.name		= "L2CAP Socket Interface",
 	.new_connection	= l2cap_sock_new_connection_cb,
@@ -987,6 +1014,7 @@ static struct l2cap_ops l2cap_chan_ops = {
 	.state_change	= l2cap_sock_state_change_cb,
 	.alloc_skb	= l2cap_sock_alloc_skb_cb,
 	.unlink		= l2cap_sock_unlink_cb,
+	.ready		= l2cap_sock_chan_ready_cb,
 };
 
 static void l2cap_sock_destruct(struct sock *sk)
-- 
1.7.9.5

