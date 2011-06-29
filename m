Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 5/6] Bluetooth: Use event-driven approach for handling ERTM receive buffer
Date: Wed, 29 Jun 2011 14:35:23 -0700
Message-Id: <1309383324-12002-6-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1309383324-12002-1-git-send-email-mathewm@codeaurora.org>
References: <1309383324-12002-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This change moves most L2CAP ERTM receive buffer handling out of the
L2CAP core and in to the socket code.  It's up to the higher layer
(the socket code, in this case) to tell the core when its buffer is
full or has space available.  The recv op should always accept
incoming ERTM data or else the connection will go down.

Within the socket layer, an skb that does not fit in the socket
receive buffer will be temporarily stored.  When the socket is read
from, that skb will be placed in the receive buffer if possible.  Once
adequate buffer space becomes available, the L2CAP core is informed
and the ERTM local busy state is cleared.

Receive buffer management for non-ERTM modes is unchanged.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 include/net/bluetooth/l2cap.h |    3 ++
 net/bluetooth/l2cap_core.c    |   41 ++++++++++++++++---------
 net/bluetooth/l2cap_sock.c    |   67 +++++++++++++++++++++++++++++++++++++++--
 3 files changed, 93 insertions(+), 18 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 9c18e55..82387c5 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -422,6 +422,8 @@ struct l2cap_conn {
 struct l2cap_pinfo {
 	struct bt_sock	bt;
 	struct l2cap_chan	*chan;
+	struct sk_buff	*rx_busy_skb;
+	int rx_busy;
 };
 
 enum {
@@ -498,5 +500,6 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason);
 void l2cap_chan_destroy(struct l2cap_chan *chan);
 int l2cap_chan_connect(struct l2cap_chan *chan);
 int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len);
+void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
 
 #endif /* __L2CAP_H */
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 4b764b1..f0e7ba7 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3350,21 +3350,21 @@ static int l2cap_push_rx_skb(struct l2cap_chan *chan, struct sk_buff *skb, u16 c
 	}
 
 	err = l2cap_ertm_reassembly_sdu(chan, skb, control);
-	if (err >= 0) {
-		chan->buffer_seq = (chan->buffer_seq + 1) % 64;
-		return err;
-	}
-
-	l2cap_ertm_enter_local_busy(chan);
-
-	bt_cb(skb)->sar = control >> L2CAP_CTRL_SAR_SHIFT;
-	__skb_queue_tail(&chan->busy_q, skb);
-
-	queue_work(_busy_wq, &chan->busy_work);
+	chan->buffer_seq = (chan->buffer_seq + 1) % 64;
 
 	return err;
 }
 
