Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 May 2012 13:19:14 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Gustavo Padovan <gustavo@padovan.org>
cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
    ulisses@profusion.mobi, pkrystad@codeaurora.org
Subject: Re: [PATCH 02/25] Bluetooth: Add a new L2CAP ERTM transmit state
 machine.
In-Reply-To: <20120518195422.GA16942@joana>
Message-ID: <alpine.DEB.2.02.1205181317470.3662@mathewm-linux>
References: <1337313235-26535-1-git-send-email-mathewm@codeaurora.org> <1337313235-26535-3-git-send-email-mathewm@codeaurora.org> <20120518195422.GA16942@joana>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>


On Fri, 18 May 2012, Gustavo Padovan wrote:

> Hi Mat,
>
> * Mat Martineau <mathewm@codeaurora.org> [2012-05-17 20:53:32 -0700]:
>
>> This implements a top-level transmit state machine with handlers for
>> the two ERTM states defined in the specification: XMIT and WAIT_F.
>>
>> The state machine accepts an event and, optionally, a list of skbs to
>> transmit.  In addition to data transmission, the local busy state can
>> be modified, acks are processed, and monitor and retransmit timeouts
>> are handled.  This mirrors the structure of the state tables in the
>> spec.
>>
>> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
>> ---
>>  net/bluetooth/l2cap_core.c |  254 ++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 246 insertions(+), 8 deletions(-)
>>
>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>> index 6557367..a131403 100644
>> --- a/net/bluetooth/l2cap_core.c
>> +++ b/net/bluetooth/l2cap_core.c
>> @@ -73,6 +73,9 @@ static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data);
>>  static void l2cap_send_disconn_req(struct l2cap_conn *conn,
>>  				   struct l2cap_chan *chan, int err);
>>
>> +static int l2cap_tx(struct l2cap_chan *chan, struct l2cap_ctrl *control,
>> +		    struct sk_buff_head *skbs, u8 event);
>> +
>>  /* ---- L2CAP channels ---- */
>>
>>  static struct l2cap_chan *__l2cap_get_chan_by_dcid(struct l2cap_conn *conn, u16 cid)
>> @@ -224,6 +227,19 @@ static inline void l2cap_chan_set_err(struct l2cap_chan *chan, int err)
>>  	release_sock(sk);
>>  }
>>
>> +static struct sk_buff *l2cap_ertm_seq_in_queue(struct sk_buff_head *head,
>> +					       u16 seq)
>> +{
>> +	struct sk_buff *skb;
>> +
>> +	skb_queue_walk(head, skb) {
>> +		if (bt_cb(skb)->control.txseq == seq)
>> +			return skb;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>>  /* ---- L2CAP sequence number lists ---- */
>>
>>  /* For ERTM, ordered lists of sequence numbers must be tracked for
>> @@ -2117,16 +2133,15 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
>>  		if (err)
>>  			break;
>>
>> -		if (chan->mode == L2CAP_MODE_ERTM && chan->tx_send_head == NULL)
>> -			chan->tx_send_head = seg_queue.next;
>> -		skb_queue_splice_tail_init(&seg_queue, &chan->tx_q);
>> -
>> -		if (chan->mode == L2CAP_MODE_ERTM)
>> -			err = l2cap_ertm_send(chan);
>> -		else
>> +		if (chan->mode == L2CAP_MODE_ERTM) {
>> +			err = l2cap_tx(chan, 0, &seg_queue,
>> +				       L2CAP_EV_DATA_REQUEST);
>> +		} else {
>> +			skb_queue_splice_tail_init(&seg_queue, &chan->tx_q);
>>  			l2cap_streaming_send(chan);
>> +		}
>>
>> -		if (err >= 0)
>> +		if (!err)
>>  			err = len;
>>
>>  		/* If the skbs were not queued for sending, they'll still be in
>> @@ -2143,6 +2158,229 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
>>  	return err;
>>  }
>>
>> +static void l2cap_process_reqseq(struct l2cap_chan *chan, u16 reqseq)
>> +{
>> +	struct sk_buff *acked_skb;
>> +	u16 ackseq;
>> +
>> +	BT_DBG("chan %p, reqseq %d", chan, reqseq);
>> +
>> +	if (chan->unacked_frames == 0 || reqseq == chan->expected_ack_seq)
>> +		return;
>> +
>> +	BT_DBG("expected_ack_seq %d, unacked_frames %d",
>> +	       chan->expected_ack_seq, chan->unacked_frames);
>> +
>> +	for (ackseq = chan->expected_ack_seq; ackseq != reqseq;
>> +	     ackseq = __next_seq(chan, ackseq)) {
>> +
>> +		acked_skb = l2cap_ertm_seq_in_queue(&chan->tx_q, ackseq);
>> +		if (acked_skb) {
>> +			skb_unlink(acked_skb, &chan->tx_q);
>> +			kfree_skb(acked_skb);
>> +			chan->unacked_frames--;
>> +		}
>> +	}
>> +
>> +	chan->expected_ack_seq = reqseq;
>> +
>> +	if (chan->unacked_frames == 0)
>> +		__clear_retrans_timer(chan);
>> +
>> +	BT_DBG("unacked_frames %d", (int) chan->unacked_frames);
>> +}
>> +
>> +static void l2cap_abort_rx_srej_sent(struct l2cap_chan *chan)
>> +{
>> +	BT_DBG("chan %p", chan);
>> +
>> +	chan->expected_tx_seq = chan->buffer_seq;
>> +	l2cap_seq_list_clear(&chan->srej_list);
>> +	skb_queue_purge(&chan->srej_q);
>> +	chan->rx_state = L2CAP_RX_STATE_RECV;
>> +}
>> +
>> +static int l2cap_tx_state_xmit(struct l2cap_chan *chan,
>> +			       struct l2cap_ctrl *control,
>> +			       struct sk_buff_head *skbs, u8 event)
>> +{
>> +	int err = 0;
>> +
>> +	BT_DBG("chan %p, control %p, skbs %p, event %d", chan, control, skbs,
>> +	       event);
>> +
>> +	switch (event) {
>> +	case L2CAP_EV_DATA_REQUEST:
>> +		if (chan->tx_send_head == NULL)
>> +			chan->tx_send_head = skb_peek(skbs);
>> +
>> +		skb_queue_splice_tail_init(skbs, &chan->tx_q);
>> +		l2cap_ertm_send(chan);
>> +		break;
>> +	case L2CAP_EV_LOCAL_BUSY_DETECTED:
>> +		BT_DBG("Enter LOCAL_BUSY");
>> +		set_bit(CONN_LOCAL_BUSY, &chan->conn_state);
>> +
>> +		if (chan->rx_state == L2CAP_RX_STATE_SREJ_SENT) {
>> +			/* The SREJ_SENT state must be aborted if we are to
>> +			 * enter the LOCAL_BUSY state.
>> +			 */
>> +			l2cap_abort_rx_srej_sent(chan);
>> +		}
>> +
>> +		l2cap_send_ack(chan);
>> +
>> +		break;
>> +	case L2CAP_EV_LOCAL_BUSY_CLEAR:
>> +		BT_DBG("Exit LOCAL_BUSY");
>> +		clear_bit(CONN_LOCAL_BUSY, &chan->conn_state);
>> +
>> +		if (test_bit(CONN_RNR_SENT, &chan->conn_state)) {
>> +			struct l2cap_ctrl local_control;
>> +
>> +			memset(&local_control, 0, sizeof(local_control));
>> +			local_control.sframe = 1;
>> +			local_control.super = L2CAP_SUPER_RR;
>> +			local_control.poll = 1;
>> +			local_control.reqseq = chan->buffer_seq;
>
> You are not using local_control anywhere? Should it be removed, or other patch
> in this patchset uses it?

Patch 5 uses it.  The next line (call to l2cap_send_sframe) is where 
it is used, but l2cap_send_sframe hasn't been modified to take an 
l2cap_ctrl pointer yet.

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
