Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 5/7] Bluetooth: Create recv_raw() channel callback
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1381950515-25256-5-git-send-email-gustavo@padovan.org>
Date: Thu, 17 Oct 2013 21:30:32 +0200
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Message-Id: <1B4DAD2B-A3E1-4833-89FC-5AFC89D5AB20@holtmann.org>
References: <1381950515-25256-1-git-send-email-gustavo@padovan.org> <1381950515-25256-5-git-send-email-gustavo@padovan.org>
To: Gustavo Padovan <gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> This new callback isolates socket specific code from L2CAP core.
> A dummy version of the callback, l2cap_chan_no_recv_raw() is provided for
> users that do not need to receive raw data.
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> ---
> include/net/bluetooth/l2cap.h |  8 ++++++++
> net/bluetooth/a2mp.c          |  1 +
> net/bluetooth/l2cap_core.c    | 12 +-----------
> net/bluetooth/l2cap_sock.c    | 22 ++++++++++++++++++++++
> 4 files changed, 32 insertions(+), 11 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 3d922b9..af5eb23 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -548,6 +548,8 @@ struct l2cap_ops {
> 	struct l2cap_chan	*(*new_connection) (struct l2cap_chan *chan);
> 	int			(*recv) (struct l2cap_chan * chan,
> 					 struct sk_buff *skb);
> +	int			(*recv_raw) (struct l2cap_chan * chan,
> +					 struct sk_buff *skb);
> 	void			(*teardown) (struct l2cap_chan *chan, int err);
> 	void			(*close) (struct l2cap_chan *chan);
> 	void			(*state_change) (struct l2cap_chan *chan,
> @@ -785,6 +787,12 @@ static inline struct l2cap_chan *l2cap_chan_no_new_connection(struct l2cap_chan
> 	return NULL;
> }
> 
> +static inline int l2cap_chan_no_recv_raw(struct l2cap_chan *chan,
> +					 struct sk_buff *skb)
> +{
> +	return 0;
> +}
> +
> static inline void l2cap_chan_no_teardown(struct l2cap_chan *chan, int err)
> {
> }
> diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
> index efcd108..72540a7 100644
> --- a/net/bluetooth/a2mp.c
> +++ b/net/bluetooth/a2mp.c
> @@ -707,6 +707,7 @@ static struct l2cap_ops a2mp_chan_ops = {
> 
> 	/* Not implemented for A2MP */
> 	.new_connection = l2cap_chan_no_new_connection,
> +	.recv_raw = l2cap_chan_no_recv_raw,
> 	.teardown = l2cap_chan_no_teardown,
> 	.ready = l2cap_chan_no_ready,
> 	.defer = l2cap_chan_no_defer,
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index e30a53a..45fcf5e 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -2797,7 +2797,6 @@ static void l2cap_pass_to_tx_fbit(struct l2cap_chan *chan,
> /* Copy frame to all raw sockets on that connection */
> static void l2cap_raw_recv(struct l2cap_conn *conn, struct sk_buff *skb)
> {
> -	struct sk_buff *nskb;
> 	struct l2cap_chan *chan;
> 
> 	BT_DBG("conn %p", conn);
> @@ -2805,19 +2804,10 @@ static void l2cap_raw_recv(struct l2cap_conn *conn, struct sk_buff *skb)
> 	mutex_lock(&conn->chan_lock);
> 
> 	list_for_each_entry(chan, &conn->chan_l, list) {
> -		struct sock *sk = chan->sk;
> 		if (chan->chan_type != L2CAP_CHAN_RAW)
> 			continue;
> 
> -		/* Don't send frame to the socket it came from */
> -		if (skb->sk == sk)
> -			continue;
> -		nskb = skb_clone(skb, GFP_KERNEL);
> -		if (!nskb)
> -			continue;
> -
> -		if (chan->ops->recv(chan, nskb))
> -			kfree_skb(nskb);
> +		chan->ops->recv_raw(chan, skb);
> 	}
> 
> 	mutex_unlock(&conn->chan_lock);
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index f5a7c66..b8be4fb 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -1078,6 +1078,27 @@ done:
> 	return err;
> }
> 
> +static int l2cap_sock_recv_raw_cb(struct l2cap_chan *chan, struct sk_buff *skb)
> +{
> +	struct sock *sk = chan->data;
> +	struct sk_buff *nskb;
> +	int err;
> +
> +	/* Don't send frame to the socket it came from */
> +	if (skb->sk == sk)
> +		return 0;
> +
> +	nskb = skb_clone(skb, GFP_KERNEL);
> +	if (!nskb)
> +		return -ENOMEM;
> +
> +	err = sock_queue_rcv_skb(sk, nskb);
> +	if (err < 0)
> +		kfree_skb(nskb);
> +
> +	return err;
> +}
> +

I do not much like the semantics here. So with recv callback, we essentially hand over the SKB to the callback. If they return 0, then it now owns that SKB. If it returns an error we take care of freeing it.

So recv_raw has different semantics now. We give it an SKB and it can not own it since we need for potential other listeners on the raw channel.

What I think we need to do is to skb_clone in l2cap_core.c and then give that SKB to the recv_raw function. Then if it returns 0, the functions own the skb now. And can give it to sock_queue_rcv_skb. If it returns an error the lcap_core.c caller takes care of freeing the SKB again.

The downside is that we now clone the SKB also for the same socket. However normally we do not have any L2CAP raw sockets anyway. So this penalty seems to be acceptable.

I wonder if it would make sense to have bt_skb_cb(skb)->chan to store the L2CAP channel of every packet we receive. And then we can handle this in l2cap_core.c.

Regards

Marcel

