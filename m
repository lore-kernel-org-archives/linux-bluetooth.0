Return-Path: <cyrus@holtmann.org>
Message-ID: <1328285397.2062.42.camel@aeonflux>
Subject: Re: [RFCv2 07/10] Bluetooth: Add socket error function
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 03 Feb 2012 08:09:57 -0800
In-Reply-To: <1328279789-10870-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328279789-10870-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1328279789-10870-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
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
>  net/bluetooth/l2cap_core.c |   23 +++++++++++++++++++----
>  1 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index cdc9d0c..79d6996 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -243,6 +243,20 @@ static void l2cap_state_change(struct l2cap_chan *chan, int state)
>  	release_sock(chan->sk);
>  }
>  
> +static inline void __l2cap_set_sock_err(struct sock *sk, int err)
> +{
> +	sk->sk_err = err;
> +}
> +
> +static inline void l2cap_set_sock_err(struct l2cap_chan *chan, int err)
> +{
> +	struct sock *sk = chan->sk;
> +
> +	lock_sock(sk);
> +	__l2cap_set_sock_err(sk, err);
> +	release_sock(sk);
> +}
> +

actually this is a bad idea. The parameters are different.

Regards

Marcel


