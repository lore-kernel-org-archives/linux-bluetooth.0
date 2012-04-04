Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Mat Martineau <mathewm@codeaurora.org>
Subject: Re: [PATCHv3 1/2] Bluetooth: Add the l2cap_seq_list structure for tracking frames
Date: Wed, 4 Apr 2012 10:44:19 +0200
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"padovan@profusion.mobi" <padovan@profusion.mobi>, "pkrystad@codeaurora.org"
	<pkrystad@codeaurora.org>, "marcel@holtmann.org" <marcel@holtmann.org>
References: <1333493332-24623-1-git-send-email-mathewm@codeaurora.org> <1333493332-24623-2-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1333493332-24623-2-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-ID: <201204041044.19530.szymon.janc@tieto.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> A sequence list is a data structure used to track frames that need to
> be retransmitted, and frames that have been requested for
> retransmission by the remote device.  It can compactly represent a
> list of sequence numbers within the ERTM transmit window.  Memory for
> the list is allocated once at connection time, and common operations
> in ERTM are O(1).
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/l2cap.h |   12 ++++
>  net/bluetooth/l2cap_core.c    |  152 ++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 156 insertions(+), 8 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index f6f0500..5d65b3d 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -407,6 +407,16 @@ struct l2cap_conn_param_update_rsp {
>  #define L2CAP_CONN_PARAM_REJECTED	0x0001
>  
>  /* ----- L2CAP channels and connections ----- */
> +struct l2cap_seq_list {
> +	__u16	head;
> +	__u16	tail;
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
> @@ -501,6 +511,8 @@ struct l2cap_chan {
>  	struct sk_buff		*tx_send_head;
>  	struct sk_buff_head	tx_q;
>  	struct sk_buff_head	srej_q;
> +	struct l2cap_seq_list	srej_list;
> +	struct l2cap_seq_list	retrans_list;
>  	struct list_head	srej_l;
>  
>  	struct list_head	list;
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 3caff27..650e9f5 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -233,6 +233,125 @@ static inline void l2cap_chan_set_err(struct l2cap_chan *chan, int err)
>  	release_sock(sk);
>  }
>  
> +/* ---- L2CAP sequence number lists ---- */
> +
> +/* For ERTM, ordered lists of sequence numbers must be tracked for
> + * SREJ requests that are received and for frames that are to be
> + * retransmitted. These seq_list functions implement a singly-linked
> + * list in an array, where membership in the list can also be checked
> + * in constant time. Items can also be added to the tail of the list
> + * and removed from the head in constant time, without further memory
> + * allocs or frees.
> + */
> +
> +static int l2cap_seq_list_init(struct l2cap_seq_list *seq_list, u16 size)
> +{
> +	u16 alloc_size = 1;
> +	int i;
> +
> +	/* Allocated size is a power of 2 to map sequence numbers
> +	 * (which may be up to 14 bits) in to a smaller array that is
> +	 * sized for the negotiated ERTM transmit windows.
> +	 */
> +	while (alloc_size && alloc_size <= size)
> +		alloc_size <<= 1;
> +	if (!alloc_size)
> +		return -ENOMEM;
> +

Is it intended that if size is already equal to power of two you still double it?
And maybe use roundup_pow_of_two macro here?

> +	seq_list->list = kzalloc(sizeof(u16) * alloc_size, GFP_KERNEL);
> +	if (!seq_list->list)
> +		return -ENOMEM;
> +
> +	seq_list->mask = alloc_size - 1;
> +	seq_list->head = L2CAP_SEQ_LIST_CLEAR;
> +	seq_list->tail = L2CAP_SEQ_LIST_CLEAR;
> +	for (i = 0; i < alloc_size; i++)
> +		seq_list->list[i] = L2CAP_SEQ_LIST_CLEAR;

Could use memset for this instead of loop, and maybe use kcalloc instead of
kzalloc to allocate array?

> +
> +	return 0;
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
> +	/* Constant-time check for list membership */
> +	return seq_list->list[seq & seq_list->mask] != L2CAP_SEQ_LIST_CLEAR;
> +}
> +
> +static u16 l2cap_seq_list_remove(struct l2cap_seq_list *seq_list, u16 seq)
> +{
> +	u16 mask = seq_list->mask;
> +
> +	if (seq_list->head == L2CAP_SEQ_LIST_CLEAR) {
> +		/* In case someone tries to pop the head of an empty list */
> +		return L2CAP_SEQ_LIST_CLEAR;
> +	} else if (seq_list->head == seq) {
> +		/* Head can be removed in constant time */
> +		seq_list->head = seq_list->list[seq & mask];
> +		seq_list->list[seq & mask] = L2CAP_SEQ_LIST_CLEAR;
> +
> +		if (seq_list->head == L2CAP_SEQ_LIST_TAIL) {
> +			seq_list->head = L2CAP_SEQ_LIST_CLEAR;
> +			seq_list->tail = L2CAP_SEQ_LIST_CLEAR;
> +		}
> +	} else {
> +		/* Walk the list to find the sequence number */
> +		u16 prev = seq_list->head;
> +		while (seq_list->list[prev & mask] != seq) {
> +			prev = seq_list->list[prev & mask];
> +			if (prev == L2CAP_SEQ_LIST_TAIL)
> +				return L2CAP_SEQ_LIST_CLEAR;
> +		}
> +
> +		/* Unlink the number from the list and clear it */
> +		seq_list->list[prev & mask] = seq_list->list[seq & mask];
> +		seq_list->list[seq & mask] = L2CAP_SEQ_LIST_CLEAR;
> +		if (seq_list->tail == seq)
> +			seq_list->tail = prev;
> +	}
> +	return seq;
> +}
> +
> +static u16 l2cap_seq_list_pop(struct l2cap_seq_list *seq_list)
> +{
> +	/* Remove the head in constant time */
> +	return l2cap_seq_list_remove(seq_list, seq_list->head);
> +}
> +
> +static void l2cap_seq_list_clear(struct l2cap_seq_list *seq_list)
> +{
> +	if (seq_list->head != L2CAP_SEQ_LIST_CLEAR) {
> +		u16 i;
> +		for (i = 0; i <= seq_list->mask; i++)
> +			seq_list->list[i] = L2CAP_SEQ_LIST_CLEAR;

maybe use memset?

-- 
BR
Szymon Janc
