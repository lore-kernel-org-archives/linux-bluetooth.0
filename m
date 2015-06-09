Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com, Joshua_Frkuska@mentor.com
Subject: Re: [PATCH v1 3/7] Bluetooth: Unwind l2cap_sock_shutdown()
Date: Tue, 09 Jun 2015 11:55:40 +0200
Message-ID: <3313217.oq1TWQmj1d@leonov>
In-Reply-To: <1433545876-15800-4-git-send-email-Dean_Jenkins@mentor.com>
References: <1433545876-15800-1-git-send-email-Dean_Jenkins@mentor.com> <1433545876-15800-4-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dean,

On Saturday 06 of June 2015 00:11:12 Dean Jenkins wrote:
> l2cap_sock_shutdown() is designed to only action shutdown
> of the channel when shutdown is not already in progress.
> Therefore, reorganise the code flow by adding a goto
> to jump to the end of function handling when shutdown is
> already being actioned. This removes one level of code
> indentation and make the code more readable.
> 
> Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
> ---
>  net/bluetooth/l2cap_sock.c | 44
> ++++++++++++++++++++++++-------------------- 1 file changed, 24
> insertions(+), 20 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index c909f45..8550886 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -1099,6 +1099,13 @@ static int l2cap_sock_shutdown(struct socket *sock,
> int how) if (!sk)
>  		return 0;
> 
> +	lock_sock(sk);
> +
> +	if (sk->sk_shutdown)
> +		goto shutdown_already;
> +
> +	sk->sk_shutdown = SHUTDOWN_MASK;
> +
>  	/* prevent sk structure from being freed whilst unlocked */
>  	sock_hold(sk);
> 
> @@ -1113,30 +1120,21 @@ static int l2cap_sock_shutdown(struct socket *sock,
> int how) mutex_lock(&conn->chan_lock);
> 
>  	l2cap_chan_lock(chan);
> -	lock_sock(sk);
> 
> -	if (!sk->sk_shutdown) {
> -		if (chan->mode == L2CAP_MODE_ERTM &&
> -		    chan->unacked_frames > 0 &&
> -		    chan->state == BT_CONNECTED)
> -			err = __l2cap_wait_ack(sk, chan);
> +	if (chan->mode == L2CAP_MODE_ERTM &&
> +	    chan->unacked_frames > 0 &&
> +	    chan->state == BT_CONNECTED)
> +		err = __l2cap_wait_ack(sk, chan);
> 
> -		sk->sk_shutdown = SHUTDOWN_MASK;
> -
> -		release_sock(sk);
> -		l2cap_chan_close(chan, 0);
> -		lock_sock(sk);
> -
> -		if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime &&
> -		    !(current->flags & PF_EXITING))
> -			err = bt_sock_wait_state(sk, BT_CLOSED,
> -						 sk->sk_lingertime);
> -	}
> +	release_sock(sk);
> +	l2cap_chan_close(chan, 0);
> +	lock_sock(sk);
> 
> -	if (!err && sk->sk_err)
> -		err = -sk->sk_err;
> +	if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime &&
> +	    !(current->flags & PF_EXITING))
> +		err = bt_sock_wait_state(sk, BT_CLOSED,
> +					 sk->sk_lingertime);
> 
> -	release_sock(sk);
>  	l2cap_chan_unlock(chan);
> 
>  	if (conn)
> @@ -1146,6 +1144,12 @@ static int l2cap_sock_shutdown(struct socket *sock,
> int how) l2cap_chan_put(chan);
>  	sock_put(sk);

Isn't it possible that sk will be freed here? (at least this is what comment 
from patch 1 suggests).

> 
> +shutdown_already:
> +	if (!err && sk->sk_err)
> +		err = -sk->sk_err;
> +
> +	release_sock(sk);
> +
>  	return err;
>  }

-- 
BR
Szymon Janc
