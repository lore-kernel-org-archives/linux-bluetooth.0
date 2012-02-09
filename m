Return-Path: <cyrus@holtmann.org>
Message-ID: <1328798536.28848.33.camel@aeonflux>
Subject: Re: [RFCv3 15/16] Bluetooth: Use l2cap chan lock in socket connect
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 09 Feb 2012 15:42:16 +0100
In-Reply-To: <1328797057-26331-16-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328797057-26331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1328797057-26331-16-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   24 ++++++++++++++++++------
>  net/bluetooth/l2cap_sock.c |    2 ++
>  2 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 2b97cf7..bb390ec 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1182,7 +1182,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid, bdaddr_t *d
>  
>  	hci_dev_lock(hdev);
>  
> -	lock_sock(sk);
> +	l2cap_chan_lock(chan);
>  
>  	/* PSM must be odd and lsb of upper byte must be 0 */
>  	if ((__le16_to_cpu(psm) & 0x0101) != 0x0001 && !cid &&
> @@ -1209,18 +1209,20 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid, bdaddr_t *d
>  		goto done;
>  	}
>  
> +	lock_sock(sk);
> +
>  	switch (sk->sk_state) {
>  	case BT_CONNECT:
>  	case BT_CONNECT2:
>  	case BT_CONFIG:
>  		/* Already connecting */
>  		err = 0;
> -		goto done;
> +		goto sock_release;
>  
>  	case BT_CONNECTED:
>  		/* Already connected */
>  		err = -EISCONN;
> -		goto done;
> +		goto sock_release;
>  
>  	case BT_OPEN:
>  	case BT_BOUND:
> @@ -1229,11 +1231,14 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid, bdaddr_t *d
>  
>  	default:
>  		err = -EBADFD;
> -		goto done;
> +		goto sock_release;
>  	}
>  
>  	/* Set destination address and psm */
>  	bacpy(&bt_sk(sk)->dst, dst);
> +
> +	release_sock(sk);
> +
>  	chan->psm = psm;
>  	chan->dcid = cid;
>  
> @@ -1261,23 +1266,30 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid, bdaddr_t *d
>  	/* Update source addr of the socket */
>  	bacpy(src, conn->src);
>  
> +	l2cap_chan_unlock(chan);
>  	l2cap_chan_add(conn, chan);
> +	l2cap_chan_lock(chan);
>  
> -	__l2cap_state_change(chan, BT_CONNECT);
> +	l2cap_state_change(chan, BT_CONNECT);
>  	__set_chan_timer(chan, sk->sk_sndtimeo);
>  
>  	if (hcon->state == BT_CONNECTED) {
>  		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
>  			__clear_chan_timer(chan);
>  			if (l2cap_chan_check_security(chan))
> -				__l2cap_state_change(chan, BT_CONNECTED);
> +				l2cap_state_change(chan, BT_CONNECTED);
>  		} else
>  			l2cap_do_start(chan);
>  	}
>  
>  	err = 0;
> +	goto done;
> +
> +sock_release:
> +	release_sock(sk);

I don't like this jumping. Just use release_sock(sk) directly in the
error path above.

And I think we need to simplify this function a little bit and maybe
split it into more logical pieces.

Regards

Marcel


