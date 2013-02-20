Return-Path: <cyrus@holtmann.org>
Message-ID: <1361395069.1583.81.camel@aeonflux>
Subject: Re: [PATCH 04/16] Bluetooth: add l2cap_state_change_and_error()
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Date: Wed, 20 Feb 2013 22:17:49 +0100
In-Reply-To: <1361391103-30738-5-git-send-email-gustavo@padovan.org>
References: <1361391103-30738-1-git-send-email-gustavo@padovan.org>
	 <1361391103-30738-5-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> Add helper to set both state and error at the same time.
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> ---
>  net/bluetooth/l2cap_core.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 775c83f..adf7fbb 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -228,9 +228,15 @@ static void l2cap_state_change(struct l2cap_chan *chan, int state)
>  	release_sock(sk);
>  }
>  
> -static inline void __l2cap_chan_set_err(struct l2cap_chan *chan, int err)
> +static void l2cap_state_change_and_error(struct l2cap_chan *chan, int state,
> +					 int err)
>  {
> -	chan->ops->state_change(chan, chan->state, err);
> +	struct sock *sk = chan->sk;
> +
> +	lock_sock(sk);
> +	chan->state = state;
> +	chan->ops->state_change(chan, state, err);
> +	release_sock(sk);
>  }

I really do not think this is a good idea. Why are we combining this.
You need to explain why this makes sense. Since I clearly do not see it
and would have kept it separate.

Regards

Marcel


