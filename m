Return-Path: <cyrus@holtmann.org>
Message-ID: <1361394844.1583.78.camel@aeonflux>
Subject: Re: [PATCH 02/16] Bluetooth: Remove sk_sndtimeo from l2cap_core.c
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Date: Wed, 20 Feb 2013 22:14:04 +0100
In-Reply-To: <1361391103-30738-3-git-send-email-gustavo@padovan.org>
References: <1361391103-30738-1-git-send-email-gustavo@padovan.org>
	 <1361391103-30738-3-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> We now have a new struct member in l2cap_chan to store this value for
> access inside l2cap_core.c

more commit message explaining what is happening in this patch and why.

> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> ---
>  include/net/bluetooth/l2cap.h | 1 +
>  net/bluetooth/l2cap_core.c    | 7 +++----
>  net/bluetooth/l2cap_sock.c    | 1 +
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 6040743..cf94e68 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -480,6 +480,7 @@ struct l2cap_chan {
>  	__u8		tx_state;
>  	__u8		rx_state;
>  
> +	unsigned long	sndtimeo;

The socket one is long, why is this one unsigned long?

>  	unsigned long	conf_state;
>  	unsigned long	conn_state;
>  	unsigned long	flags;
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 4a88fa1..a306cc8 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -630,7 +630,7 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
>  	case BT_CONFIG:
>  		if (chan->chan_type == L2CAP_CHAN_CONN_ORIENTED &&
>  		    conn->hcon->type == ACL_LINK) {
> -			__set_chan_timer(chan, sk->sk_sndtimeo);
> +			__set_chan_timer(chan, chan->sndtimeo);
>  			l2cap_send_disconn_req(chan, reason);
>  		} else
>  			l2cap_chan_del(chan, reason);
> @@ -1602,7 +1602,6 @@ static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm,
>  int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
>  		       bdaddr_t *dst, u8 dst_type)
>  {
> -	struct sock *sk = chan->sk;
>  	bdaddr_t *src = &chan->src;
>  	struct l2cap_conn *conn;
>  	struct hci_conn *hcon;
> @@ -1716,7 +1715,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
>  	l2cap_chan_lock(chan);
>  
>  	l2cap_state_change(chan, BT_CONNECT);
> -	__set_chan_timer(chan, sk->sk_sndtimeo);
> +	__set_chan_timer(chan, chan->sndtimeo);
>  
>  	if (hcon->state == BT_CONNECTED) {
>  		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
> @@ -3641,7 +3640,7 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
>  
>  	dcid = chan->scid;
>  
> -	__set_chan_timer(chan, sk->sk_sndtimeo);
> +	__set_chan_timer(chan, chan->sndtimeo);
>  
>  	chan->ident = cmd->ident;
>  
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 0977966..221aef9 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -1178,6 +1178,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
>  
>  	/* Default config options */
>  	chan->flush_to = L2CAP_DEFAULT_FLUSH_TO;
> +	chan->sndtimeo = sk->sk_sndtimeo;

Explain to me how this actually works. Have you thought about
SO_SNDTIMEO socket option?

Regards

Marcel


