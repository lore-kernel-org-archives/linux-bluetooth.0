Return-Path: <cyrus@holtmann.org>
Date: Mon, 13 Jul 2015 14:07:31 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	Joshua_Frkuska@mentor.com
Subject: Re: [PATCH v2 3/8] Bluetooth: Unwind l2cap_sock_shutdown()
Message-ID: <20150713110731.GA21598@t440s.lan>
References: <1435078779-4436-1-git-send-email-Dean_Jenkins@mentor.com>
 <1435078779-4436-4-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1435078779-4436-4-git-send-email-Dean_Jenkins@mentor.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dean,

On Tue, Jun 23, 2015, Dean Jenkins wrote:
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -1100,6 +1100,13 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
>  	if (!sk)
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
> @@ -1114,30 +1121,21 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
>  		mutex_lock(&conn->chan_lock);
>  
>  	l2cap_chan_lock(chan);
> -	lock_sock(sk);

I guess this is at least part of the reason for the lockdep warnings we
started getting after your patches. The order of these locks should
always be l2cap_chan_lock() and then lock_sock(). Any other order
exposes us to potential deadlocks and the kernel lockdep system rightly
warns about it.

Do you think you'll be able to fix this as well as the missing
mutex_lock(&conn->chan_lock) issue this week? Otherwise we'll need to
consider reverting your patches since it's quite clear we can't make any
bluetooth-next pull requests with the current state of the tree.

Johan
