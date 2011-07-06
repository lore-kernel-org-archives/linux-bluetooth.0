Return-Path: <cyrus@holtmann.org>
Date: Wed, 6 Jul 2011 20:43:51 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 2/3] Bluetooth: Use event-driven approach for handling
 ERTM receive buffer
Message-ID: <20110706234351.GA14399@joana>
References: <1309989272-24103-1-git-send-email-mathewm@codeaurora.org>
 <1309989272-24103-3-git-send-email-mathewm@codeaurora.org>
 <20110706223635.GD7786@joana>
 <alpine.DEB.2.02.1107061537440.26908@mathewm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1107061537440.26908@mathewm-linux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2011-07-06 16:01:43 -0700]:

> 
> Hi Gustavo -
> 
> On Wed, 6 Jul 2011, Gustavo Padovan wrote:
> 
> >Hi Mat,
> >
> >* Mat Martineau <mathewm@codeaurora.org> [2011-07-06 14:54:31 -0700]:
> >
> >>This change moves most L2CAP ERTM receive buffer handling out of the
> >>L2CAP core and in to the socket code.  It's up to the higher layer
> >>(the socket code, in this case) to tell the core when its buffer is
> >>full or has space available.  The recv op should always accept
> >>incoming ERTM data or else the connection will go down.
> >>
> >>Within the socket layer, an skb that does not fit in the socket
> >>receive buffer will be temporarily stored.  When the socket is read
> >>from, that skb will be placed in the receive buffer if possible.  Once
> >>adequate buffer space becomes available, the L2CAP core is informed
> >>and the ERTM local busy state is cleared.
> >>
> >>Receive buffer management for non-ERTM modes is unchanged.
> >>
> >>Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> >>---
> >> include/net/bluetooth/l2cap.h |    2 +
> >> net/bluetooth/l2cap_core.c    |   41 ++++++++++++++++---------
> >> net/bluetooth/l2cap_sock.c    |   66 ++++++++++++++++++++++++++++++++++++++--
> >> 3 files changed, 90 insertions(+), 19 deletions(-)
> >>
> >>diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> >>index 9c18e55..66b8d96 100644
> >>--- a/include/net/bluetooth/l2cap.h
> >>+++ b/include/net/bluetooth/l2cap.h
> >>@@ -422,6 +422,7 @@ struct l2cap_conn {
> >> struct l2cap_pinfo {
> >> 	struct bt_sock	bt;
> >> 	struct l2cap_chan	*chan;
> >>+	struct sk_buff	*rx_busy_skb;
> >> };
> >>
> >> enum {
> >>@@ -498,5 +499,6 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason);
> >> void l2cap_chan_destroy(struct l2cap_chan *chan);
> >> int l2cap_chan_connect(struct l2cap_chan *chan);
> >> int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len);
> >>+void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
> >>
> >> #endif /* __L2CAP_H */
> >>diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> >>index f7ada4a..ea9c7d0 100644
> >>--- a/net/bluetooth/l2cap_core.c
> >>+++ b/net/bluetooth/l2cap_core.c
> >>@@ -3350,21 +3350,21 @@ static int l2cap_push_rx_skb(struct l2cap_chan *chan, struct sk_buff *skb, u16 c
> >> 	}
> >>
> >> 	err = l2cap_ertm_reassembly_sdu(chan, skb, control);
> >>-	if (err >= 0) {
> >>-		chan->buffer_seq = (chan->buffer_seq + 1) % 64;
> >>-		return err;
> >>-	}
> >>-
> >>-	l2cap_ertm_enter_local_busy(chan);
> >>-
> >>-	bt_cb(skb)->sar = control >> L2CAP_CTRL_SAR_SHIFT;
> >>-	__skb_queue_tail(&chan->busy_q, skb);
> >>-
> >>-	queue_work(_busy_wq, &chan->busy_work);
> >>+	chan->buffer_seq = (chan->buffer_seq + 1) % 64;
> >>
> >> 	return err;
> >> }
> >>
> >>+void l2cap_chan_busy(struct l2cap_chan *chan, int busy)
> >>+{
> >>+	if (chan->mode == L2CAP_MODE_ERTM) {
> >>+		if (busy)
> >>+			l2cap_ertm_enter_local_busy(chan);
> >>+		else
> >>+			l2cap_ertm_exit_local_busy(chan);
> >>+	}
> >>+}
> >>+
> >> static int l2cap_streaming_reassembly_sdu(struct l2cap_chan *chan, struct sk_buff *skb, u16 control)
> >> {
> >> 	struct sk_buff *_skb;
> >>@@ -3463,13 +3463,22 @@ static void l2cap_check_srej_gap(struct l2cap_chan *chan, u8 tx_seq)
> >> 	struct sk_buff *skb;
> >> 	u16 control;
> >>
> >>-	while ((skb = skb_peek(&chan->srej_q))) {
> >>+	while ((skb = skb_peek(&chan->srej_q)) &&
> >>+			!test_bit(CONN_LOCAL_BUSY, &chan->conn_state)) {
> >>+		int err;
> >>+
> >> 		if (bt_cb(skb)->tx_seq != tx_seq)
> >> 			break;
> >>
> >> 		skb = skb_dequeue(&chan->srej_q);
> >> 		control = bt_cb(skb)->sar << L2CAP_CTRL_SAR_SHIFT;
> >>-		l2cap_ertm_reassembly_sdu(chan, skb, control);
> >>+		err = l2cap_ertm_reassembly_sdu(chan, skb, control);
> >>+
> >>+		if (err < 0) {
> >>+			l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
> >>+			break;
> >>+		}
> >>+
> >> 		chan->buffer_seq_srej =
> >> 			(chan->buffer_seq_srej + 1) % 64;
> >> 		tx_seq = (tx_seq + 1) % 64;
> >>@@ -3625,8 +3634,10 @@ expected:
> >> 	}
> >>
> >> 	err = l2cap_push_rx_skb(chan, skb, rx_control);
> >>-	if (err < 0)
> >>-		return 0;
> >>+	if (err < 0) {
> >>+		l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
> >>+		return err;
> >>+	}
> >>
> >> 	if (rx_control & L2CAP_CTRL_FINAL) {
> >> 		if (!test_and_clear_bit(CONN_REJ_ACT, &chan->conn_state))
> >>diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> >>index 39082d4..9bf7313 100644
> >>--- a/net/bluetooth/l2cap_sock.c
> >>+++ b/net/bluetooth/l2cap_sock.c
> >>@@ -711,13 +711,15 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
> >> static int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len, int flags)
> >> {
> >> 	struct sock *sk = sock->sk;
> >>+	struct l2cap_pinfo *pi = l2cap_pi(sk);
> >>+	int err;
> >>
> >> 	lock_sock(sk);
> >>
> >> 	if (sk->sk_state == BT_CONNECT2 && bt_sk(sk)->defer_setup) {
> >> 		sk->sk_state = BT_CONFIG;
> >>
> >>-		__l2cap_connect_rsp_defer(l2cap_pi(sk)->chan);
> >>+		__l2cap_connect_rsp_defer(pi->chan);
> >> 		release_sock(sk);
> >> 		return 0;
> >> 	}
> >>@@ -725,9 +727,38 @@ static int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct ms
> >> 	release_sock(sk);
> >>
> >> 	if (sock->type == SOCK_STREAM)
> >>-		return bt_sock_stream_recvmsg(iocb, sock, msg, len, flags);
> >>+		err = bt_sock_stream_recvmsg(iocb, sock, msg, len, flags);
> >>+	else
> >>+		err = bt_sock_recvmsg(iocb, sock, msg, len, flags);
> >>+
> >>+	if (pi->chan->mode == L2CAP_MODE_ERTM) {
> >
> >	if (pi->chan->mode != L2CAP_MODE_ERTM) {
> >		return err;
> >
> >	lock_sock()...
> 
> Ok.
> 
> >>+		int threshold;
> >>+
> >>+		/* Attempt to put pending rx data in the socket buffer */
> >>+
> >>+		lock_sock(sk);
> >>+		if (pi->rx_busy_skb) {
> >>+			int queue_err;
> >>+			queue_err = sock_queue_rcv_skb(sk, pi->rx_busy_skb);
> >>+
> >>+			if (!queue_err)
> >>+				pi->rx_busy_skb = NULL;
> >
> >			if (!sock_queue_rcv_skb())
> >				pi->rx_busy_skb = NULL;
> >			else
> >				return err;
> >
> >What I understood is that if sock_queue_rcv_skb() fails there is no need to
> >check if there is available space in the buffer, then we just return. The
> >locks also needs to be released.
> 
> You're right - it's better to make sure we don't exit local busy in
> this case.
> 
> >>+		}
> >>+
> >>+		/* Restore data flow when half of the receive buffer is
> >>+		 * available.  This avoids resending large numbers of
> >>+		 * frames.
> >>+		 */
> >>+		threshold = sk->sk_rcvbuf >> 1;
> >>+		if (test_bit(CONN_LOCAL_BUSY, &pi->chan->conn_state) &&
> >>+				!pi->rx_busy_skb &&
> >>+				atomic_read(&sk->sk_rmem_alloc) <= threshold)
> >>+			l2cap_chan_busy(pi->chan, 0);
> >
> >Then this if can be just
> >
> >		if (atomic_read(sk_rmem_alloc) <= sk_rcvbuf >> 1)
> >			l2cap_chan_busy(pi->chan, 0);
> >
> 
> It's still important to see if the channel is currently LOCAL_BUSY,
> this code path will be executed every time an ERTM socket is read
> from (busy or not).

what about this in beginning?

	if (pi->chan->mode != L2CAP_MODE_ERTM || !LOCAL_BUSY) {

Then we avoid all the rest of the code if we are in Local Busy.

	Gustavo
