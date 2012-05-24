Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 May 2012 12:35:59 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [RFC 1/8] Bluetooth: Move clean up code and set of SOCK_ZAPPED
 to l2cap_sock.c
Message-ID: <20120524093557.GJ24715@aemeltch-MOBL1>
References: <1337821964-4618-1-git-send-email-gustavo@padovan.org>
 <1337821964-4618-2-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337821964-4618-2-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, May 23, 2012 at 10:12:37PM -0300, Gustavo Padovan wrote:
>  void l2cap_chan_close(struct l2cap_chan *chan, int reason)
>  {
>  	struct l2cap_conn *conn = chan->conn;
> @@ -583,12 +549,8 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
>  
>  	switch (chan->state) {
>  	case BT_LISTEN:
> -		lock_sock(sk);
> -		l2cap_chan_cleanup_listen(sk);
> -
> -		__l2cap_state_change(chan, BT_CLOSED);
> -		sock_set_flag(sk, SOCK_ZAPPED);
> -		release_sock(sk);
> +		if (chan->ops->finalize)
> +			chan->ops->finalize(chan->data, 0);

Looks like you are handling all cases so this can be put outside of
switch.

>  		break;
>  
>  	case BT_CONNECTED:
> @@ -630,9 +592,8 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
>  		break;
>  
>  	default:
> -		lock_sock(sk);
> -		sock_set_flag(sk, SOCK_ZAPPED);
> -		release_sock(sk);
> +		if (chan->ops->finalize)
> +			chan->ops->finalize(chan->data, 0);
>  		break;
>  	}
>  }
> @@ -3416,7 +3377,9 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
>  
>  	/* Check if we already have channel with that dcid */
>  	if (__l2cap_get_chan_by_dcid(conn, scid)) {
> -		sock_set_flag(sk, SOCK_ZAPPED);
> +		if (chan->ops->finalize)
> +			chan->ops->finalize(chan->data, 0);
> +
>  		chan->ops->close(chan->data);
>  		goto response;
>  	}
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 4d36605..0302cb4 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -872,6 +872,25 @@ static int l2cap_sock_release(struct socket *sock)
>  	return err;
>  }
>  
> +static void l2cap_sock_cleanup_listen(struct sock *parent)
> +{
> +	struct sock *sk;
> +
> +	BT_DBG("parent %p", parent);
> +
> +	/* Close not yet accepted channels */
> +	while ((sk = bt_accept_dequeue(parent, NULL))) {
> +		struct l2cap_chan *chan = l2cap_pi(sk)->chan;
> +
> +		l2cap_chan_lock(chan);
> +		__clear_chan_timer(chan);
> +		l2cap_chan_close(chan, ECONNRESET);
> +		l2cap_chan_unlock(chan);
> +
> +		l2cap_sock_kill(sk);
> +	}
> +}
> +
>  static struct l2cap_chan *l2cap_sock_new_connection_cb(void *data)
>  {
>  	struct sock *sk, *parent = data;
> @@ -931,6 +950,49 @@ static void l2cap_sock_close_cb(void *data)
>  	l2cap_sock_kill(sk);
>  }
>  
> +static void l2cap_sock_finalize_cb(void *data, int err)
> +{
> +	struct sock *sk = data;

Why we cannot just use l2cap_sock_finalize_cb(struct sock *sk, int err)
what is the reason for extra assignment?

I also think finalize is not good name since it does not mean what is
actually finalized.

Best regards 
Andrei Emeltchenko 

> +	struct sock *parent;
> +	struct l2cap_chan *chan;
> +
> +	lock_sock(sk);
> +
> +	parent = bt_sk(sk)->parent;
> +	chan = l2cap_pi(sk)->chan;
> +
> +	sock_set_flag(sk, SOCK_ZAPPED);
> +
> +	switch (chan->state) {
> +	case BT_OPEN:
> +	case BT_BOUND:
> +	case BT_CLOSED:
> +		break;
> +	case BT_LISTEN:
> +		l2cap_sock_cleanup_listen(sk);
> +		sk->sk_state = BT_CLOSED;
> +		chan->state = BT_CLOSED;
> +
> +		break;
> +	default:
> +		sk->sk_state = BT_CLOSED;
> +		chan->state = BT_CLOSED;
> +
> +		sk->sk_err = err;
> +
> +		if (parent) {
> +			bt_accept_unlink(sk);
> +			parent->sk_data_ready(parent, 0);
> +		} else {
> +			sk->sk_state_change(sk);
> +		}
> +
> +		break;
> +	}
> +
> +	release_sock(sk);
> +}
> +

