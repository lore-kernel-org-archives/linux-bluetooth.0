Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH -v2 3/8] Bluetooth: add recv() callback to l2cap_chan_ops
Date: Wed,  8 Jun 2011 12:18:54 -0300
Message-Id: <1307546339-12035-4-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1307546339-12035-3-git-send-email-padovan@profusion.mobi>
References: <1307546339-12035-1-git-send-email-padovan@profusion.mobi>
 <1307546339-12035-2-git-send-email-padovan@profusion.mobi>
 <1307546339-12035-3-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This abstracts the call to sock_queue_recv_skb() into
l2cap_chan_ops->recv().

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/l2cap_core.c    |   16 ++++++++--------
 net/bluetooth/l2cap_sock.c    |    8 ++++++++
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index d3a1509..05bb254 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -363,6 +363,7 @@ struct l2cap_ops {
 	char		*name;
 
 	struct l2cap_chan	*(*new_connection) (void *data);
+	int			(*recv) (void *data, struct sk_buff *skb);
 };
 
 struct l2cap_conn {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index add412e..fa9a4ab 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1698,7 +1698,7 @@ static void l2cap_raw_recv(struct l2cap_conn *conn, struct sk_buff *skb)
 		if (!nskb)
 			continue;
 
-		if (sock_queue_rcv_skb(sk, nskb))
+		if (chan->ops->recv(chan->data, nskb))
 			kfree_skb(nskb);
 	}
 	read_unlock(&conn->chan_lock);
@@ -3124,7 +3124,7 @@ static int l2cap_ertm_reassembly_sdu(struct l2cap_chan *chan, struct sk_buff *sk
 		if (chan->conn_state & L2CAP_CONN_SAR_SDU)
 			goto drop;
 
-		return sock_queue_rcv_skb(chan->sk, skb);
+		return chan->ops->recv(chan->data, skb);
 
 	case L2CAP_SDU_START:
 		if (chan->conn_state & L2CAP_CONN_SAR_SDU)
@@ -3190,7 +3190,7 @@ static int l2cap_ertm_reassembly_sdu(struct l2cap_chan *chan, struct sk_buff *sk
 			return -ENOMEM;
 		}
 
-		err = sock_queue_rcv_skb(chan->sk, _skb);
+		err = chan->ops->recv(chan->data, _skb);
 		if (err < 0) {
 			kfree_skb(_skb);
 			chan->conn_state |= L2CAP_CONN_SAR_RETRY;
@@ -3358,7 +3358,7 @@ static int l2cap_streaming_reassembly_sdu(struct l2cap_chan *chan, struct sk_buf
 			break;
 		}
 
-		err = sock_queue_rcv_skb(chan->sk, skb);
+		err = chan->ops->recv(chan->data, skb);
 		if (!err)
 			return 0;
 
@@ -3419,7 +3419,7 @@ static int l2cap_streaming_reassembly_sdu(struct l2cap_chan *chan, struct sk_buf
 
 		if (chan->partial_sdu_len == chan->sdu_len) {
 			_skb = skb_clone(chan->sdu, GFP_ATOMIC);
-			err = sock_queue_rcv_skb(chan->sk, _skb);
+			err = chan->ops->recv(chan->data, _skb);
 			if (err < 0)
 				kfree_skb(_skb);
 		}
@@ -3886,7 +3886,7 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		if (chan->imtu < skb->len)
 			goto drop;
 
-		if (!sock_queue_rcv_skb(sk, skb))
+		if (!chan->ops->recv(chan->data, skb))
 			goto done;
 		break;
 
@@ -3964,7 +3964,7 @@ static inline int l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm, str
 	if (l2cap_pi(sk)->chan->imtu < skb->len)
 		goto drop;
 
-	if (!sock_queue_rcv_skb(sk, skb))
+	if (!chan->ops->recv(chan->data, skb))
 		goto done;
 
 drop:
@@ -3997,7 +3997,7 @@ static inline int l2cap_att_channel(struct l2cap_conn *conn, __le16 cid, struct
 	if (l2cap_pi(sk)->chan->imtu < skb->len)
 		goto drop;
 
-	if (!sock_queue_rcv_skb(sk, skb))
+	if (!chan->ops->recv(chan->data, skb))
 		goto done;
 
 drop:
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 4050ede..28cdc7e 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -789,9 +789,17 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(void *data)
 	return l2cap_pi(sk)->chan;
 }
 
+static int l2cap_sock_recv_cb(void *data, struct sk_buff *skb)
+{
+	struct sock *sk = data;
+
+	return sock_queue_rcv_skb(sk, skb);
+}
+
 static struct l2cap_ops l2cap_chan_ops = {
 	.name		= "L2CAP Socket Interface",
 	.new_connection	= l2cap_sock_new_connection_cb,
+	.recv		= l2cap_sock_recv_cb,
 };
 
 static void l2cap_sock_destruct(struct sock *sk)
-- 
1.7.5.1

