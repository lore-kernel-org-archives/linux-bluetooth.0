Return-Path: <cyrus@holtmann.org>
Message-ID: <1338177544.15105.118.camel@aeonflux>
Subject: Re: [PATCH -v3 05/10] Bluetooth: Move check for backlog size to
 l2cap_sock.c
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Date: Mon, 28 May 2012 05:59:04 +0200
In-Reply-To: <1338168480-9646-5-git-send-email-gustavo@padovan.org>
References: <1338168480-9646-1-git-send-email-gustavo@padovan.org>
	 <1338168480-9646-5-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> Remove socket specific code from l2cap_core.c
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> Acked-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   12 ------------
>  net/bluetooth/l2cap_sock.c |    6 ++++++
>  2 files changed, 6 insertions(+), 12 deletions(-)

I applied this the first 5 patches to bluetooth-next so far.

<snip>

> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 5563023..d856cc8 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -895,6 +895,12 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
>  {
>  	struct sock *sk, *parent = chan->data;
>  
> +	/* Check for backlog size */
> +	if (sk_acceptq_is_full(parent)) {
> +		BT_DBG("backlog full %d", parent->sk_ack_backlog);
> +		return NULL;
> +	}
> +
>  	sk = l2cap_sock_alloc(sock_net(parent), NULL, BTPROTO_L2CAP,
>  								GFP_ATOMIC);
>  	if (!sk)

And on a side note, does this still have to be GFP_ATOMIC?

Regards

Marcel


