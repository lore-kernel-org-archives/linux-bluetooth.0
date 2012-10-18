Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Oct 2012 10:38:57 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	sunnyk@codeaurora.org, marcel@holtmann.org
Subject: Re: [PATCHv2 05/19] Bluetooth: Channel move request handling
Message-ID: <20121018073844.GD13545@aemeltch-MOBL1>
References: <1350430593-23565-1-git-send-email-mathewm@codeaurora.org>
 <1350430593-23565-6-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350430593-23565-6-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Tue, Oct 16, 2012 at 04:36:19PM -0700, Mat Martineau wrote:
> On receipt of a channel move request, the request must be validated
> based on the L2CAP mode, connection state, and controller
> capabilities.  ERTM channels must have their state machines cleared
> and transmission paused while the channel move takes place.
> 
> If the channel is being moved to an AMP controller then
> an AMP physical link must be prepared.  Moving the channel back to
> BR/EDR proceeds immediately.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/l2cap_core.c | 108 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 107 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index b5b849b..2fb0567 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -734,6 +734,12 @@ static void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len,
>  	hci_send_acl(conn->hchan, skb, flags);
>  }
>  
> +static bool __chan_is_moving(struct l2cap_chan *chan)
> +{
> +	return chan->move_state != L2CAP_MOVE_STABLE &&
> +	       chan->move_state != L2CAP_MOVE_WAIT_PREPARE;
> +}

this one looks good now

> +
>  static void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb)
>  {
>  	struct hci_conn *hcon = chan->conn->hcon;
> @@ -995,6 +1001,41 @@ void l2cap_send_conn_req(struct l2cap_chan *chan)
>  	l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_REQ, sizeof(req), &req);
>  }
>  
> +static void l2cap_move_setup(struct l2cap_chan *chan)
> +{
> +	struct sk_buff *skb;
> +
> +	BT_DBG("chan %p", chan);
> +
> +	if (chan->mode != L2CAP_MODE_ERTM)
> +		return;
> +
> +	__clear_retrans_timer(chan);
> +	__clear_monitor_timer(chan);
> +	__clear_ack_timer(chan);
> +
> +	chan->retry_count = 0;
> +	skb_queue_walk(&chan->tx_q, skb) {
> +		if (bt_cb(skb)->control.retries)
> +			bt_cb(skb)->control.retries = 1;
> +		else
> +			break;
> +	}
> +
> +	chan->expected_tx_seq = chan->buffer_seq;
> +
> +	clear_bit(CONN_REJ_ACT, &chan->conn_state);
> +	clear_bit(CONN_SREJ_ACT, &chan->conn_state);
> +	l2cap_seq_list_clear(&chan->retrans_list);
> +	l2cap_seq_list_clear(&chan->srej_list);
> +	skb_queue_purge(&chan->srej_q);
> +
> +	chan->tx_state = L2CAP_TX_STATE_XMIT;
> +	chan->rx_state = L2CAP_RX_STATE_MOVE;
> +
> +	set_bit(CONN_REMOTE_BUSY, &chan->conn_state);
> +}
> +
>  static void l2cap_chan_ready(struct l2cap_chan *chan)
>  {
>  	/* This clears all conf flags, including CONF_NOT_COMPLETE */
> @@ -4169,9 +4210,74 @@ static inline int l2cap_move_channel_req(struct l2cap_conn *conn,
>  	if (!enable_hs)
>  		return -EINVAL;
>  
> -	/* Placeholder: Always refuse */
> +	chan = l2cap_get_chan_by_dcid(conn, icid);
> +

extra line here

> +	if (!chan || chan->scid < L2CAP_CID_DYN_START ||
> +	    chan->chan_policy == BT_CHANNEL_POLICY_BREDR_ONLY ||
> +	    (chan->mode != L2CAP_MODE_ERTM &&
> +	     chan->mode != L2CAP_MODE_STREAMING)) {
> +		result = L2CAP_MR_NOT_ALLOWED;
> +		goto send_move_response;
> +	}
> +
> +	if (chan->local_amp_id == req->dest_amp_id) {
> +		result = L2CAP_MR_SAME_ID;
> +		goto send_move_response;
> +	}
> +
> +	if (req->dest_amp_id) {

here you compare "(val)"

> +		struct hci_dev *hdev;
> +		hdev = hci_dev_get(req->dest_amp_id);
> +		if (!hdev || hdev->dev_type != HCI_AMP ||
> +		    !test_bit(HCI_UP, &hdev->flags)) {
> +			if (hdev)
> +				hci_dev_put(hdev);
> +
> +			result = L2CAP_MR_BAD_ID;
> +			goto send_move_response;
> +		}
> +		hci_dev_put(hdev);
> +	}
> +
> +	/* Detect a move collision.  Only send a collision response
> +	 * if this side has "lost", otherwise proceed with the move.
> +	 * The winner has the larger bd_addr.
> +	 */
> +	if ((__chan_is_moving(chan) ||
> +	     chan->move_role != L2CAP_MOVE_ROLE_NONE) &&
> +	    bacmp(conn->src, conn->dst) > 0) {
> +		result = L2CAP_MR_COLLISION;
> +		goto send_move_response;
> +	}
> +
> +	chan->ident = cmd->ident;
> +	chan->move_role = L2CAP_MOVE_ROLE_RESPONDER;
> +	l2cap_move_setup(chan);
> +	chan->move_id = req->dest_amp_id;
> +	icid = chan->dcid;
> +
> +	if (req->dest_amp_id == 0) {

and here "(val == 0)"

I think it is better to use the single style "(val)"

> +		/* Moving to BR/EDR */
> +		if (test_bit(CONN_LOCAL_BUSY, &chan->conn_state)) {
> +			chan->move_state = L2CAP_MOVE_WAIT_LOCAL_BUSY;
> +			result = L2CAP_MR_PEND;
> +		} else {
> +			chan->move_state = L2CAP_MOVE_WAIT_CONFIRM;
> +			result = L2CAP_MR_SUCCESS;
> +		}
> +	} else {
> +		chan->move_state = L2CAP_MOVE_WAIT_PREPARE;
> +		/* Placeholder - uncomment when amp functions are available */
> +		/*amp_accept_physical(chan, req->dest_amp_id);*/
> +		result = L2CAP_MR_PEND;
> +	}
> +
> +send_move_response:
>  	l2cap_send_move_chan_rsp(conn, cmd->ident, icid, result);
>  
> +	if (chan)
> +		l2cap_chan_unlock(chan);
> +
>  	return 0;
>  }

Best regards 
Andrei Emeltchenko 
