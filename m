Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/6] Bluetooth: add close() callback to l2cap_chan_ops
Date: Thu,  2 Jun 2011 13:15:26 -0300
Message-Id: <1307031329-8001-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1307031329-8001-2-git-send-email-padovan@profusion.mobi>
References: <1307031329-8001-1-git-send-email-padovan@profusion.mobi>
 <1307031329-8001-2-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

close() calls l2cap_sock_kill() on l2cap_sock.c

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    3 +--
 net/bluetooth/l2cap_core.c    |   17 +++++++++--------
 net/bluetooth/l2cap_sock.c    |   10 +++++++++-
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index e625f09..af2f171 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -363,6 +363,7 @@ struct l2cap_ops {
 
 	struct l2cap_chan	*(*new_connection) (void *data);
 	int			(*recv) (void *data, struct sk_buff *skb);
+	void			(*close) (void *data);
 };
 
 struct l2cap_conn {
@@ -468,8 +469,6 @@ int __l2cap_wait_ack(struct sock *sk);
 int l2cap_add_psm(struct l2cap_chan *chan, bdaddr_t *src, __le16 psm);
 int l2cap_add_scid(struct l2cap_chan *chan,  __u16 scid);
 
-void l2cap_sock_kill(struct sock *sk);
-
 struct l2cap_chan *l2cap_chan_create(struct sock *sk);
 void l2cap_chan_close(struct l2cap_chan *chan, int reason);
 void l2cap_chan_destroy(struct l2cap_chan *chan);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b5327f3..c645e03 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -254,7 +254,7 @@ static void l2cap_chan_timeout(unsigned long arg)
 
 	bh_unlock_sock(sk);
 
-	l2cap_sock_kill(sk);
+	chan->ops->close(chan->ops->data);
 	sock_put(sk);
 }
 
@@ -391,11 +391,12 @@ static void l2cap_chan_cleanup_listen(struct sock *parent)
 
 	/* Close not yet accepted channels */
 	while ((sk = bt_accept_dequeue(parent, NULL))) {
-		l2cap_chan_clear_timer(l2cap_pi(sk)->chan);
+		struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+		l2cap_chan_clear_timer(chan);
 		lock_sock(sk);
-		l2cap_chan_close(l2cap_pi(sk)->chan, ECONNRESET);
+		l2cap_chan_close(chan, ECONNRESET);
 		release_sock(sk);
-		l2cap_sock_kill(sk);
+		chan->ops->close(chan->ops->data);
 	}
 
 	parent->sk_state = BT_CLOSED;
@@ -988,7 +989,7 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 		bh_lock_sock(sk);
 		l2cap_chan_del(chan, err);
 		bh_unlock_sock(sk);
-		l2cap_sock_kill(sk);
+		chan->ops->close(chan->ops->data);
 	}
 
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
@@ -2333,7 +2334,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	if (__l2cap_get_chan_by_dcid(conn, scid)) {
 		write_unlock_bh(&conn->chan_lock);
 		sock_set_flag(sk, SOCK_ZAPPED);
-		l2cap_sock_kill(sk);
+		chan->ops->close(chan->ops->data);
 		goto response;
 	}
 
@@ -2706,7 +2707,7 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
 	l2cap_chan_del(chan, ECONNRESET);
 	bh_unlock_sock(sk);
 
-	l2cap_sock_kill(sk);
+	chan->ops->close(chan->ops->data);
 	return 0;
 }
 
@@ -2740,7 +2741,7 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn, struct l2cap_cmd
 	l2cap_chan_del(chan, 0);
 	bh_unlock_sock(sk);
 
-	l2cap_sock_kill(sk);
+	chan->ops->close(chan->ops->data);
 	return 0;
 }
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index ba6d4f1..23cf902 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -679,7 +679,7 @@ static int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct ms
 /* Kill socket (only if zapped and orphan)
  * Must be called on unlocked socket.
  */
-void l2cap_sock_kill(struct sock *sk)
+static void l2cap_sock_kill(struct sock *sk)
 {
 	if (!sock_flag(sk, SOCK_ZAPPED) || sk->sk_socket)
 		return;
@@ -762,10 +762,18 @@ static int l2cap_chan_recv_cb(void *data, struct sk_buff *skb)
 	return sock_queue_rcv_skb(sk, skb);
 }
 
+static void l2cap_chan_close_cb(void *data)
+{
+	struct sock *sk = data;
+
+	l2cap_sock_kill(sk);
+}
+
 static struct l2cap_ops l2cap_chan_ops = {
 	.name		= "L2CAP Socket Interface",
 	.new_connection	= l2cap_chan_new_connection_cb,
 	.recv		= l2cap_chan_recv_cb,
+	.close		= l2cap_chan_close_cb,
 };
 
 static void l2cap_sock_destruct(struct sock *sk)
-- 
1.7.5.1

