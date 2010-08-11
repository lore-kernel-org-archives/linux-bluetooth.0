Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
Date: Wed, 11 Aug 2010 00:35:41 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [RFC 3/7] Bluetooth: Add FCS awareness to L2CAP HCI
 fragmentation.
Message-ID: <20100811033540.GA9151@vigoh>
References: <1281467704-5378-1-git-send-email-mathewm@codeaurora.org>
 <1281467704-5378-4-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1281467704-5378-4-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

* Mat Martineau <mathewm@codeaurora.org> [2010-08-10 12:15:00 -0700]:

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
>  
> -		*frag = bt_skb_send_alloc(sk, count, msg->msg_flags & MSG_DONTWAIT, &err);
> +		/* Add room for the FCS if it fits */
> +		if (l2cap_pi(sk)->fcs == L2CAP_FCS_CRC16 &&
> +		    len + L2CAP_FCS_SIZE <= conn->mtu)

You don't need to check for (len + L2CAP_FCS_SIZE <= conn=mtu) here.
Section 5.1 point that: 

"Unlike the B-Frame length field, the I-frame length field may be greater
than the configured MTU because it includes the octet lengths of the
Control, L2CAP SDU Length (when present), and frame check sequence
fields as well as the Information octets."

>From that I understand "len <=" and not "len + L2CAP_FCS_SIZE <="


> +			skblen = count + L2CAP_FCS_SIZE;
> +		else
> +			skblen = count;
> +
> +		*frag = bt_skb_send_alloc(sk, skblen,
> +					msg->msg_flags & MSG_DONTWAIT, &err);
>  		if (!*frag)
>  			return -EFAULT;
> -		if (memcpy_fromiovec(skb_put(*frag, count), msg->msg_iov, count))
> +
> +		if (memcpy_fromiovec(skb_put(*frag, count),
> +				msg->msg_iov, count))
>  			return -EFAULT;
>  
>  		sent += count;
>  		len  -= count;
>  
> +		final = *frag;
> +
>  		frag = &(*frag)->next;
>  	}
>  
> +	if (l2cap_pi(sk)->fcs == L2CAP_FCS_CRC16) {
> +		if (skb_tailroom(final) < L2CAP_FCS_SIZE) {
> +			*frag = bt_skb_send_alloc(sk, L2CAP_FCS_SIZE,
> +						msg->msg_flags & MSG_DONTWAIT,
> +						&err);
> +			if (!*frag)
> +				return -EFAULT;
> +
> +			final = *frag;
> +		}
> +
> +		skb_put(final, L2CAP_FCS_SIZE);
> +	}
> +
>  	return sent;
>  }
>  
> @@ -1790,9 +1822,6 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct sock *sk, struct msghdr *m
>  		return ERR_PTR(err);
>  	}
>  
> -	if (l2cap_pi(sk)->fcs == L2CAP_FCS_CRC16)
> -		put_unaligned_le16(0, skb_put(skb, 2));
> -
>  	bt_cb(skb)->retries = 0;
>  	return skb;
>  }
> -- 
> 1.7.1
> 
> --
> Mat Martineau
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

-- 
Gustavo F. Padovan
http://padovan.org
