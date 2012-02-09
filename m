Return-Path: <cyrus@holtmann.org>
Message-ID: <1328797859.28848.23.camel@aeonflux>
Subject: Re: [RFCv3 06/16] Bluetooth: Add socket error function
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 09 Feb 2012 15:30:59 +0100
In-Reply-To: <1328797057-26331-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328797057-26331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1328797057-26331-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Use locked and unlocked versions to help removing socket
> locks from l2cap.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   30 +++++++++++++++++++++---------
>  1 files changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index a23c306..e6515b3 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -243,6 +243,22 @@ static void l2cap_state_change(struct l2cap_chan *chan, int state)
>  	release_sock(sk);
>  }
>  
> +static inline void __l2cap_set_sock_err(struct l2cap_chan *chan, int err)
> +{
> +	struct sock *sk = chan->sk;
> +
> +	sk->sk_err = err;
> +}
> +
> +static inline void l2cap_set_sock_err(struct l2cap_chan *chan, int err)
> +{
> +	struct sock *sk = chan->sk;
> +
> +	lock_sock(sk);
> +	__l2cap_set_sock_err(chan, err);
> +	release_sock(sk);
> +}

I think we better call this l2cap_chan_set_sock_err(). Sounds kinda
long, but makes it a bit more clearer what it does.

Regards

Marcel


