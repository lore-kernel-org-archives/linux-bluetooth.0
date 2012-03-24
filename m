Return-Path: <cyrus@holtmann.org>
Message-ID: <1332614603.1870.75.camel@aeonflux>
Subject: Re: [PATCH 3/4] Bluetooth: Add the l2cap_seq_list structure for
 tracking frames
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	pkrystad@codeaurora.org
Date: Sat, 24 Mar 2012 11:43:23 -0700
In-Reply-To: <1332547018-19468-4-git-send-email-mathewm@codeaurora.org>
References: <1332547018-19468-1-git-send-email-mathewm@codeaurora.org>
	 <1332547018-19468-4-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> A sequence lists is a data structure used to track frames that need to
> be retransmitted, and frames that have been requested for
> retransmission by the remote device.  It can compactly represent a
> list of sequence numbers within the ERTM transmit window.  Memory for
> the list is allocated once at connection time, and common operations
> in ERTM are O(1).
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/l2cap.h |   13 +++++
>  net/bluetooth/l2cap_core.c    |  128 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 141 insertions(+)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index ed36f00..bc3c8d5 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -407,6 +407,17 @@ struct l2cap_conn_param_update_rsp {
>  #define L2CAP_CONN_PARAM_REJECTED	0x0001
>  
>  /* ----- L2CAP channels and connections ----- */
> +struct l2cap_seq_list {
> +	__u16	head;
> +	__u16	tail;
> +	__u16	size;
> +	__u16	mask;
> +	__u16	*list;
> +};
> +
> +#define L2CAP_SEQ_LIST_CLEAR	0xFFFF
> +#define L2CAP_SEQ_LIST_TAIL	0x8000
> +
>  struct srej_list {
>  	__u16	tx_seq;
>  	struct list_head list;
> @@ -501,6 +512,8 @@ struct l2cap_chan {
>  	struct sk_buff		*tx_send_head;
>  	struct sk_buff_head	tx_q;
>  	struct sk_buff_head	srej_q;
> +	struct l2cap_seq_list	srej_list;
> +	struct l2cap_seq_list	retrans_list;
>  	struct list_head	srej_l;
>  
>  	struct list_head	list;
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 9c86d73..ad73696 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -233,6 +233,130 @@ static inline void l2cap_chan_set_err(struct l2cap_chan *chan, int err)
>  	release_sock(sk);
>  }
>  
> +static inline struct sk_buff *l2cap_ertm_seq_in_queue(struct sk_buff_head *head,
> +						u16 seq)

we better should just stop over using inline in L2CAP and let the
compiler make all the decisions here.

> +{
> +	struct sk_buff *skb;
> +
> +	skb_queue_walk(head, skb) {
> +		if (bt_cb(skb)->control.txseq == seq)
> +			return skb;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int l2cap_seq_list_init(struct l2cap_seq_list *seq_list, u16 size)
> +{
> +	u16 allocSize = 1;

Please use alloc_size here. No camel case please.

> +	int err = 0;
> +	int i;
> +
> +	/* Actual allocated size must be a power of 2 */
> +	while (allocSize && allocSize <= size)
> +		allocSize <<= 1;
> +	if (!allocSize)
> +		return -ENOMEM;
> +
> +	seq_list->list = kzalloc(sizeof(u16) * allocSize, GFP_KERNEL);
> +	if (!seq_list->list)
> +		return -ENOMEM;
> +
> +	seq_list->size = allocSize;
> +	seq_list->mask = allocSize - 1;

Is the mask ever changing? If not, we not use a define here instead of
using extra memory.

> +	seq_list->head = L2CAP_SEQ_LIST_CLEAR;
> +	seq_list->tail = L2CAP_SEQ_LIST_CLEAR;
> +	for (i = 0; i < allocSize; i++)
> +		seq_list->list[i] = L2CAP_SEQ_LIST_CLEAR;
> +
> +	return err;
> +}
> +
> +static inline void l2cap_seq_list_free(struct l2cap_seq_list *seq_list)
> +{
> +	kfree(seq_list->list);
> +}
> +
> +static inline bool l2cap_seq_list_contains(struct l2cap_seq_list *seq_list,
> +					   u16 seq)
> +{
> +	return seq_list->list[seq & seq_list->mask] != L2CAP_SEQ_LIST_CLEAR;
> +}
> +
> +static u16 l2cap_seq_list_remove(struct l2cap_seq_list *seq_list, u16 seq)
> +{
> +	u16 mask = seq_list->mask;
> +
> +	BT_DBG("seq_list %p, seq %d", seq_list, (int) seq);
> +
> +	if (seq_list->head == L2CAP_SEQ_LIST_CLEAR) {
> +		/* In case someone tries to pop the head of an empty list */
> +		BT_DBG("List empty");
> +		return L2CAP_SEQ_LIST_CLEAR;
> +	} else if (seq_list->head == seq) {
> +		/* Head can be removed quickly */
> +		BT_DBG("Remove head");
> +		seq_list->head = seq_list->list[seq & mask];
> +		seq_list->list[seq & mask] = L2CAP_SEQ_LIST_CLEAR;
> +
> +		if (seq_list->head == L2CAP_SEQ_LIST_TAIL) {
> +			seq_list->head = L2CAP_SEQ_LIST_CLEAR;
> +			seq_list->tail = L2CAP_SEQ_LIST_CLEAR;
> +		}
> +	} else {
> +		/* Non-head item must be found first */
> +		u16 prev = seq_list->head;
> +		BT_DBG("Find and remove");
> +		while (seq_list->list[prev & mask] != seq) {
> +			prev = seq_list->list[prev & mask];
> +			if (prev == L2CAP_SEQ_LIST_TAIL) {
> +				BT_DBG("seq %d not in list", (int) seq);
> +				return L2CAP_SEQ_LIST_CLEAR;
> +			}
> +		}
> +
> +		seq_list->list[prev & mask] = seq_list->list[seq & mask];
> +		seq_list->list[seq & mask] = L2CAP_SEQ_LIST_CLEAR;
> +		if (seq_list->tail == seq)
> +			seq_list->tail = prev;
> +	}
> +	return seq;
> +}
> +
> +static inline u16 l2cap_seq_list_pop(struct l2cap_seq_list *seq_list)
> +{
> +	return l2cap_seq_list_remove(seq_list, seq_list->head);
> +}
> +
> +static void l2cap_seq_list_clear(struct l2cap_seq_list *seq_list)
> +{
> +	if (seq_list->head != L2CAP_SEQ_LIST_CLEAR) {
> +		u16 i;
> +		for (i = 0; i < seq_list->size; i++)
> +			seq_list->list[i] = L2CAP_SEQ_LIST_CLEAR;
> +
> +		seq_list->head = L2CAP_SEQ_LIST_CLEAR;
> +		seq_list->tail = L2CAP_SEQ_LIST_CLEAR;
> +	}
> +}
> +
> +static void l2cap_seq_list_append(struct l2cap_seq_list *seq_list, u16 seq)
> +{
> +	u16 mask = seq_list->mask;
> +
> +	BT_DBG("seq_list %p, seq %d", seq_list, (int) seq);
> +
> +	if (seq_list->list[seq & mask] == L2CAP_SEQ_LIST_CLEAR) {
> +		if (seq_list->tail == L2CAP_SEQ_LIST_CLEAR)
> +			seq_list->head = seq;
> +		else
> +			seq_list->list[seq_list->tail & mask] = seq;
> +
> +		seq_list->tail = seq;
> +		seq_list->list[seq & mask] = L2CAP_SEQ_LIST_TAIL;
> +	}
> +}
> +
>  static void l2cap_chan_timeout(struct work_struct *work)
>  {
>  	struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
> @@ -406,6 +530,8 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
>  
>  		skb_queue_purge(&chan->srej_q);
>  
> +		l2cap_seq_list_free(&chan->srej_list);
> +		l2cap_seq_list_free(&chan->retrans_list);
>  		list_for_each_entry_safe(l, tmp, &chan->srej_l, list) {
>  			list_del(&l->list);
>  			kfree(l);
> @@ -2051,6 +2177,8 @@ static inline void l2cap_ertm_init(struct l2cap_chan *chan)
>  
>  	skb_queue_head_init(&chan->srej_q);
>  
> +	l2cap_seq_list_init(&chan->srej_list, chan->tx_win);
> +	l2cap_seq_list_init(&chan->retrans_list, chan->remote_tx_win);
>  	INIT_LIST_HEAD(&chan->srej_l);
>  }
>  

I think you need to add a bit more documentation on what this is
actually doing, but overall it seems fine to me.

The only question that I still have is if we wanna leave it in l2cap.h
and not just put it in l2cap_core.c. Or if we wanna keep this away from
the core, maybe just create a l2cap_list.h or similar.

Regards

Marcel


