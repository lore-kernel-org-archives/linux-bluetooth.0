Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [RFC 1/2] Bluetooth: Create chan->ops->set_err()
Date: Thu, 24 May 2012 04:00:16 -0300
Message-Id: <1337842817-27865-1-git-send-email-gustavo@padovan.org>
In-Reply-To: <1337839374-20443-3-git-send-email-gustavo@padovan.org>
References: <1337839374-20443-3-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Remove more sk occurrences from l2cap_core by enabling
us to set sk_err via chan ops.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/l2cap_core.c    |   34 ++++++++++------------------------
 net/bluetooth/l2cap_sock.c    |   10 ++++++++++
 3 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 94e375a..e734572 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -532,6 +532,7 @@ struct l2cap_ops {
 					       unsigned long len, int nb);
 	void			(*ready) (void *data);
 	void			(*authorize) (void *data);
+	void			(*set_err) (void *data, int err);
 };
 
 struct l2cap_conn {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 314ce74..0d22695 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -192,22 +192,6 @@ static void l2cap_state_change(struct l2cap_chan *chan, int state)
 	release_sock(sk);
 }
 
-static inline void __l2cap_chan_set_err(struct l2cap_chan *chan, int err)
-{
-	struct sock *sk = chan->sk;
-
-	sk->sk_err = err;
-}
-
-static inline void l2cap_chan_set_err(struct l2cap_chan *chan, int err)
-{
-	struct sock *sk = chan->sk;
-
-	lock_sock(sk);
-	__l2cap_chan_set_err(chan, err);
-	release_sock(sk);
-}
-
 static void __set_retrans_timer(struct l2cap_chan *chan)
 {
 	if (!delayed_work_pending(&chan->monitor_timer) &&
@@ -989,7 +973,6 @@ static inline int l2cap_mode_supported(__u8 mode, __u32 feat_mask)
 
 static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *chan, int err)
 {
-	struct sock *sk = chan->sk;
 	struct l2cap_disconn_req req;
 
 	if (!conn)
@@ -1006,10 +989,9 @@ static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *c
 	l2cap_send_cmd(conn, l2cap_get_ident(conn),
 			L2CAP_DISCONN_REQ, sizeof(req), &req);
 
-	lock_sock(sk);
-	__l2cap_state_change(chan, BT_DISCONN);
-	__l2cap_chan_set_err(chan, err);
-	release_sock(sk);
+	l2cap_state_change(chan, BT_DISCONN);
+	if(chan->ops->set_err)
+		chan->ops->set_err(chan->data, err);
 }
 
 /* ---- L2CAP connections ---- */
@@ -1220,8 +1202,11 @@ static void l2cap_conn_unreliable(struct l2cap_conn *conn, int err)
 	mutex_lock(&conn->chan_lock);
 
 	list_for_each_entry(chan, &conn->chan_l, list) {
-		if (test_bit(FLAG_FORCE_RELIABLE, &chan->flags))
-			__l2cap_chan_set_err(chan, err);
+		if (!test_bit(FLAG_FORCE_RELIABLE, &chan->flags))
+			continue;
+
+		if(chan->ops->set_err)
+			chan->ops->set_err(chan->data, err);
 	}
 
 	mutex_unlock(&conn->chan_lock);
@@ -3682,7 +3667,8 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 		}
 
 	default:
-		l2cap_chan_set_err(chan, ECONNRESET);
+		if(chan->ops->set_err)
+			chan->ops->set_err(chan->data, err);
 
 		__set_chan_timer(chan, L2CAP_DISC_REJ_TIMEOUT);
 		l2cap_send_disconn_req(conn, chan, ECONNRESET);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index be3e934..0a1a827 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1067,6 +1067,15 @@ static void l2cap_sock_authorize_cb(void *data)
 		parent->sk_data_ready(parent, 0);
 }
 
+static void l2cap_sock_set_err_cb(void *data, int err)
+{
+	struct sock *sk = data;
+
+	lock_sock(sk);
+	sk->sk_err = err;
+	release_sock(sk);
+}
+
 static struct l2cap_ops l2cap_chan_ops = {
 	.name		= "L2CAP Socket Interface",
 	.new_connection	= l2cap_sock_new_connection_cb,
@@ -1077,6 +1086,7 @@ static struct l2cap_ops l2cap_chan_ops = {
 	.alloc_skb	= l2cap_sock_alloc_skb_cb,
 	.ready		= l2cap_sock_ready_cb,
 	.authorize	= l2cap_sock_authorize_cb,
+	.set_err	= l2cap_sock_set_err_cb,
 };
 
 static void l2cap_sock_destruct(struct sock *sk)
-- 
1.7.10.1

