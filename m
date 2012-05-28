Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v3 01/10] Bluetooth: Use chan as parameters for l2cap chan ops
Date: Sun, 27 May 2012 22:27:51 -0300
Message-Id: <1338168480-9646-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Use chan instead of void * makes more sense here.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 include/net/bluetooth/l2cap.h |   10 ++++++----
 net/bluetooth/l2cap_core.c    |   30 +++++++++++++++---------------
 net/bluetooth/l2cap_sock.c    |   16 ++++++++--------
 3 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index f44344b..aa2dbc6 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -527,10 +527,12 @@ struct l2cap_chan {
 struct l2cap_ops {
 	char			*name;
 
-	struct l2cap_chan	*(*new_connection) (void *data);
-	int			(*recv) (void *data, struct sk_buff *skb);
-	void			(*close) (void *data);
-	void			(*state_change) (void *data, int state);
+	struct l2cap_chan	*(*new_connection) (struct l2cap_chan *chan);
+	int			(*recv) (struct l2cap_chan * chan,
+					 struct sk_buff *skb);
+	void			(*close) (struct l2cap_chan *chan);
+	void			(*state_change) (struct l2cap_chan *chan,
+						 int state);
 	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
 					       unsigned long len, int nb);
 };
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index de0dc9e..7edc814 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -180,7 +180,7 @@ static void __l2cap_state_change(struct l2cap_chan *chan, int state)
 						state_to_string(state));
 
 	chan->state = state;
-	chan->ops->state_change(chan->data, state);
+	chan->ops->state_change(chan, state);
 }
 
 static void l2cap_state_change(struct l2cap_chan *chan, int state)
@@ -381,7 +381,7 @@ static void l2cap_chan_timeout(struct work_struct *work)
 
 	l2cap_chan_unlock(chan);
 
-	chan->ops->close(chan->data);
+	chan->ops->close(chan);
 	mutex_unlock(&conn->chan_lock);
 
 	l2cap_chan_put(chan);
@@ -569,7 +569,7 @@ static void l2cap_chan_cleanup_listen(struct sock *parent)
 		l2cap_chan_close(chan, ECONNRESET);
 		l2cap_chan_unlock(chan);
 
-		chan->ops->close(chan->data);
+		chan->ops->close(chan);
 	}
 }
 
@@ -1213,7 +1213,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 		goto clean;
 	}
 
-	chan = pchan->ops->new_connection(pchan->data);
+	chan = pchan->ops->new_connection(pchan);
 	if (!chan)
 		goto clean;
 
@@ -1324,7 +1324,7 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 
 		l2cap_chan_unlock(chan);
 
-		chan->ops->close(chan->data);
+		chan->ops->close(chan);
 		l2cap_chan_put(chan);
 	}
 
@@ -2568,7 +2568,7 @@ static void l2cap_raw_recv(struct l2cap_conn *conn, struct sk_buff *skb)
 		if (!nskb)
 			continue;
 
-		if (chan->ops->recv(chan->data, nskb))
+		if (chan->ops->recv(chan, nskb))
 			kfree_skb(nskb);
 	}
 
@@ -3411,7 +3411,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 		goto response;
 	}
 
-	chan = pchan->ops->new_connection(pchan->data);
+	chan = pchan->ops->new_connection(pchan);
 	if (!chan)
 		goto response;
 
@@ -3420,7 +3420,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	/* Check if we already have channel with that dcid */
 	if (__l2cap_get_chan_by_dcid(conn, scid)) {
 		sock_set_flag(sk, SOCK_ZAPPED);
-		chan->ops->close(chan->data);
+		chan->ops->close(chan);
 		goto response;
 	}
 
@@ -3831,7 +3831,7 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
 
 	l2cap_chan_unlock(chan);
 
-	chan->ops->close(chan->data);
+	chan->ops->close(chan);
 	l2cap_chan_put(chan);
 
 	mutex_unlock(&conn->chan_lock);
@@ -3865,7 +3865,7 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn, struct l2cap_cmd
 
 	l2cap_chan_unlock(chan);
 
-	chan->ops->close(chan->data);
+	chan->ops->close(chan);
 	l2cap_chan_put(chan);
 
 	mutex_unlock(&conn->chan_lock);
@@ -4435,7 +4435,7 @@ static int l2cap_reassemble_sdu(struct l2cap_chan *chan, struct sk_buff *skb,
 		if (chan->sdu)
 			break;
 
-		err = chan->ops->recv(chan->data, skb);
+		err = chan->ops->recv(chan, skb);
 		break;
 
 	case L2CAP_SAR_START:
@@ -4485,7 +4485,7 @@ static int l2cap_reassemble_sdu(struct l2cap_chan *chan, struct sk_buff *skb,
 		if (chan->sdu->len != chan->sdu_len)
 			break;
 
-		err = chan->ops->recv(chan->data, chan->sdu);
+		err = chan->ops->recv(chan, chan->sdu);
 
 		if (!err) {
 			/* Reassembly complete */
@@ -5207,7 +5207,7 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		if (chan->imtu < skb->len)
 			goto drop;
 
-		if (!chan->ops->recv(chan->data, skb))
+		if (!chan->ops->recv(chan, skb))
 			goto done;
 		break;
 
@@ -5246,7 +5246,7 @@ static inline int l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm, str
 	if (chan->imtu < skb->len)
 		goto drop;
 
-	if (!chan->ops->recv(chan->data, skb))
+	if (!chan->ops->recv(chan, skb))
 		return 0;
 
 drop:
@@ -5272,7 +5272,7 @@ static inline int l2cap_att_channel(struct l2cap_conn *conn, u16 cid,
 	if (chan->imtu < skb->len)
 		goto drop;
 
-	if (!chan->ops->recv(chan->data, skb))
+	if (!chan->ops->recv(chan, skb))
 		return 0;
 
 drop:
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index d244361..db787f6 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -872,9 +872,9 @@ static int l2cap_sock_release(struct socket *sock)
 	return err;
 }
 
-static struct l2cap_chan *l2cap_sock_new_connection_cb(void *data)
+static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 {
-	struct sock *sk, *parent = data;
+	struct sock *sk, *parent = chan->data;
 
 	sk = l2cap_sock_alloc(sock_net(parent), NULL, BTPROTO_L2CAP,
 								GFP_ATOMIC);
@@ -888,10 +888,10 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(void *data)
 	return l2cap_pi(sk)->chan;
 }
 
-static int l2cap_sock_recv_cb(void *data, struct sk_buff *skb)
+static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 {
 	int err;
-	struct sock *sk = data;
+	struct sock *sk = chan->data;
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 
 	lock_sock(sk);
@@ -924,16 +924,16 @@ done:
 	return err;
 }
 
-static void l2cap_sock_close_cb(void *data)
+static void l2cap_sock_close_cb(struct l2cap_chan *chan)
 {
-	struct sock *sk = data;
+	struct sock *sk = chan->data;
 
 	l2cap_sock_kill(sk);
 }
 
-static void l2cap_sock_state_change_cb(void *data, int state)
+static void l2cap_sock_state_change_cb(struct l2cap_chan *chan, int state)
 {
-	struct sock *sk = data;
+	struct sock *sk = chan->data;
 
 	sk->sk_state = state;
 }
-- 
1.7.10.2

