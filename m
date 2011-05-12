Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/6] Bluetooth: Create l2cap_chan_send()
Date: Thu, 12 May 2011 02:32:26 -0300
Message-Id: <1305178350-7568-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1305178350-7568-1-git-send-email-padovan@profusion.mobi>
References: <1305178350-7568-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This move all the sending logic to l2cap_core.c, but we still have a
socket dependence there, struct msghdr. It will be removed in some of the
further commits.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    9 +----
 net/bluetooth/l2cap_core.c    |   79 +++++++++++++++++++++++++++++++++++++++
 net/bluetooth/l2cap_sock.c    |   83 +---------------------------------------
 3 files changed, 83 insertions(+), 88 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index ed75e65..dc721ca 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -449,14 +449,6 @@ void l2cap_cleanup_sockets(void);
 void __l2cap_connect_rsp_defer(struct l2cap_chan *chan);
 int __l2cap_wait_ack(struct sock *sk);
 
-struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len);
-struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len);
-struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len, u16 control, u16 sdulen);
-int l2cap_sar_segment_sdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len);
-void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb);
-void l2cap_streaming_send(struct l2cap_chan *chan);
-int l2cap_ertm_send(struct l2cap_chan *chan);
-
 int l2cap_add_psm(struct l2cap_chan *chan, bdaddr_t *src, __le16 psm);
 int l2cap_add_scid(struct l2cap_chan *chan,  __u16 scid);
 
@@ -470,5 +462,6 @@ struct l2cap_chan *l2cap_chan_create(struct sock *sk);
 void __l2cap_chan_close(struct l2cap_chan *chan, int reason);
 void l2cap_chan_destroy(struct l2cap_chan *chan);
 int l2cap_chan_connect(struct l2cap_chan *chan);
+int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len);
 
 #endif /* __L2CAP_H */
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7a943de..5473fc9 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1535,6 +1535,85 @@ int l2cap_sar_segment_sdu(struct l2cap_chan *chan, struct msghdr *msg, size_t le
 	return size;
 }
 
+int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
+{
+	struct sock *sk = chan->sk;
+	struct sk_buff *skb;
+	u16 control;
+	int err;
+
+	/* Connectionless channel */
+	if (sk->sk_type == SOCK_DGRAM) {
+		skb = l2cap_create_connless_pdu(chan, msg, len);
+		if (IS_ERR(skb))
+			return PTR_ERR(skb);
+
+		l2cap_do_send(chan, skb);
+		return len;
+	}
+
+	switch (chan->mode) {
+	case L2CAP_MODE_BASIC:
+		/* Check outgoing MTU */
+		if (len > chan->omtu)
+			return -EMSGSIZE;
+
+		/* Create a basic PDU */
+		skb = l2cap_create_basic_pdu(chan, msg, len);
+		if (IS_ERR(skb))
+			return PTR_ERR(skb);
+
+		l2cap_do_send(chan, skb);
+		err = len;
+		break;
+
+	case L2CAP_MODE_ERTM:
+	case L2CAP_MODE_STREAMING:
+		/* Entire SDU fits into one PDU */
+		if (len <= chan->remote_mps) {
+			control = L2CAP_SDU_UNSEGMENTED;
+			skb = l2cap_create_iframe_pdu(chan, msg, len, control,
+									0);
+			if (IS_ERR(skb))
+				return PTR_ERR(skb);
+
+			__skb_queue_tail(&chan->tx_q, skb);
+
+			if (chan->tx_send_head == NULL)
+				chan->tx_send_head = skb;
+
+		} else {
+		/* Segment SDU into multiples PDUs */
+			err = l2cap_sar_segment_sdu(chan, msg, len);
+			if (err < 0)
+				return err;
+		}
+
+		if (chan->mode == L2CAP_MODE_STREAMING) {
+			l2cap_streaming_send(chan);
+			err = len;
+			break;
+		}
+
+		if ((chan->conn_state & L2CAP_CONN_REMOTE_BUSY) &&
+				(chan->conn_state & L2CAP_CONN_WAIT_F)) {
+			err = len;
+			break;
+		}
+		err = l2cap_ertm_send(chan);
+
+		if (err >= 0)
+			err = len;
+		break;
+
+	default:
+		BT_DBG("bad state %1.1x", chan->mode);
+		err = -EBADFD;
+	}
+
+	return err;
+}
+
 static void l2cap_chan_ready(struct sock *sk)
 {
 	struct sock *parent = bt_sk(sk)->parent;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index f57afa5..f36776e 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -673,8 +673,6 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 {
 	struct sock *sk = sock->sk;
 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
-	struct sk_buff *skb;
-	u16 control;
 	int err;
 
 	BT_DBG("sock %p, sk %p", sock, sk);
@@ -689,87 +687,12 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 	lock_sock(sk);
 
 	if (sk->sk_state != BT_CONNECTED) {
-		err = -ENOTCONN;
-		goto done;
+		release_sock(sk);
+		return -ENOTCONN;
 	}
 
-	/* Connectionless channel */
-	if (sk->sk_type == SOCK_DGRAM) {
-		skb = l2cap_create_connless_pdu(chan, msg, len);
-		if (IS_ERR(skb)) {
-			err = PTR_ERR(skb);
-		} else {
-			l2cap_do_send(chan, skb);
-			err = len;
-		}
-		goto done;
-	}
+	err = l2cap_chan_send(chan, msg, len);
 
-	switch (chan->mode) {
-	case L2CAP_MODE_BASIC:
-		/* Check outgoing MTU */
-		if (len > chan->omtu) {
-			err = -EMSGSIZE;
-			goto done;
-		}
-
-		/* Create a basic PDU */
-		skb = l2cap_create_basic_pdu(chan, msg, len);
-		if (IS_ERR(skb)) {
-			err = PTR_ERR(skb);
-			goto done;
-		}
-
-		l2cap_do_send(chan, skb);
-		err = len;
-		break;
-
-	case L2CAP_MODE_ERTM:
-	case L2CAP_MODE_STREAMING:
-		/* Entire SDU fits into one PDU */
-		if (len <= chan->remote_mps) {
-			control = L2CAP_SDU_UNSEGMENTED;
-			skb = l2cap_create_iframe_pdu(chan, msg, len, control,
-									0);
-			if (IS_ERR(skb)) {
-				err = PTR_ERR(skb);
-				goto done;
-			}
-			__skb_queue_tail(&chan->tx_q, skb);
-
-			if (chan->tx_send_head == NULL)
-				chan->tx_send_head = skb;
-
-		} else {
-		/* Segment SDU into multiples PDUs */
-			err = l2cap_sar_segment_sdu(chan, msg, len);
-			if (err < 0)
-				goto done;
-		}
-
-		if (chan->mode == L2CAP_MODE_STREAMING) {
-			l2cap_streaming_send(chan);
-			err = len;
-			break;
-		}
-
-		if ((chan->conn_state & L2CAP_CONN_REMOTE_BUSY) &&
-				(chan->conn_state & L2CAP_CONN_WAIT_F)) {
-			err = len;
-			break;
-		}
-		err = l2cap_ertm_send(chan);
-
-		if (err >= 0)
-			err = len;
-		break;
-
-	default:
-		BT_DBG("bad state %1.1x", chan->mode);
-		err = -EBADFD;
-	}
-
-done:
 	release_sock(sk);
 	return err;
 }
-- 
1.7.5.rc3

