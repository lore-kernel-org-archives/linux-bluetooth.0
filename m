Return-Path: <cyrus@holtmann.org>
Message-ID: <1338095051.15105.101.camel@aeonflux>
Subject: Re: [PATCH -v2 05/12] Bluetooth: Use chan->state instead of
 sk->sk_state
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Date: Sun, 27 May 2012 07:04:11 +0200
In-Reply-To: <1337949064-26187-6-git-send-email-gustavo@padovan.org>
References: <1337949064-26187-1-git-send-email-gustavo@padovan.org>
	 <1337949064-26187-6-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> These vars are kept in sync so we can use chan->state here.
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> ---
>  net/bluetooth/l2cap_core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 3d35210..53e21ca 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1444,7 +1444,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
>  
>  	lock_sock(sk);
>  
> -	switch (sk->sk_state) {
> +	switch (chan->state) {
>  	case BT_CONNECT:
>  	case BT_CONNECT2:
>  	case BT_CONFIG:

if this is so, then why are we bothering with the socket lock here?

Regards

Marcel


