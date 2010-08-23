Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Aug 2010 19:45:27 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 2/2] Bluetooth: timer check sk is not owned before
 freeing
Message-ID: <20100823224527.GA9062@vigoh>
References: <1281619537-30096-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1281619537-30096-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1281619537-30096-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2010-08-12 16:25:37 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> 
> In timer context we might delete l2cap channel used by krfcommd.
> The check makes sure that sk is not owned.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> ---
>  net/bluetooth/l2cap.c |   32 ++++++++++++++++++++------------
>  1 files changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index 0221d05..2f8ac5d 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -73,6 +73,18 @@ static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn,
>  				u8 code, u8 ident, u16 dlen, void *data);
>  
>  /* ---- L2CAP timers ---- */
> +static void l2cap_sock_set_timer(struct sock *sk, long timeout)
> +{
> +	BT_DBG("sk %p state %d timeout %ld", sk, sk->sk_state, timeout);
> +	sk_reset_timer(sk, &sk->sk_timer, jiffies + timeout);
> +}
> +
> +static void l2cap_sock_clear_timer(struct sock *sk)
> +{
> +	BT_DBG("sock %p state %d", sk, sk->sk_state);
> +	sk_stop_timer(sk, &sk->sk_timer);
> +}
> +
>  static void l2cap_sock_timeout(unsigned long arg)
>  {
>  	struct sock *sk = (struct sock *) arg;
> @@ -82,6 +94,14 @@ static void l2cap_sock_timeout(unsigned long arg)
>  
>  	bh_lock_sock(sk);
>  
> +	if (sock_owned_by_user(sk)) {
> +		/* sk is owned by user. Try again later */
> +		l2cap_sock_set_timer(sk, HZ * 2);
> +		bh_unlock_sock(sk);
> +		sock_put(sk);
> +		return;
> +	}

I'm not sure if I like this defer through timers. OTOH could be too much
overhead to do this defer through a work queue.
Also I think that 2 seconds is too much for this timer. 200 miliseconds
should be enough, what do you think?

-- 
Gustavo F. Padovan
http://padovan.org
