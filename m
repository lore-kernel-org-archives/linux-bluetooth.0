Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 Apr 2012 11:46:43 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Manoj <manojkr.sharma@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org,
	Anurag Gupta <anurag.gupta@stericsson.com>
Subject: Re: [PATCH 1/2] Bluetooth: Fix L2CAP ERTM packet queue corruption
Message-ID: <20120425084641.GC23023@aemeltch-MOBL1>
References: <1335342544-17320-1-git-send-email-manojkr.sharma@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335342544-17320-1-git-send-email-manojkr.sharma@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Manoj,

On Wed, Apr 25, 2012 at 01:59:03PM +0530, Manoj wrote:
> While running in L2CAP ERTM mode, sometimes ERTM packet queue
> gets corrupted because though method l2cap_ertm_send() is not
> thread-safe, it is called simultaneously from multiple
> threads.

Could you give examples how queue is corrupted?

Best regards 
Andrei Emeltchenko 

> 
> Signed-off-by: Manoj <manojkr.sharma@stericsson.com>
> ---
>  net/bluetooth/l2cap_core.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 19807c9..a9319e2 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1713,6 +1713,7 @@ static int l2cap_ertm_send(struct l2cap_chan *chan)
>  	if (chan->state != BT_CONNECTED)
>  		return -ENOTCONN;
>  
> +	mutex_lock(&chan->conn->chan_lock);
>  	while ((skb = chan->tx_send_head) && (!l2cap_tx_window_full(chan))) {
>  
>  		if (chan->remote_max_tx &&
> @@ -1765,7 +1766,7 @@ static int l2cap_ertm_send(struct l2cap_chan *chan)
>  		else
>  			chan->tx_send_head = skb_queue_next(&chan->tx_q, skb);
>  	}
> -
> +	mutex_unlock(&chan->conn->chan_lock);
>  	return nsent;
>  }
>  
> -- 
> 1.6.6.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
