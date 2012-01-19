Return-Path: <cyrus@holtmann.org>
Message-ID: <1326966966.1955.3.camel@aeonflux>
Subject: Re: [RFCv3 05/34] Bluetooth: Allocate skb depending on sk
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 19 Jan 2012 10:56:06 +0100
In-Reply-To: <1326964823-26747-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1326964823-26747-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Some channels might not have sk so we allocate skbuff directly.
> The idea is to use l2cap_chan_send for sending packets not through
> sockets.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   34 +++++++++++++++++++++++++++-------
>  1 files changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 598805b..bc42ee8 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1531,7 +1531,12 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan, struct msghdr
>  	while (len) {
>  		count = min_t(unsigned int, conn->mtu, len);
>  
> -		*frag = bt_skb_send_alloc(sk, count, msg->msg_flags & MSG_DONTWAIT, &err);
> +		if (sk)
> +			*frag = bt_skb_send_alloc(sk, count,
> +					msg->msg_flags & MSG_DONTWAIT, &err);
> +		else
> +			*frag = bt_skb_alloc(count, GFP_KERNEL);
> +
>  		if (!*frag)
>  			return err;
>  		if (memcpy_fromiovec(skb_put(*frag, count), msg->msg_iov, count))
> @@ -1561,8 +1566,13 @@ static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan,
>  	BT_DBG("sk %p len %d priority %u", sk, (int)len, priority);
>  
>  	count = min_t(unsigned int, (conn->mtu - hlen), len);
> -	skb = bt_skb_send_alloc(sk, count + hlen,
> -			msg->msg_flags & MSG_DONTWAIT, &err);
> +
> +	if (sk)
> +		skb = bt_skb_send_alloc(sk, count + hlen,
> +					msg->msg_flags & MSG_DONTWAIT, &err);
> +	else
> +		skb = bt_skb_alloc(count, GFP_KERNEL);
> +
>  	if (!skb)
>  		return ERR_PTR(err);
>  
> @@ -1595,8 +1605,13 @@ static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
>  	BT_DBG("sk %p len %d", sk, (int)len);
>  
>  	count = min_t(unsigned int, (conn->mtu - hlen), len);
> -	skb = bt_skb_send_alloc(sk, count + hlen,
> -			msg->msg_flags & MSG_DONTWAIT, &err);
> +
> +	if (sk)
> +		skb = bt_skb_send_alloc(sk, count + hlen,
> +					msg->msg_flags & MSG_DONTWAIT, &err);
> +	else
> +		skb = bt_skb_alloc(count, GFP_KERNEL);
> +
>  	if (!skb)
>  		return ERR_PTR(err);
>  
> @@ -1642,8 +1657,13 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
>  		hlen += L2CAP_FCS_SIZE;
>  
>  	count = min_t(unsigned int, (conn->mtu - hlen), len);
> -	skb = bt_skb_send_alloc(sk, count + hlen,
> -			msg->msg_flags & MSG_DONTWAIT, &err);
> +
> +	if (sk)
> +		skb = bt_skb_send_alloc(sk, count + hlen,
> +					msg->msg_flags & MSG_DONTWAIT, &err);
> +	else
> +		skb = bt_skb_alloc(count, GFP_KERNEL);
> +
>  	if (!skb)
>  		return ERR_PTR(err);
>  

so I am not sure that I wanna change all these functions this way. It
might be a good way of handling this, but I am right now convinced.

Care to explain first on how you are using them.

Regards

Marcel


