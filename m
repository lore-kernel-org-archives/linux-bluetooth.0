Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 3/4] Bluetooth: Initial support for retransmission of
 packets with REJ frames
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
In-Reply-To: <1248675424-20977-4-git-send-email-gustavo@las.ic.unicamp.br>
References: <1248675424-20977-1-git-send-email-gustavo@las.ic.unicamp.br>
	 <1248675424-20977-2-git-send-email-gustavo@las.ic.unicamp.br>
	 <1248675424-20977-3-git-send-email-gustavo@las.ic.unicamp.br>
	 <1248675424-20977-4-git-send-email-gustavo@las.ic.unicamp.br>
Content-Type: text/plain
Date: Mon, 27 Jul 2009 12:06:47 +0200
Message-Id: <1248689207.28545.192.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> When receiving an I-frame with unexpected txSeq, receiver side start the
> recovery procedure by send a REJ S-frame to the transmitter side. So the
> transmitter can re-send the lost I-frame.
> This patch just adds a basic support for retransmission, it doesn't
> mean that ERTM now has full support to packet retransmission.
> 
> Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
> ---
>  include/net/bluetooth/l2cap.h |    1 +
>  net/bluetooth/l2cap.c         |   57 ++++++++++++++++++++++++++++++-----------
>  2 files changed, 43 insertions(+), 15 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 233a2fa..653c313 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -354,6 +354,7 @@ struct l2cap_pinfo {
>  #define L2CAP_CONF_MAX_CONF_RSP 2
>  
>  #define L2CAP_CONN_SAR_SDU         0x01
> +#define L2CAP_CONN_UNDER_REJ       0x02
>  
>  static inline int l2cap_tx_window_full(struct sock *sk)
>  {
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index dcde60b..938d6db 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -2903,25 +2903,37 @@ static inline int l2cap_data_channel_iframe(struct sock *sk, u16 rx_control, str
>  
>  	BT_DBG("sk %p rx_control 0x%4.4x len %d", sk, rx_control, skb->len);
>  
> -	if (tx_seq != pi->expected_tx_seq)
> -		return -EINVAL;
> +	if (tx_seq == pi->expected_tx_seq) {
> +		if (pi->conn_state & L2CAP_CONN_UNDER_REJ)
> +			pi->conn_state &= !L2CAP_CONN_UNDER_REJ;

This is &= ~ again.

>  
> -	err = l2cap_sar_reassembly_sdu(sk, skb, rx_control, tx_seq);
> -	if (unlikely(err < 0))
> -		return err;
> +		err = l2cap_sar_reassembly_sdu(sk, skb, rx_control, tx_seq);
> +		if (unlikely(err < 0))
> +			return err;

No unlikely please.

>  
> -	L2CAP_SEQ_NUM_INC(pi->expected_tx_seq);
> -	L2CAP_NUM_TO_ACK_INC(pi->num_to_ack);
> -	if (pi->num_to_ack == L2CAP_DEFAULT_NUM_TO_ACK - 1) {
> -		tx_control |= L2CAP_CTRL_FRAME_TYPE;
> -		tx_control |= L2CAP_SUPER_RCV_READY;
> -		tx_control |= pi->expected_tx_seq << L2CAP_CTRL_REQSEQ_SHIFT;
> +		L2CAP_SEQ_NUM_INC(pi->expected_tx_seq);
> +		L2CAP_NUM_TO_ACK_INC(pi->num_to_ack);
> +		if (pi->num_to_ack == L2CAP_DEFAULT_NUM_TO_ACK - 1) {
> +			tx_control |= L2CAP_SUPER_RCV_READY;
> +			tx_control |= pi->expected_tx_seq << L2CAP_CTRL_REQSEQ_SHIFT;
> +			goto send;
> +		}
> +	}
> +	else {
> +		/* Unexpected txSeq. Send a REJ S-frame */
> +		kfree_skb(skb);
> +		if (!(pi->conn_state & L2CAP_CONN_UNDER_REJ)) {
> +			tx_control |= L2CAP_SUPER_REJECT;
> +			tx_control |= pi->expected_tx_seq << L2CAP_CTRL_REQSEQ_SHIFT;
> +			pi->conn_state |= L2CAP_CONN_UNDER_REJ;
>  
> -		err = l2cap_send_sframe(pi, tx_control);
> -		if (unlikely(err))
> -			return err;
> +			goto send;
> +		}
>  	}
>  	return 0;
> +
> +send:
> +	return l2cap_send_sframe(pi, tx_control);
>  }
>  
>  static inline int l2cap_data_channel_sframe(struct sock *sk, u16 rx_control, struct sk_buff *skb)
> @@ -2937,8 +2949,18 @@ static inline int l2cap_data_channel_sframe(struct sock *sk, u16 rx_control, str
>  		l2cap_ertm_send(sk);
>  		break;
>  
> -	case L2CAP_SUPER_RCV_NOT_READY:
>  	case L2CAP_SUPER_REJECT:
> +		pi->expected_ack_seq = __get_reqseq(rx_control);
> +		l2cap_drop_acked_frames(sk);
> +
> +		sk->sk_send_head = TX_QUEUE(sk)->next;
> +		pi->next_tx_seq = pi->expected_ack_seq;
> +
> +		l2cap_ertm_send(sk);
> +
> +		break;
> +
> +	case L2CAP_SUPER_RCV_NOT_READY:
>  	case L2CAP_SUPER_SELECT_REJECT:
>  		break;
>  	}
> @@ -2985,6 +3007,11 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
>  		if (__is_sar_sdu_start(control))
>  			len -= 2;
>  
> +		/*
> +		 * We can just drop the corrupted I-frames here.
> +		 * Receiver will miss it and start proper recovery
> +		 * procedures and ask retransmission.
> +		 */
>  		if (L2CAP_DEFAULT_MAX_PDU_SIZE < len)
>  			goto drop;
>  

Regards

Marcel


