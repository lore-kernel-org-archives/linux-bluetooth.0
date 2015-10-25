Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH 4/5] Bluetooth: Fix locking of SCO channel to connection
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1444063459-28577-5-git-send-email-kubax.t.pawlak@intel.com>
Date: Mon, 26 Oct 2015 05:07:29 +0900
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <11198892-806D-45FF-975E-FF28F5AD555B@holtmann.org>
References: <088CC8BACB3382439E91D9919CE350243655EB71@IRSMSX107.ger.corp.intel.com> <1444063459-28577-1-git-send-email-kubax.t.pawlak@intel.com> <1444063459-28577-5-git-send-email-kubax.t.pawlak@intel.com>
To: Kuba Pawlak <kubax.t.pawlak@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kuba,

you need a commit message explaining this issue. Just a subject line is not enough.

> Signed-off-by: Kuba Pawlak <kubax.t.pawlak@intel.com>
> ---
> net/bluetooth/sco.c | 14 +++++++++-----
> 1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index 75f843d5423a4750f18f698a57130c6a96f71f23..bcc3c6d8066bba0b6d801fe8182734636bf6d94a 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -167,17 +167,19 @@ static void sco_conn_del(struct hci_conn *hcon, int err)
> 	/* Kill socket */
> 	sco_conn_lock(conn);
> 	sk = conn->sk;
> -	sco_conn_unlock(conn);
> 
> 	if (sk) {
> 		sock_hold(sk);
> 		bh_lock_sock(sk);
> +		sco_conn_unlock(conn);
> 		sco_sock_clear_timer(sk);
> 		sco_chan_del(sk, err);
> 		bh_unlock_sock(sk);
> 		sco_sock_kill(sk);
> 		sock_put(sk);
> 	}
> +	else
> +		sco_conn_unlock(conn);

so the coding style is all off here. That needs fixing first.

I however wonder if this would not be cleaner to read in the end.

	if (sk) {
		sock_hold(sk);
		bh_lock_sock(sk);
	}

	sco_conn_unlock(conn);

	if (sk) }
		sco_sock_clear_timer(sk);
		..
	}

And then again, why do we need bh_lock_sock in the first place. The packet process running is no longer running in a tasklet in the first place. I am pretty certain that this is not needed. Might want to look into getting rid of the bh_lock_sock and replacing them with something saner.

> 
> 	hcon->sco_data = NULL;
> 	kfree(conn);
> @@ -1012,10 +1014,13 @@ static int sco_sock_release(struct socket *sock)
> static void sco_conn_ready(struct sco_conn *conn)
> {
> 	struct sock *parent;
> -	struct sock *sk = conn->sk;
> +	struct sock *sk;
> 
> 	BT_DBG("conn %p", conn);
> 
> +	sco_conn_lock(conn);
> +	sk = conn->sk;
> +
> 	if (sk) {
> 		sco_sock_clear_timer(sk);
> 		bh_lock_sock(sk);
> @@ -1023,7 +1028,6 @@ static void sco_conn_ready(struct sco_conn *conn)
> 		sk->sk_state_change(sk);
> 		bh_unlock_sock(sk);
> 	} else {
> -		sco_conn_lock(conn);
> 
> 		parent = sco_get_sock_listen(&conn->hcon->src);
> 		if (!parent) {
> @@ -1058,9 +1062,9 @@ static void sco_conn_ready(struct sco_conn *conn)
> 		parent->sk_data_ready(parent);
> 
> 		bh_unlock_sock(parent);
> -
> -		sco_conn_unlock(conn);
> 	}
> +
> +	sco_conn_unlock(conn);
> }

This one seems fine, However again, we are no longer running in a tasklet, so bh_lock_sock seems like something to be replaced.

Regards

Marcel

