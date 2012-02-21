Return-Path: <cyrus@holtmann.org>
Date: Tue, 21 Feb 2012 15:46:57 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv1 13/14] Bluetooth: Use l2cap chan lock in socket connect
Message-ID: <20120221174507.GA22229@joana>
References: <1329821707-11817-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1329821707-11817-14-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329821707-11817-14-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-02-21 12:55:06 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Function l2cap_chan_connect does not return with locked socket
> anymore. So we take explicit lock in l2cap_sock_connect.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   18 ++++++++++++++----
>  net/bluetooth/l2cap_sock.c |    2 ++
>  2 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 49aa226..9e0af6e 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1159,7 +1159,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid, bdaddr_t *d
>  
>  	hci_dev_lock(hdev);
>  
> -	lock_sock(sk);
> +	l2cap_chan_lock(chan);
>  
>  	/* PSM must be odd and lsb of upper byte must be 0 */
>  	if ((__le16_to_cpu(psm) & 0x0101) != 0x0001 && !cid &&
> @@ -1186,17 +1186,21 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid, bdaddr_t *d
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
> +		release_sock(sk);
>  		goto done;
>  
>  	case BT_CONNECTED:
>  		/* Already connected */
>  		err = -EISCONN;
> +		release_sock(sk);
>  		goto done;
>  
>  	case BT_OPEN:
> @@ -1206,11 +1210,15 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid, bdaddr_t *d
>  
>  	default:
>  		err = -EBADFD;
> +		release_sock(sk);
>  		goto done;
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
> @@ -1238,23 +1246,25 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid, bdaddr_t *d
>  	/* Update source addr of the socket */
>  	bacpy(src, conn->src);
>  
> +	l2cap_chan_unlock(chan);
>  	l2cap_chan_add(conn, chan);
> +	l2cap_chan_lock(chan);

What are you trying to do here?

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
> -

Do not remove this line, please.

	Gustavo
