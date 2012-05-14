Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 May 2012 12:52:46 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	marcel@holtmann.org, pkrystad@codeaurora.org,
	ulisses@profusion.mobi
Subject: Re: [PATCH 4/4] Bluetooth: Refactor L2CAP ERTM and streaming
 transmit segmentation
Message-ID: <20120514095244.GA10127@aemeltch-MOBL1>
References: <1335976922-19456-1-git-send-email-mathewm@codeaurora.org>
 <1335976922-19456-5-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335976922-19456-5-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Wed, May 02, 2012 at 09:42:02AM -0700, Mat Martineau wrote:
> Use more common code for ERTM and streaming mode segmentation and
> transmission, and begin using skb control block data for delaying
> extended or enhanced header generation until just before the packet is
> transmitted.  This code is also better suited for resegmentation,
> which is needed when L2CAP links are reconfigured after an AMP channel
> move.

...
> @@ -1708,6 +1709,9 @@ static int l2cap_ertm_send(struct l2cap_chan *chan)
>  	if (chan->state != BT_CONNECTED)
>  		return -ENOTCONN;
>  
> +	if (test_bit(CONN_REMOTE_BUSY, &chan->conn_state))
> +		return 0;
> +
>  	while ((skb = chan->tx_send_head) && (!l2cap_tx_window_full(chan))) {

We check here chan->tx_send_head. But:

...
> -	skb_queue_splice_tail(&sar_queue, &chan->tx_q);
> -	if (chan->tx_send_head == NULL)
> -		chan->tx_send_head = sar_queue.next;
...

> -
> -			if (chan->tx_send_head == NULL)
> -				chan->tx_send_head = skb;
...

tx_send_head seems to be always NULL due to the change above. Have you
tested that it actually works?

Best regards 
Andrei Emeltchenko 
