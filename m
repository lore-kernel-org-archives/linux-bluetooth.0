Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC 3/7] Bluetooth: Add FCS awareness to L2CAP HCI
 fragmentation.
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <1281467704-5378-4-git-send-email-mathewm@codeaurora.org>
References: <1281467704-5378-1-git-send-email-mathewm@codeaurora.org>
	 <1281467704-5378-4-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 10 Aug 2010 17:29:14 -0400
Message-ID: <1281475754.12579.228.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> In order to not limit ERTM and streaming mode PDUs to the HCI MTU
> size, L2CAP must be able to split PDUs in to multple HCI fragments.
> This is done by allocating space for the FCS in the last fragment.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap.c |   39 ++++++++++++++++++++++++++++++++++-----
>  1 files changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index aa69c84..b485c4a 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -1664,31 +1664,63 @@ static inline int l2cap_skbuff_fromiovec(struct sock *sk, struct msghdr *msg, in
>  {
>  	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
>  	struct sk_buff **frag;
> +	struct sk_buff *final;
>  	int err, sent = 0;
>  
> +	BT_DBG("sk %p, msg %p, len %d, count %d, skb %p", sk,
> +		msg, (int)len, (int)count, skb);
> +
>  	if (memcpy_fromiovec(skb_put(skb, count), msg->msg_iov, count))
>  		return -EFAULT;
>  
>  	sent += count;
>  	len  -= count;
> +	final = skb;
>  
>  	/* Continuation fragments (no L2CAP header) */
>  	frag = &skb_shinfo(skb)->frag_list;
>  	while (len) {
> +		int skblen;
>  		count = min_t(unsigned int, conn->mtu, len);

I prefer that you either make the int skblen global or add an empty
line. There should be always an empty line between variable declaration
and code.

>  
> -		*frag = bt_skb_send_alloc(sk, count, msg->msg_flags & MSG_DONTWAIT, &err);
> +		/* Add room for the FCS if it fits */
> +		if (l2cap_pi(sk)->fcs == L2CAP_FCS_CRC16 &&
> +		    len + L2CAP_FCS_SIZE <= conn->mtu)
> +			skblen = count + L2CAP_FCS_SIZE;

So in general we do double indent for the second line of the if:

		if (l2cap_pi ...
				len + ...
			skblen = count ...

This is not strictly enforced and every kernel code does it a little bit
different.

The rest looks just fine.

Regards

Marcel


