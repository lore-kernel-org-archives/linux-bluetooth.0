Return-Path: <cyrus@holtmann.org>
Date: Tue, 21 Feb 2012 15:51:47 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv1 14/14] Bluetooth: Remove socket lock check
Message-ID: <20120221175147.GB22229@joana>
References: <1329821707-11817-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1329821707-11817-15-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329821707-11817-15-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-02-21 12:55:07 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Simplify code so that we do not need to check whether socket is locked.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_sock.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index bbc1747..e2fc24b 100644
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
>  	return err;

Acked-by: Gustavo F. Padovan <padovan@profusion.mobi>

	Gustavo
