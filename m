Return-Path: <cyrus@holtmann.org>
Date: Fri, 30 Mar 2012 10:14:08 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	pkrystad@codeaurora.org, marcel@holtmann.org
Subject: Re: [PATCHv2 1/2] Bluetooth: Add the l2cap_seq_list structure for
 tracking frames
Message-ID: <20120330071359.GA12694@aemeltch-MOBL1>
References: <1333067569-19247-1-git-send-email-mathewm@codeaurora.org>
 <1333067569-19247-2-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333067569-19247-2-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Thu, Mar 29, 2012 at 05:32:48PM -0700, Mat Martineau wrote:
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
>  net/bluetooth/l2cap_core.c    |  132 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 144 insertions(+)
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
> index 3caff27..2414ddd 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -233,6 +233,134 @@ static inline void l2cap_chan_set_err(struct l2cap_chan *chan, int err)
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
> +	int err = 0;
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
> +	seq_list->list = kzalloc(sizeof(u16) * alloc_size, GFP_KERNEL);
> +	if (!seq_list->list)
> +		return -ENOMEM;
> +
> +	seq_list->mask = alloc_size - 1;
> +	seq_list->head = L2CAP_SEQ_LIST_CLEAR;
> +	seq_list->tail = L2CAP_SEQ_LIST_CLEAR;
> +	for (i = 0; i < alloc_size; i++)
> +		seq_list->list[i] = L2CAP_SEQ_LIST_CLEAR;
> +
> +	return err;

return 0; err is not used and shall be removed.

Otherwise looks good.

Best regards 
Andrei Emeltchenko 
