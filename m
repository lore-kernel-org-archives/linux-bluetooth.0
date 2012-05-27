Return-Path: <cyrus@holtmann.org>
Message-ID: <1338095303.15105.104.camel@aeonflux>
Subject: Re: [PATCH -v2 08/12] Bluetooth: Add chan->ops->defer()
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Date: Sun, 27 May 2012 07:08:23 +0200
In-Reply-To: <1337949064-26187-9-git-send-email-gustavo@padovan.org>
References: <1337949064-26187-1-git-send-email-gustavo@padovan.org>
	 <1337949064-26187-9-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> When DEFER_SETUP is set defer() will trigger an authorization request
> to the userspace.
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> ---
>  include/net/bluetooth/l2cap.h |    1 +
>  net/bluetooth/l2cap_core.c    |   14 ++++++--------
>  net/bluetooth/l2cap_sock.c    |   12 ++++++++++++
>  3 files changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index c55b28f..25a85ab 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -535,6 +535,7 @@ struct l2cap_ops {
>  	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
>  					       unsigned long len, int nb);
>  	void			(*ready) (void *data);
> +	void			(*defer) (void *data);

I think this has been asked before, why not give l2cap_chan here. And
when called they can do chan->data for the specific data.

Regards

Marcel


