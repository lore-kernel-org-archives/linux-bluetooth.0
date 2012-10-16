Return-Path: <cyrus@holtmann.org>
Date: Tue, 16 Oct 2012 13:21:36 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	sunnyk@codeaurora.org, marcel@holtmann.org
Subject: Re: [PATCH 06/19] Bluetooth: Add new ERTM receive states for channel
 move
Message-ID: <20121016102135.GF14036@aemeltch-MOBL1>
References: <1350315248-7690-1-git-send-email-mathewm@codeaurora.org>
 <1350315248-7690-7-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350315248-7690-7-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Mon, Oct 15, 2012 at 08:33:55AM -0700, Mat Martineau wrote:
> Two new states are required to implement channel moves with the ERTM
> receive state machine.
> 
> The "WAIT_P" state is used by a move responder to wait for a "poll"
> flag after a move is completed (success or failure).  "WAIT_F" is
> similarly used by a move initiator to wait for a "final" flag when the
> move is completing.  In either state, the reqseq value in the
> poll/final frame tells the state machine exactly which frame should be
> expected next.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap_core.c | 106 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 106 insertions(+)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 649c06b..aab7f79 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -5207,6 +5207,106 @@ static int l2cap_rx_state_srej_sent(struct l2cap_chan *chan,
>  	return err;
>  }
>  
> +static int l2cap_finish_move(struct l2cap_chan *chan)
> +{
> +	int err = 0;
> +
> +	BT_DBG("chan %p", chan);
> +
> +	chan->move_role = L2CAP_MOVE_ROLE_NONE;
> +	chan->rx_state = L2CAP_RX_STATE_RECV;
> +
> +	if (chan->hs_hcon)
> +		chan->conn->mtu = chan->hs_hcon->hdev->acl_mtu;

Should we use here block_mtu?

> +	else
> +		chan->conn->mtu = chan->conn->hcon->hdev->acl_mtu;
> +
> +	/* Placeholder - resegment based on new conn->mtu */
> +	/*err = l2cap_resegment(chan);*/
> +
> +	return err;
> +}
> +
> +static int l2cap_rx_state_wait_p(struct l2cap_chan *chan,
> +				 struct l2cap_ctrl *control,
> +				 struct sk_buff *skb, u8 event)
> +{
> +	int err = -EPROTO;
> +
> +	BT_DBG("chan %p, control %p, skb %p, event %d", chan, control, skb,
> +	       event);
> +
> +	if (!control->poll)
> +		return err;
> +
> +	l2cap_process_reqseq(chan, control->reqseq);
> +
> +	if (!skb_queue_empty(&chan->tx_q))
> +		chan->tx_send_head = skb_peek(&chan->tx_q);
> +	else
> +		chan->tx_send_head = NULL;
> +
> +	/* Rewind next_tx_seq to the point expected
> +	 * by the receiver.
> +	 */
> +	chan->next_tx_seq = control->reqseq;
> +	chan->unacked_frames = 0;
> +
> +	err = l2cap_finish_move(chan);
> +
> +	if (err)

extra new line

> +		return err;
> +
> +	set_bit(CONN_SEND_FBIT, &chan->conn_state);
> +	l2cap_send_i_or_rr_or_rnr(chan);
> +
> +	if (event == L2CAP_EV_RECV_IFRAME)
> +		err = -EPROTO;
> +	else
> +		err = l2cap_rx_state_recv(chan, control, NULL, event);
> +
> +	return err;
> +}
> +
> +static int l2cap_rx_state_wait_f(struct l2cap_chan *chan,
> +				 struct l2cap_ctrl *control,
> +				 struct sk_buff *skb, u8 event)
> +{
> +	int err = -EPROTO;
> +
> +	if (control->final) {
> +		clear_bit(CONN_REMOTE_BUSY, &chan->conn_state);
> +		chan->move_role = L2CAP_MOVE_ROLE_NONE;
> +
> +		chan->rx_state = L2CAP_RX_STATE_RECV;
> +		l2cap_process_reqseq(chan, control->reqseq);
> +
> +		if (!skb_queue_empty(&chan->tx_q))
> +			chan->tx_send_head = skb_peek(&chan->tx_q);
> +		else
> +			chan->tx_send_head = NULL;
> +
> +		/* Rewind next_tx_seq to the point expected
> +		 * by the receiver.
> +		 */
> +		chan->next_tx_seq = control->reqseq;
> +		chan->unacked_frames = 0;
> +
> +		if (chan->hs_hcon)
> +			chan->conn->mtu = chan->hs_hcon->hdev->acl_mtu;

block_mtu again

> +		else
> +			chan->conn->mtu = chan->conn->hcon->hdev->acl_mtu;
> +
> +		/* Placeholder - resegment based on new conn->mtu */
> +		/*err = l2cap_resegment(chan);*/
> +
> +		if (!err)
> +			err = l2cap_rx_state_recv(chan, control, skb, event);
> +	}
> +
> +	return err;
> +}
> +
>  static bool __valid_reqseq(struct l2cap_chan *chan, u16 reqseq)
>  {
>  	/* Make sure reqseq is for a packet that has been sent but not acked */
> @@ -5233,6 +5333,12 @@ static int l2cap_rx(struct l2cap_chan *chan, struct l2cap_ctrl *control,
>  			err = l2cap_rx_state_srej_sent(chan, control, skb,
>  						       event);
>  			break;
> +		case L2CAP_RX_STATE_WAIT_P:
> +			err = l2cap_rx_state_wait_p(chan, control, skb, event);
> +			break;
> +		case L2CAP_RX_STATE_WAIT_F:
> +			err = l2cap_rx_state_wait_f(chan, control, skb, event);
> +			break;
>  		default:
>  			/* shut it down */
>  			break;

Best regards 
Andrei Emeltchenko 
