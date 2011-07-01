Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Jul 2011 10:29:23 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/6] Bluetooth: Use event-driven approach for handling
 ERTM receive buffer
In-Reply-To: <20110630214056.GI25602@joana>
Message-ID: <alpine.DEB.2.02.1107010759070.19830@mathewm-linux>
References: <1309383324-12002-1-git-send-email-mathewm@codeaurora.org> <1309383324-12002-6-git-send-email-mathewm@codeaurora.org> <20110630214056.GI25602@joana>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Gustavo -

On Thu, 30 Jun 2011, Gustavo F. Padovan wrote:

> Hi Mat,
>
> * Mat Martineau <mathewm@codeaurora.org> [2011-06-29 14:35:23 -0700]:
>
>> This change moves most L2CAP ERTM receive buffer handling out of the
>> L2CAP core and in to the socket code.  It's up to the higher layer
>> (the socket code, in this case) to tell the core when its buffer is
>> full or has space available.  The recv op should always accept
>> incoming ERTM data or else the connection will go down.
>>
>> Within the socket layer, an skb that does not fit in the socket
>> receive buffer will be temporarily stored.  When the socket is read
>> from, that skb will be placed in the receive buffer if possible.  Once
>> adequate buffer space becomes available, the L2CAP core is informed
>> and the ERTM local busy state is cleared.
>>
>> Receive buffer management for non-ERTM modes is unchanged.
>>
>> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
>> ---
>>  include/net/bluetooth/l2cap.h |    3 ++
>>  net/bluetooth/l2cap_core.c    |   41 ++++++++++++++++---------
>>  net/bluetooth/l2cap_sock.c    |   67 +++++++++++++++++++++++++++++++++++++++--
>>  3 files changed, 93 insertions(+), 18 deletions(-)
>>
>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
>> index 9c18e55..82387c5 100644
>> --- a/include/net/bluetooth/l2cap.h
>> +++ b/include/net/bluetooth/l2cap.h
>> @@ -422,6 +422,8 @@ struct l2cap_conn {
>>  struct l2cap_pinfo {
>>  	struct bt_sock	bt;
>>  	struct l2cap_chan	*chan;
>> +	struct sk_buff	*rx_busy_skb;
>> +	int rx_busy;
>>  };
>>
>>  enum {
>> @@ -498,5 +500,6 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason);
>>  void l2cap_chan_destroy(struct l2cap_chan *chan);
>>  int l2cap_chan_connect(struct l2cap_chan *chan);
>>  int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len);
>> +void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
>>
>>  #endif /* __L2CAP_H */
>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>> index 4b764b1..f0e7ba7 100644
>> --- a/net/bluetooth/l2cap_core.c
>> +++ b/net/bluetooth/l2cap_core.c
>> @@ -3350,21 +3350,21 @@ static int l2cap_push_rx_skb(struct l2cap_chan *chan, struct sk_buff *skb, u16 c
>>  	}
>>
>>  	err = l2cap_ertm_reassembly_sdu(chan, skb, control);
>> -	if (err >= 0) {
>> -		chan->buffer_seq = (chan->buffer_seq + 1) % 64;
>> -		return err;
>> -	}
>> -
>> -	l2cap_ertm_enter_local_busy(chan);
>> -
>> -	bt_cb(skb)->sar = control >> L2CAP_CTRL_SAR_SHIFT;
>> -	__skb_queue_tail(&chan->busy_q, skb);
>> -
>> -	queue_work(_busy_wq, &chan->busy_work);
>> +	chan->buffer_seq = (chan->buffer_seq + 1) % 64;
>>
>>  	return err;
>>  }
>>
>> +void l2cap_chan_busy(struct l2cap_chan *chan, int busy)
>> +{
>> +	if (chan->mode == L2CAP_MODE_ERTM) {
>> +		if (busy)
>> +			l2cap_ertm_enter_local_busy(chan);
>> +		else
>> +			l2cap_ertm_exit_local_busy(chan);
>> +	}
>> +}
>> +
>>  static int l2cap_streaming_reassembly_sdu(struct l2cap_chan *chan, struct sk_buff *skb, u16 control)
>>  {
>>  	struct sk_buff *_skb;
>> @@ -3463,13 +3463,22 @@ static void l2cap_check_srej_gap(struct l2cap_chan *chan, u8 tx_seq)
>>  	struct sk_buff *skb;
>>  	u16 control;
>>
>> -	while ((skb = skb_peek(&chan->srej_q))) {
>> +	while ((skb = skb_peek(&chan->srej_q)) &&
>> +			!test_bit(CONN_LOCAL_BUSY, &chan->conn_state)) {
>> +		int err;
>> +
>>  		if (bt_cb(skb)->tx_seq != tx_seq)
>>  			break;
>>
>>  		skb = skb_dequeue(&chan->srej_q);
>>  		control = bt_cb(skb)->sar << L2CAP_CTRL_SAR_SHIFT;
>> -		l2cap_ertm_reassembly_sdu(chan, skb, control);
>> +		err = l2cap_ertm_reassembly_sdu(chan, skb, control);
>> +
>> +		if (err < 0) {
>> +			l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
>> +			break;
>> +		}
>> +
>>  		chan->buffer_seq_srej =
>>  			(chan->buffer_seq_srej + 1) % 64;
>>  		tx_seq = (tx_seq + 1) % 64;
>> @@ -3625,8 +3634,10 @@ expected:
>>  	}
>>
>>  	err = l2cap_push_rx_skb(chan, skb, rx_control);
>> -	if (err < 0)
>> -		return 0;
>> +	if (err < 0) {
>> +		l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
>> +		return err;
>> +	}
>>
>>  	if (rx_control & L2CAP_CTRL_FINAL) {
>>  		if (!test_and_clear_bit(CONN_REJ_ACT, &chan->conn_state))
>> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
>> index 39082d4..ab0494b 100644
>> --- a/net/bluetooth/l2cap_sock.c
>> +++ b/net/bluetooth/l2cap_sock.c
>> @@ -711,6 +711,8 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
>>  static int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len, int flags)
>>  {
>>  	struct sock *sk = sock->sk;
>> +	struct l2cap_pinfo *pi = l2cap_pi(sk);
>> +	int err;
>>
>>  	lock_sock(sk);
>>
>> @@ -725,9 +727,40 @@ static int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct ms
>>  	release_sock(sk);
>>
>>  	if (sock->type == SOCK_STREAM)
>> -		return bt_sock_stream_recvmsg(iocb, sock, msg, len, flags);
>> +		err = bt_sock_stream_recvmsg(iocb, sock, msg, len, flags);
>> +	else
>> +		err = bt_sock_recvmsg(iocb, sock, msg, len, flags);
>> +
>> +	if (pi->chan->mode == L2CAP_MODE_ERTM) {
>> +		int queue_err;
>> +		int threshold;
>> +
>> +		/* Attempt to put pending rx data in the socket buffer */
>> +
>> +		lock_sock(sk);
>> +		if (pi->rx_busy_skb) {
>> +			queue_err = sock_queue_rcv_skb(sk, pi->rx_busy_skb);
>> +
>> +			if (!queue_err)
>> +				pi->rx_busy_skb = NULL;
>> +		}
>> +
>> +		/* Restore data flow when half of the receive buffer is
>> +		 * available.  This avoids resending large numbers of
>> +		 * frames.
>> +		 */
>> +		threshold = sk->sk_rcvbuf >> 1;
>> +		if (pi->rx_busy && !pi->rx_busy_skb &&
>> +				atomic_read(&sk->sk_rmem_alloc) <= threshold) {
>> +
>> +			pi->rx_busy = 0;
>> +			l2cap_chan_busy(l2cap_pi(sk)->chan, pi->rx_busy);
>> +		}
>> +
>> +		release_sock(sk);
>
> This is to much core logic outside of the core. I didn't think hard on this
> but this can be simplified to just read the threshold and report core if we
> are not busy anymore, and then get rid of rx_busy and rx_busy_skb.


The main purpose of this patch is to change the behavior of 
l2cap_ops->recv() to better match what ERTM needs.

The way sock_queue_rcv_skb() works is not a good match for ERTM. 
ERTM can't put data in to the buffer until after it is reassembled, so 
when sock_queue_rcv_skb() tells the core there's no room, the core 
needs to keep track of the skb that didn't fit.

The core code is simpler if we have a recv_cb function that tells the 
core it is busy *before* it will start rejecting skbs.  Then the core 
does not have to keep track of reassembled and acked skbs. The core 
knows that it gave the skb to the socket (or AMP manager) and does not 
have to worry about it any more.

This patch hides socket-specific behavior in socket-specific code, 
which seems like a good fit.  The core should not have to care about 
socket-specific behavior.

It also delays exit of the local busy state until there is receive 
buffer space available.  This results in fewer transitions in & out of 
local busy.


I could get rid of rx_busy by querying the LOCAL_BUSY bit from 
the core.


>
>> +	}
>>
>> -	return bt_sock_recvmsg(iocb, sock, msg, len, flags);
>> +	return err;
>>  }
>>
>>  /* Kill socket (only if zapped and orphan)
>> @@ -811,9 +844,32 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(void *data)
>>
>>  static int l2cap_sock_recv_cb(void *data, struct sk_buff *skb)
>>  {
>> +	int err;
>>  	struct sock *sk = data;
>> +	struct l2cap_pinfo *pi = l2cap_pi(sk);
>> +
>> +	if (pi->rx_busy_skb)
>> +		return -ENOMEM;
>> +
>> +	err = sock_queue_rcv_skb(sk, skb);
>> +
>> +	/* For ERTM, handle one skb that doesn't fit into the recv
>> +	 * buffer.  This is important to do because the data frames
>> +	 * have already been acked, so the skb cannot be discarded.
>> +	 *
>> +	 * Notify the l2cap core that the buffer is full, so the
>> +	 * LOCAL_BUSY state is entered and no more frames are
>> +	 * acked and reassembled until there is buffer space
>> +	 * available.
>> +	 */
>> +	if (err < 0 && pi->chan->mode == L2CAP_MODE_ERTM) {
>> +		pi->rx_busy = 1;
>> +		pi->rx_busy_skb = skb;
>> +		l2cap_chan_busy(pi->chan, pi->rx_busy);
>> +		err = 0;
>> +	}
>
> This can totally be in l2cap_core.c. The idea is move Core stuff to
> l2cap_core.c and not let the L2CAP users handle this. Just enter in LOCAL_BUSY
> when recv_cb returns returns less than 0.


I see the core's responsibility as handling the ERTM protocol - it 
receives, reassembles, and acks the data.  When it has finished that 
job, and has no indication that it should be "busy", it passes that 
data to the higher layer (socket or AMP manager) and is done with it. 
This means the socket layer must keep the one skb that didn't fit in 
the receive buffer, and it puts that data in the socket rcvbuf in a 
way that is invisible to the core.

This changes the local busy behavior from:

  * skb arrives, core reassembles it
  * Core calls socket recv_cb, error returned
  * Core puts 'end' PDU or 'unsegmented' SDU on the busy_q
  * Core sends RNR
  * Core polls socket recv_cb [up to 12 calls from core to socket]
    * Reassembly code is executed each time (but data not re-copied)
  * Core sends RR though there may be very little space in the socket
    recv buffer

and instead does:

  * skb arrives, core reassembles it exactly once
  * Core calls socket recv_cb
  * Socket tells the core it is busy
  * Core sends RNR
  * Application calls recvmsg() until buffer is half full (no core 
interaction) [no limit other than socket timeout]
  * Socket tells the core it is not busy
  * Core sends RR, and there is socket buffer space to accept incoming 
data

The new way has no iteration in the core, and all of the work that 
happens during a recvmsg() stays in the socket code until there is 
buffer space available.


The change is also motiviated by trying to remove the busy workqueue, 
which is a good thing to do for several reasons:

  * Gets rid of an extra thread and associated scheduling and memory
  * The current implementation of l2cap_busy_work() does not operate 
well with multiple sockets (the workqueue thread is blocked until
l2cap_busy_work() returns - so no)
  * The socket layer knows when the receive buffer was read from, so it 
makes sense to only attempt reassembly after recvmsg and not poll 
every 200ms.
  * Data gets to the socket layer faster if there's no wait for the 
next polling attempt.
  * Channel is disconnected after a couple of seconds, which isn't 
necessary and may break some apps

As I commented on patch 1 of this set, I'd also like to discard 
packets during local busy and get rid of the busy_q (to limit memory 
usage).  Since the core currently places skbs on the busy_q when 
recv_cb returns an error, there needs to be a different place for the 
skb to go when sock_queue_rcv_skb() returns an error.  The socket code 
seemed like a good place for this, as I explained above.


--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

