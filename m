Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
Date: Wed, 11 Aug 2010 01:25:43 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [RFC 5/7] Bluetooth: Handle fragmented skbs in
 bt_sock_stream_recvmsg()
Message-ID: <20100811042543.GA9428@vigoh>
References: <1281467704-5378-1-git-send-email-mathewm@codeaurora.org>
 <1281467704-5378-6-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1281467704-5378-6-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2010-08-10 12:15:02 -0700]:

> When reading L2CAP skbuffs, add the ability to copy from
> fragmented skbuffs generated during ERTM or streaming mode
> reassembly.  This defers extra copying of L2CAP payloads
> until the final, unavoidable copy to userspace.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/af_bluetooth.c |   30 ++++++++++++++++++++++++++++--
>  1 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> index 77a26fe..5e0375b 100644
> --- a/net/bluetooth/af_bluetooth.c
> +++ b/net/bluetooth/af_bluetooth.c
> @@ -342,7 +342,7 @@ int bt_sock_stream_recvmsg(struct kiocb *iocb, struct socket *sock,
>  		}
>  
>  		chunk = min_t(unsigned int, skb->len, size);
> -		if (memcpy_toiovec(msg->msg_iov, skb->data, chunk)) {
> +		if (skb_copy_datagram_iovec(skb, 0, msg->msg_iov, chunk)) {
>  			skb_queue_head(&sk->sk_receive_queue, skb);
>  			if (!copied)
>  				copied = -EFAULT;
> @@ -354,7 +354,33 @@ int bt_sock_stream_recvmsg(struct kiocb *iocb, struct socket *sock,
>  		sock_recv_ts_and_drops(msg, sk, skb);
>  
>  		if (!(flags & MSG_PEEK)) {
> -			skb_pull(skb, chunk);
> +			int skb_len = skb_headlen(skb);

Why are you using the header length here?

> +
> +			if (chunk <= skb_len) {
> +				__skb_pull(skb, chunk);
> +			} else {
> +				struct sk_buff *frag;
> +
> +				__skb_pull(skb, skb_len);
> +				chunk -= skb_len;

Why do we have this __skb_pull() here? I think skb_walk_frags() can
handle everything.

> +
> +				skb_walk_frags(skb, frag) {
> +					if (chunk <= frag->len) {
> +						/* Pulling partial data */
> +						skb->len -= chunk;
> +						skb->data_len -= chunk;
> +						__skb_pull(frag, chunk);
> +						break;

If we break here what will happen whit the rest of the data to be
pulled.

> +					} else if (frag->len) {
> +						/* Pulling all frag data */
> +						chunk -= frag->len;
> +						skb->len -= frag->len;
> +						skb->data_len -= frag->len;
> +						__skb_pull(frag, frag->len);
> +					}
> +				}
> +			}
> +
>  			if (skb->len) {
>  				skb_queue_head(&sk->sk_receive_queue, skb);
>  				break;
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
