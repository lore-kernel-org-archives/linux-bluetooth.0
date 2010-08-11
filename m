Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
Date: Wed, 11 Aug 2010 02:24:33 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [RFC 6/7] Bluetooth: Reassemble enhanced L2CAP PDUs using skb
 fragments.
Message-ID: <20100811052433.GA10773@vigoh>
References: <1281467704-5378-1-git-send-email-mathewm@codeaurora.org>
 <1281467704-5378-7-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1281467704-5378-7-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2010-08-10 12:15:03 -0700]:

> As enhanced L2CAP PDUs arrive, it is not necessary to copy them
> in to a separate skbuff.  Instead, the skbuffs can be linked
> together as fragments, only being copied in to a linear buffer
> when the data is copied to userspace.  This avoids the need
> to allocate additional buffers for incoming data, and
> eliminates copying of data payloads during SDU reassembly.
> This is of greater concern with high-speed AMP links than
> with BR/EDR.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/l2cap.h |    1 +
>  net/bluetooth/l2cap.c         |   66 +++++++++++++++++++++-------------------
>  2 files changed, 36 insertions(+), 31 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 2f3222f..9384e87 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -357,6 +357,7 @@ struct l2cap_pinfo {
>  	__u16		sdu_len;
>  	__u16		partial_sdu_len;
>  	struct sk_buff	*sdu;
> +	struct sk_buff	*sdu_last_frag;
>  
>  	__u8		ident;
>  
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index b485c4a..0212035 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -290,6 +290,9 @@ static void l2cap_chan_del(struct sock *sk, int err)
>  		skb_queue_purge(SREJ_QUEUE(sk));
>  		skb_queue_purge(BUSY_QUEUE(sk));
>  
> +		if (l2cap_pi(sk)->sdu)
> +			kfree_skb(l2cap_pi(sk)->sdu);
> +
>  		list_for_each_entry_safe(l, tmp, SREJ_LIST(sk), list) {
>  			list_del(&l->list);
>  			kfree(l);
> @@ -3635,6 +3638,27 @@ static int l2cap_add_to_srej_queue(struct sock *sk, struct sk_buff *skb, u8 tx_s
>  	return 0;
>  }
>  
> +static inline void append_skb_frag(struct sk_buff *skb,
> +			struct sk_buff *new_frag, struct sk_buff **last_frag)

Call this l2cap_append_skb_frag()

> +{
> +	/* skb->len reflects data in skb as well as all fragments
> +	   skb->data_len reflects only data in fragments
> +	 */
> +	BT_DBG("skb %p, new_frag %p, *last_frag %p", skb, new_frag, *last_frag);
> +
> +	if (!skb_has_frags(skb))
> +		skb_shinfo(skb)->frag_list = new_frag;
> +
> +	new_frag->next = NULL;
> +
> +	(*last_frag)->next = new_frag;
> +	*last_frag = new_frag;
> +
> +	skb->len += new_frag->len;
> +	skb->data_len += new_frag->len;
> +	skb->truesize += new_frag->truesize;
> +}
> +

Wondering if it is possible to do that append more simple, but I looked
through the kernel code it's not possible, we have to keep last frag
pointer.

This change should go to l2cap_streaming_reassembly_sdu() as well, then
you can get ride of partial_sdu_len in the struct l2cap_pinfo.

>  static int l2cap_ertm_reassembly_sdu(struct sock *sk, struct sk_buff *skb, u16 control)
>  {
>  	struct l2cap_pinfo *pi = l2cap_pi(sk);
> @@ -3643,7 +3667,7 @@ static int l2cap_ertm_reassembly_sdu(struct sock *sk, struct sk_buff *skb, u16 c
>  
>  	switch (control & L2CAP_CTRL_SAR) {
>  	case L2CAP_SDU_UNSEGMENTED:
> -		if (pi->conn_state & L2CAP_CONN_SAR_SDU)
> +		if (pi->sdu)

pi->sdu can do the work work of pi->conn_state & L2CAP_CONN_SAR_SDU, so
a separated patch for that change sounds better (you can change that for
the Streaming mode at the same time, it's a similar code, but more simple).


-- 
Gustavo F. Padovan
http://padovan.org
