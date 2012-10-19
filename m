Return-Path: <cyrus@holtmann.org>
Date: Fri, 19 Oct 2012 11:45:20 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	sunnyk@codeaurora.org, marcel@holtmann.org
Subject: Re: [PATCHv3 14/18] Bluetooth: Do not send data during channel move
Message-ID: <20121019084518.GK4249@aemeltch-MOBL1>
References: <1350583130-3241-1-git-send-email-mathewm@codeaurora.org>
 <1350583130-3241-15-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350583130-3241-15-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Thu, Oct 18, 2012 at 10:58:46AM -0700, Mat Martineau wrote:
> Outgoing ERTM data is queued during a channel move.  The ERTM state
> machine is partially reset at the start of a move, and must be
> resynchronized with the remote state machine at the end of the move.
> Data is not sent so that there are no state transitions between the
> partial reset and the resync.
> 
> Streaming mode frames are dropped during a move.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>

Acked-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com> 

> ---
>  net/bluetooth/l2cap_core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index a8fc10d..ab2bfc8 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -946,6 +946,9 @@ static void l2cap_send_sframe(struct l2cap_chan *chan,
>  	if (!control->sframe)
>  		return;
>  
> +	if (__chan_is_moving(chan))
> +		return;
> +
>  	if (test_and_clear_bit(CONN_SEND_FBIT, &chan->conn_state) &&
>  	    !control->poll)
>  		control->final = 1;
> @@ -1824,6 +1827,9 @@ static void l2cap_streaming_send(struct l2cap_chan *chan,
>  
>  	BT_DBG("chan %p, skbs %p", chan, skbs);
>  
> +	if (__chan_is_moving(chan))
> +		return;
> +
>  	skb_queue_splice_tail_init(skbs, &chan->tx_q);
>  
>  	while (!skb_queue_empty(&chan->tx_q)) {
> @@ -1866,6 +1872,9 @@ static int l2cap_ertm_send(struct l2cap_chan *chan)
>  	if (test_bit(CONN_REMOTE_BUSY, &chan->conn_state))
>  		return 0;
>  
> +	if (__chan_is_moving(chan))
> +		return 0;
> +
>  	while (chan->tx_send_head &&
>  	       chan->unacked_frames < chan->remote_tx_win &&
>  	       chan->tx_state == L2CAP_TX_STATE_XMIT) {
> @@ -1931,6 +1940,9 @@ static void l2cap_ertm_resend(struct l2cap_chan *chan)
>  	if (test_bit(CONN_REMOTE_BUSY, &chan->conn_state))
>  		return;
>  
> +	if (__chan_is_moving(chan))
> +		return;
> +
>  	while (chan->retrans_list.head != L2CAP_SEQ_LIST_CLEAR) {
>  		seq = l2cap_seq_list_pop(&chan->retrans_list);
>  
> -- 
> 1.7.12.3
> 
> --
> Mat Martineau
> 
> Employee of Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
