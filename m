Return-Path: <cyrus@holtmann.org>
Message-ID: <1328798620.28848.34.camel@aeonflux>
Subject: Re: [RFCv3 16/16] Bluetooth: Remove socket lock check
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 09 Feb 2012 15:43:40 +0100
In-Reply-To: <1328797057-26331-17-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328797057-26331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1328797057-26331-17-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Simplify code so that we do not need to check whether socket is locked.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_sock.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index ddac4cb..358975a 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -125,15 +125,15 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int al
>  
>  	err = l2cap_chan_connect(chan, la.l2_psm, la.l2_cid, &la.l2_bdaddr);
>  	if (err)
> -		goto done;
> +		return err;
>  
>  	lock_sock(sk);
>  
>  	err = bt_sock_wait_state(sk, BT_CONNECTED,
>  			sock_sndtimeo(sk, flags & O_NONBLOCK));
> -done:
> -	if (sock_owned_by_user(sk))
> -		release_sock(sk);
> +
> +	release_sock(sk);
> +

is this code change really equivalent?

Regards

Marcel


