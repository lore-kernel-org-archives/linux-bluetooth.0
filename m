Return-Path: <cyrus@holtmann.org>
Message-ID: <1326979849.1955.15.camel@aeonflux>
Subject: Re: [RFC] Bluetooth: Add alloc_skb chan operator
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 19 Jan 2012 14:30:49 +0100
In-Reply-To: <1326978832-9888-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1326978832-9888-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Add channel-specific skb allocation method
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/l2cap.h |    3 +++
>  net/bluetooth/l2cap_core.c    |   22 +++++++++++++++-------
>  net/bluetooth/l2cap_sock.c    |    9 +++++++++
>  3 files changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 34a882b..ed390ad 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -506,6 +506,9 @@ struct l2cap_ops {
>  	int			(*recv) (void *data, struct sk_buff *skb);
>  	void			(*close) (void *data);
>  	void			(*state_change) (void *data, int state);
> +	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
> +					unsigned long len, int nb, int *err);
> +
>  };
>  
>  struct l2cap_conn {
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 598805b..f9bd130 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1531,7 +1531,9 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan, struct msghdr
>  	while (len) {
>  		count = min_t(unsigned int, conn->mtu, len);
>  
> -		*frag = bt_skb_send_alloc(sk, count, msg->msg_flags & MSG_DONTWAIT, &err);
> +		*frag = chan->ops->alloc_skb(chan, count,
> +					msg->msg_flags & MSG_DONTWAIT, &err);
> +
>  		if (!*frag)
>  			return err;
>  		if (memcpy_fromiovec(skb_put(*frag, count), msg->msg_iov, count))
> @@ -1561,8 +1563,10 @@ static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan,
>  	BT_DBG("sk %p len %d priority %u", sk, (int)len, priority);
>  
>  	count = min_t(unsigned int, (conn->mtu - hlen), len);
> -	skb = bt_skb_send_alloc(sk, count + hlen,
> -			msg->msg_flags & MSG_DONTWAIT, &err);
> +
> +	skb = chan->ops->alloc_skb(chan, count + hlen,
> +					msg->msg_flags & MSG_DONTWAIT, &err);
> +
>  	if (!skb)
>  		return ERR_PTR(err);
>  
> @@ -1595,8 +1599,10 @@ static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
>  	BT_DBG("sk %p len %d", sk, (int)len);
>  
>  	count = min_t(unsigned int, (conn->mtu - hlen), len);
> -	skb = bt_skb_send_alloc(sk, count + hlen,
> -			msg->msg_flags & MSG_DONTWAIT, &err);
> +
> +	skb = chan->ops->alloc_skb(chan, count + hlen,
> +					msg->msg_flags & MSG_DONTWAIT, &err);
> +
>  	if (!skb)
>  		return ERR_PTR(err);
>  
> @@ -1642,8 +1648,10 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
>  		hlen += L2CAP_FCS_SIZE;
>  
>  	count = min_t(unsigned int, (conn->mtu - hlen), len);
> -	skb = bt_skb_send_alloc(sk, count + hlen,
> -			msg->msg_flags & MSG_DONTWAIT, &err);
> +
> +	skb = chan->ops->alloc_skb(chan, count + hlen,
> +					msg->msg_flags & MSG_DONTWAIT, &err);
> +
>  	if (!skb)
>  		return ERR_PTR(err);
>  
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index c57027f..4640c12 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -897,12 +897,21 @@ static void l2cap_sock_state_change_cb(void *data, int state)
>  	sk->sk_state = state;
>  }
>  
> +static struct sk_buff *l2cap_sock_alloc_skb_cb(struct l2cap_chan *chan,
> +					unsigned long len, int nb, int *err)
> +{
> +	struct sock *sk = chan->sk;
> +
> +	return bt_skb_send_alloc(sk, len, nb, err);
> +}
> +
>  static struct l2cap_ops l2cap_chan_ops = {
>  	.name		= "L2CAP Socket Interface",
>  	.new_connection	= l2cap_sock_new_connection_cb,
>  	.recv		= l2cap_sock_recv_cb,
>  	.close		= l2cap_sock_close_cb,
>  	.state_change	= l2cap_sock_state_change_cb,
> +	.alloc_skb	= l2cap_sock_alloc_skb_cb,
>  };
>  
>  static void l2cap_sock_destruct(struct sock *sk)

if nobody else objects here, then I am fine with. It does have one extra
indirection that is a bit of a downside, but we might wanna go with it
for now and figure out the rest later.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


