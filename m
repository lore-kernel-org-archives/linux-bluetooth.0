Return-Path: <cyrus@holtmann.org>
Message-ID: <1326138634.6454.161.camel@aeonflux>
Subject: Re: [PATCH 3/5] Bluetooth: Clear ack_timer when sending ack
From: Marcel Holtmann <marcel@holtmann.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com
Date: Mon, 09 Jan 2012 11:50:34 -0800
In-Reply-To: <1326122391-8438-4-git-send-email-szymon.janc@tieto.com>
References: <1326122391-8438-1-git-send-email-szymon.janc@tieto.com>
	 <1326122391-8438-4-git-send-email-szymon.janc@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> ack_timer should be cleared when sending ACK to avoid acking I-frames
> twice.

explain why you are creating a helper for it. Since that is clearly not
obvious to me.

> 
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> ---
>  net/bluetooth/l2cap_core.c |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 308d9d7..b9e232e 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1478,7 +1478,7 @@ static int l2cap_retransmit_frames(struct l2cap_chan *chan)
>  	return ret;
>  }
>  
> -static void l2cap_send_ack(struct l2cap_chan *chan)
> +static void __l2cap_send_ack(struct l2cap_chan *chan)
>  {
>  	u32 control = 0;
>  
> @@ -1498,6 +1498,12 @@ static void l2cap_send_ack(struct l2cap_chan *chan)
>  	l2cap_send_sframe(chan, control);
>  }
>  
> +static void l2cap_send_ack(struct l2cap_chan *chan)
> +{
> +	__clear_ack_timer(chan);
> +	__l2cap_send_ack(chan);
> +}
> +
>  static void l2cap_send_srejtail(struct l2cap_chan *chan)
>  {
>  	struct srej_list *tail;
> @@ -1988,7 +1994,7 @@ static void l2cap_ack_timeout(struct work_struct *work)
>  	BT_DBG("chan %p", chan);
>  
>  	lock_sock(chan->sk);

I would have just added

	__clear_ack_timer(chan):

here.

> -	l2cap_send_ack(chan);
> +	__l2cap_send_ack(chan);
>  	release_sock(chan->sk);
>  }
>  

Regards

Marcel


