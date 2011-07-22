Return-Path: <cyrus@holtmann.org>
Date: Fri, 22 Jul 2011 13:46:36 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Bluetooth: Perform L2CAP SDU reassembly without
 copying data
Message-ID: <20110722164636.GC2650@joana>
References: <1310579919-24546-1-git-send-email-mathewm@codeaurora.org>
 <1310579919-24546-4-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310579919-24546-4-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2011-07-13 10:58:39 -0700]:

> Use sk_buff fragment capabilities to link together incoming skbs
> instead of allocating a new skb for reassembly and copying.
> 
> The new reassembly code works equally well for ERTM and streaming
> mode, so there is now one reassembly function instead of two.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/l2cap.h |    3 +-
>  net/bluetooth/l2cap_core.c    |  239 ++++++++++++++---------------------------
>  2 files changed, 80 insertions(+), 162 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 4f34ad2..6fa1140 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -354,8 +354,8 @@ struct l2cap_chan {
>  	__u8		retry_count;
>  	__u8		num_acked;
>  	__u16		sdu_len;
> -	__u16		partial_sdu_len;
>  	struct sk_buff	*sdu;
> +	struct sk_buff	*sdu_last_frag;
>  
>  	__u8		remote_tx_win;
>  	__u8		remote_max_tx;
> @@ -454,7 +454,6 @@ enum {
>  #define L2CAP_CONF_MAX_CONF_RSP 2
>  
>  enum {
> -	CONN_SAR_SDU,
>  	CONN_SREJ_SENT,
>  	CONN_WAIT_F,
>  	CONN_SREJ_ACT,
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 52c791e..e82fff1 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -3120,102 +3120,104 @@ static int l2cap_add_to_srej_queue(struct l2cap_chan *chan, struct sk_buff *skb,
>  	return 0;
>  }
>  
> -static int l2cap_ertm_reassembly_sdu(struct l2cap_chan *chan, struct sk_buff *skb, u16 control)
> +static void append_skb_frag(struct sk_buff *skb,
> +			struct sk_buff *new_frag, struct sk_buff **last_frag)
>  {
> -	struct sk_buff *_skb;
> -	int err;
> +	/* skb->len reflects data in skb as well as all fragments
> +	 * skb->data_len reflects only data in fragments
> +	 */
> +	if (!skb_has_frag_list(skb))
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
> +static int l2cap_reassemble_sdu(struct l2cap_chan *chan, struct sk_buff *skb, u16 control)
> +{
> +	int err = -EINVAL;
>  
>  	switch (control & L2CAP_CTRL_SAR) {
>  	case L2CAP_SDU_UNSEGMENTED:
> -		if (test_bit(CONN_SAR_SDU, &chan->conn_state))
> -			goto drop;
> +		if (chan->sdu)
> +			break;
>  
> -		return chan->ops->recv(chan->data, skb);
> +		err = chan->ops->recv(chan->data, skb);
> +		break;
>  
>  	case L2CAP_SDU_START:
> -		if (test_bit(CONN_SAR_SDU, &chan->conn_state))
> -			goto drop;
> +		if (chan->sdu)
> +			break;
>  
>  		chan->sdu_len = get_unaligned_le16(skb->data);
> +		skb_pull(skb, 2);
>  
> -		if (chan->sdu_len > chan->imtu)
> -			goto disconnect;
> -
> -		chan->sdu = bt_skb_alloc(chan->sdu_len, GFP_ATOMIC);
> -		if (!chan->sdu)
> -			return -ENOMEM;
> +		if (chan->sdu_len > chan->imtu) {
> +			err = -EMSGSIZE;
> +			break;
> +		}
>  
> -		/* pull sdu_len bytes only after alloc, because of Local Busy
> -		 * condition we have to be sure that this will be executed
> -		 * only once, i.e., when alloc does not fail */
> -		skb_pull(skb, 2);
> +		if (skb->len >= chan->sdu_len)
> +			break;
>  
> -		memcpy(skb_put(chan->sdu, skb->len), skb->data, skb->len);
> +		chan->sdu = skb;
> +		chan->sdu_last_frag = skb;
>  
> -		set_bit(CONN_SAR_SDU, &chan->conn_state);
> -		chan->partial_sdu_len = skb->len;
> +		skb = NULL;
> +		err = 0;
>  		break;
>  
>  	case L2CAP_SDU_CONTINUE:
> -		if (!test_bit(CONN_SAR_SDU, &chan->conn_state))
> -			goto disconnect;
> -
>  		if (!chan->sdu)
> -			goto disconnect;
> +			break;
>  
> -		chan->partial_sdu_len += skb->len;
> -		if (chan->partial_sdu_len > chan->sdu_len)
> -			goto drop;
> +		append_skb_frag(chan->sdu, skb,
> +				&chan->sdu_last_frag);
> +		skb = NULL;
>  
> -		memcpy(skb_put(chan->sdu, skb->len), skb->data, skb->len);
> +		if (chan->sdu->len >= chan->sdu_len)
> +			break;
>  
> +		err = 0;
>  		break;
>  
>  	case L2CAP_SDU_END:
> -		if (!test_bit(CONN_SAR_SDU, &chan->conn_state))
> -			goto disconnect;
> -
>  		if (!chan->sdu)
> -			goto disconnect;
> -
> -		chan->partial_sdu_len += skb->len;
> -
> -		if (chan->partial_sdu_len > chan->imtu)
> -			goto drop;
> +			break;
>  
> -		if (chan->partial_sdu_len != chan->sdu_len)
> -			goto drop;
> +		append_skb_frag(chan->sdu, skb,
> +				&chan->sdu_last_frag);
> +		skb = NULL;
>  
> -		memcpy(skb_put(chan->sdu, skb->len), skb->data, skb->len);
> +		if (chan->sdu->len != chan->sdu_len)
> +			break;
>  
> -		_skb = skb_clone(chan->sdu, GFP_ATOMIC);
> -		if (!_skb) {
> -			return -ENOMEM;
> -		}
> +		err = chan->ops->recv(chan->data, chan->sdu);
>  
> -		err = chan->ops->recv(chan->data, _skb);
> -		if (err < 0) {
> -			kfree_skb(_skb);
> -			return err;
> +		if (!err) {
> +			/* Reassembly complete */
> +			chan->sdu = NULL;
> +			chan->sdu_last_frag = NULL;
> +			chan->sdu_len = 0;
>  		}
> -
> -		clear_bit(CONN_SAR_SDU, &chan->conn_state);
> -
> -		kfree_skb(chan->sdu);
>  		break;
>  	}
>  
> -	kfree_skb(skb);
> -	return 0;
> -
> -drop:
> -	kfree_skb(chan->sdu);
> -	chan->sdu = NULL;
> +	if (err) {
> +		kfree_skb(skb);
> +		kfree_skb(chan->sdu);
> +		chan->sdu = NULL;
> +		chan->sdu_last_frag = NULL;
> +		chan->sdu_len = 0;
> +	}
>  
> -disconnect:
> -	l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
> -	kfree_skb(skb);
> -	return 0;
> +	return err;
>  }
>  
>  static void l2cap_ertm_enter_local_busy(struct l2cap_chan *chan)
> @@ -3269,99 +3271,6 @@ void l2cap_chan_busy(struct l2cap_chan *chan, int busy)
>  	}
>  }
>  
> -static int l2cap_streaming_reassembly_sdu(struct l2cap_chan *chan, struct sk_buff *skb, u16 control)
> -{
> -	struct sk_buff *_skb;
> -	int err = -EINVAL;
> -
> -	/*
> -	 * TODO: We have to notify the userland if some data is lost with the
> -	 * Streaming Mode.
> -	 */
> -
> -	switch (control & L2CAP_CTRL_SAR) {
> -	case L2CAP_SDU_UNSEGMENTED:
> -		if (test_bit(CONN_SAR_SDU, &chan->conn_state)) {
> -			kfree_skb(chan->sdu);
> -			break;
> -		}
> -
> -		err = chan->ops->recv(chan->data, skb);
> -		if (!err)
> -			return 0;
> -
> -		break;
> -
> -	case L2CAP_SDU_START:
> -		if (test_bit(CONN_SAR_SDU, &chan->conn_state)) {
> -			kfree_skb(chan->sdu);
> -			break;
> -		}
> -
> -		chan->sdu_len = get_unaligned_le16(skb->data);
> -		skb_pull(skb, 2);
> -
> -		if (chan->sdu_len > chan->imtu) {
> -			err = -EMSGSIZE;
> -			break;
> -		}
> -
> -		chan->sdu = bt_skb_alloc(chan->sdu_len, GFP_ATOMIC);
> -		if (!chan->sdu) {
> -			err = -ENOMEM;
> -			break;
> -		}
> -
> -		memcpy(skb_put(chan->sdu, skb->len), skb->data, skb->len);
> -
> -		set_bit(CONN_SAR_SDU, &chan->conn_state);
> -		chan->partial_sdu_len = skb->len;
> -		err = 0;
> -		break;
> -
> -	case L2CAP_SDU_CONTINUE:
> -		if (!test_bit(CONN_SAR_SDU, &chan->conn_state))
> -			break;
> -
> -		memcpy(skb_put(chan->sdu, skb->len), skb->data, skb->len);
> -
> -		chan->partial_sdu_len += skb->len;
> -		if (chan->partial_sdu_len > chan->sdu_len)
> -			kfree_skb(chan->sdu);
> -		else
> -			err = 0;
> -
> -		break;
> -
> -	case L2CAP_SDU_END:
> -		if (!test_bit(CONN_SAR_SDU, &chan->conn_state))
> -			break;
> -
> -		memcpy(skb_put(chan->sdu, skb->len), skb->data, skb->len);
> -
> -		clear_bit(CONN_SAR_SDU, &chan->conn_state);
> -		chan->partial_sdu_len += skb->len;
> -
> -		if (chan->partial_sdu_len > chan->imtu)
> -			goto drop;
> -
> -		if (chan->partial_sdu_len == chan->sdu_len) {
> -			_skb = skb_clone(chan->sdu, GFP_ATOMIC);
> -			err = chan->ops->recv(chan->data, _skb);
> -			if (err < 0)
> -				kfree_skb(_skb);
> -		}
> -		err = 0;
> -
> -drop:
> -		kfree_skb(chan->sdu);
> -		break;
> -	}
> -
> -	kfree_skb(skb);
> -	return err;
> -}
> -
>  static void l2cap_check_srej_gap(struct l2cap_chan *chan, u8 tx_seq)
>  {
>  	struct sk_buff *skb;
> @@ -3376,7 +3285,7 @@ static void l2cap_check_srej_gap(struct l2cap_chan *chan, u8 tx_seq)
>  
>  		skb = skb_dequeue(&chan->srej_q);
>  		control = bt_cb(skb)->sar << L2CAP_CTRL_SAR_SHIFT;
> -		err = l2cap_ertm_reassembly_sdu(chan, skb, control);
> +		err = l2cap_reassemble_sdu(chan, skb, control);
>  
>  		if (err < 0) {
>  			l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
> @@ -3536,7 +3445,7 @@ expected:
>  		return 0;
>  	}
>  
> -	err = l2cap_ertm_reassembly_sdu(chan, skb, rx_control);
> +	err = l2cap_reassemble_sdu(chan, skb, rx_control);
>  	chan->buffer_seq = (chan->buffer_seq + 1) % 64;
>  	if (err < 0) {
>  		l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
> @@ -3854,10 +3763,20 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
>  
>  		if (chan->expected_tx_seq == tx_seq)
>  			chan->expected_tx_seq = (chan->expected_tx_seq + 1) % 64;

Coding style issue: you also need {} in the 'if'. If you need it on 'else'
then also add it to 'if.'

> -		else
> +		else {

	Gustavo