+void l2cap_chan_busy(struct l2cap_chan *chan, int busy)
+{
+	if (chan->mode == L2CAP_MODE_ERTM) {
+		if (busy)
+			l2cap_ertm_enter_local_busy(chan);
+		else
+			l2cap_ertm_exit_local_busy(chan);
+	}
+}
+
 static int l2cap_streaming_reassembly_sdu(struct l2cap_chan *chan, struct sk_buff *skb, u16 control)
 {
 	struct sk_buff *_skb;
@@ -3463,13 +3463,22 @@ static void l2cap_check_srej_gap(struct l2cap_chan *chan, u8 tx_seq)
 	struct sk_buff *skb;
 	u16 control;
 
-	while ((skb = skb_peek(&chan->srej_q))) {
+	while ((skb = skb_peek(&chan->srej_q)) &&
+			!test_bit(CONN_LOCAL_BUSY, &chan->conn_state)) {
+		int err;
+
 		if (bt_cb(skb)->tx_seq != tx_seq)
 			break;
 
 		skb = skb_dequeue(&chan->srej_q);
 		control = bt_cb(skb)->sar << L2CAP_CTRL_SAR_SHIFT;
-		l2cap_ertm_reassembly_sdu(chan, skb, control);
+		err = l2cap_ertm_reassembly_sdu(chan, skb, control);
+
+		if (err < 0) {
+			l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
+			break;
+		}
+
 		chan->buffer_seq_srej =
 			(chan->buffer_seq_srej + 1) % 64;
 		tx_seq = (tx_seq + 1) % 64;
@@ -3625,8 +3634,10 @@ expected:
 	}
 
 	err = l2cap_push_rx_skb(chan, skb, rx_control);
-	if (err < 0)
-		return 0;
+	if (err < 0) {
+		l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
+		return err;
+	}
 
 	if (rx_control & L2CAP_CTRL_FINAL) {
 		if (!test_and_clear_bit(CONN_REJ_ACT, &chan->conn_state))
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 39082d4..ab0494b 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -711,6 +711,8 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 static int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len, int flags)
 {
 	struct sock *sk = sock->sk;
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	int err;
 
 	lock_sock(sk);
 
@@ -725,9 +727,40 @@ static int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct ms
 	release_sock(sk);
 
 	if (sock->type == SOCK_STREAM)
-		return bt_sock_stream_recvmsg(iocb, sock, msg, len, flags);
+		err = bt_sock_stream_recvmsg(iocb, sock, msg, len, flags);
+	else
+		err = bt_sock_recvmsg(iocb, sock, msg, len, flags);
+
+	if (pi->chan->mode == L2CAP_MODE_ERTM) {
+		int queue_err;
+		int threshold;
+
+		/* Attempt to put pending rx data in the socket buffer */
+
+		lock_sock(sk);
+		if (pi->rx_busy_skb) {
+			queue_err = sock_queue_rcv_skb(sk, pi->rx_busy_skb);
+
+			if (!queue_err)
+				pi->rx_busy_skb = NULL;
+		}
+
+		/* Restore data flow when half of the receive buffer is
+		 * available.  This avoids resending large numbers of
+		 * frames.
+		 */
+		threshold = sk->sk_rcvbuf >> 1;
+		if (pi->rx_busy && !pi->rx_busy_skb &&
+				atomic_read(&sk->sk_rmem_alloc) <= threshold) {
+
+			pi->rx_busy = 0;
+			l2cap_chan_busy(l2cap_pi(sk)->chan, pi->rx_busy);
+		}
+
+		release_sock(sk);
+	}
 
-	return bt_sock_recvmsg(iocb, sock, msg, len, flags);
+	return err;
 }
 
 /* Kill socket (only if zapped and orphan)
@@ -811,9 +844,32 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(void *data)
 
 static int l2cap_sock_recv_cb(void *data, struct sk_buff *skb)
 {
+	int err;
 	struct sock *sk = data;
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+
+	if (pi->rx_busy_skb)
+		return -ENOMEM;
+
+	err = sock_queue_rcv_skb(sk, skb);
+
+	/* For ERTM, handle one skb that doesn't fit into the recv
+	 * buffer.  This is important to do because the data frames
+	 * have already been acked, so the skb cannot be discarded.
+	 *
+	 * Notify the l2cap core that the buffer is full, so the
+	 * LOCAL_BUSY state is entered and no more frames are
+	 * acked and reassembled until there is buffer space
+	 * available.
+	 */
+	if (err < 0 && pi->chan->mode == L2CAP_MODE_ERTM) {
+		pi->rx_busy = 1;
+		pi->rx_busy_skb = skb;
+		l2cap_chan_busy(pi->chan, pi->rx_busy);
+		err = 0;
+	}
 
-	return sock_queue_rcv_skb(sk, skb);
+	return err;
 }
 
 static void l2cap_sock_close_cb(void *data)
@@ -842,6 +898,11 @@ static void l2cap_sock_destruct(struct sock *sk)
 {
 	BT_DBG("sk %p", sk);
 
+	if (l2cap_pi(sk)->rx_busy_skb) {
+		kfree_skb(l2cap_pi(sk)->rx_busy_skb);
+		l2cap_pi(sk)->rx_busy_skb = NULL;
+	}
+
 	skb_queue_purge(&sk->sk_receive_queue);
 	skb_queue_purge(&sk->sk_write_queue);
 }
-- 
1.7.5.4

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

