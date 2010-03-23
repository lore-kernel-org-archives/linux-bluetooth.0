Return-Path: <cyrus@holtmann.org>
From: Mike Tsai <Mike.Tsai@Atheros.com>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"marcel@holtmann.org" <marcel@holtmann.org>,
	"mathewm@codeaurora.org" <mathewm@codeaurora.org>
Date: Tue, 23 Mar 2010 15:10:29 -0700
Subject: RE: [PATCH 2/4] Bluetooth: Change acknowledgement to use the value
 of txWindow
Message-ID: <35B17FE5076C7040809188FBE7913F983A1DDCF356@SC1EXMB-MBCL.global.atheros.com>
References: <1268852016-3826-1-git-send-email-gustavo@padovan.org>
 <1268852016-3826-2-git-send-email-gustavo@padovan.org>
 <35B17FE5076C7040809188FBE7913F983A1DA4F474@SC1EXMB-MBCL.global.atheros.com>
 <20100322033342.GA11242@vigoh>
In-Reply-To: <20100322033342.GA11242@vigoh>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

	Thanks for your reply. It seems to be a reasonable approach. 

	There are no BT 3.0 products on the market that support extended window size yet (up to 16000+ TxWin?), and I don't think it will be supported in the near future either,

Best Regards,

Mike


-----Original Message-----
From: Gustavo F. Padovan [mailto:gfpadovan@gmail.com] On Behalf Of Gustavo F. Padovan
Sent: Sunday, March 21, 2010 8:34 PM
To: Mike Tsai
Cc: linux-bluetooth@vger.kernel.org; marcel@holtmann.org; mathewm@codeaurora.org
Subject: Re: [PATCH 2/4] Bluetooth: Change acknowledgement to use the value of txWindow

Hi Mike,

* Mike Tsai <Mike.Tsai@Atheros.com> [2010-03-17 14:47:49 -0700]:

> Just out of curiosity, where does this (pi->txWindow/6 + 1) come from?

L2CAP spec says that we don't need to ack every packet received, so I
have choose this number for optimization to not send an ack for each
packet received.
We can do a study and choose the better value for this, but it's better
to have the Extended Tx Window Implemented.

> 
> Thanks,
> 
> Mike
> 
> 
> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Gustavo F. Padovan
> Sent: Wednesday, March 17, 2010 11:54 AM
> To: linux-bluetooth@vger.kernel.org
> Cc: marcel@holtmann.org; gustavo@padovan.org; mathewm@codeaurora.org
> Subject: [PATCH 2/4] Bluetooth: Change acknowledgement to use the value of txWindow
> 
> Now that we can set the txWindow we need to change the acknowledgement
> procedure to ack after each (pi->txWindow/6 + 1). The plus 1 is to avoid
> the zero value.
> It also renames pi->num_to_ack to a better name: pi->num_acked.
> 
> Signed-off-by: Gustavo F. Padovan <gustavo@padovan.org>
> ---
>  include/net/bluetooth/l2cap.h |    3 +--
>  net/bluetooth/l2cap.c         |    9 +++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index c7bf676..9358b9e 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -30,7 +30,6 @@
>  #define L2CAP_DEFAULT_MIN_MTU		48
>  #define L2CAP_DEFAULT_FLUSH_TO		0xffff
>  #define L2CAP_DEFAULT_TX_WINDOW		63
> -#define L2CAP_DEFAULT_NUM_TO_ACK        (L2CAP_DEFAULT_TX_WINDOW/5)
>  #define L2CAP_DEFAULT_MAX_TX		3
>  #define L2CAP_DEFAULT_RETRANS_TO	1000    /* 1 second */
>  #define L2CAP_DEFAULT_MONITOR_TO	12000   /* 12 seconds */
> @@ -333,7 +332,7 @@ struct l2cap_pinfo {
>  	__u8		frames_sent;
>  	__u8		unacked_frames;
>  	__u8		retry_count;
> -	__u8		num_to_ack;
> +	__u8		num_acked;
>  	__u16		sdu_len;
>  	__u16		partial_sdu_len;
>  	struct sk_buff	*sdu;
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index 6679418..959be0f 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -2248,7 +2248,7 @@ static inline void l2cap_ertm_init(struct sock *sk)
>  	l2cap_pi(sk)->expected_ack_seq = 0;
>  	l2cap_pi(sk)->unacked_frames = 0;
>  	l2cap_pi(sk)->buffer_seq = 0;
> -	l2cap_pi(sk)->num_to_ack = 0;
> +	l2cap_pi(sk)->num_acked = 0;
>  	l2cap_pi(sk)->frames_sent = 0;
>  
>  	setup_timer(&l2cap_pi(sk)->retrans_timer,
> @@ -2571,7 +2571,7 @@ static int l2cap_parse_conf_rsp(struct sock *sk, void *rsp, int len, void *data,
>  	if (*result == L2CAP_CONF_SUCCESS) {
>  		switch (rfc.mode) {
>  		case L2CAP_MODE_ERTM:
> -			pi->remote_tx_win   = rfc.txwin_size;
> +			pi->tx_win   = rfc.txwin_size;
>  			pi->retrans_timeout = rfc.retrans_timeout;
>  			pi->monitor_timeout = rfc.monitor_timeout;
>  			pi->max_pdu_size    = le16_to_cpu(rfc.max_pdu_size);
> @@ -3408,6 +3408,7 @@ static inline int l2cap_data_channel_iframe(struct sock *sk, u16 rx_control, str
>  	u8 tx_seq = __get_txseq(rx_control);
>  	u8 req_seq = __get_reqseq(rx_control);
>  	u8 sar = rx_control >> L2CAP_CTRL_SAR_SHIFT;
> +	int num_to_ack = (pi->tx_win/6) + 1;
>  	int err = 0;
>  
>  	BT_DBG("sk %p rx_control 0x%4.4x len %d", sk, rx_control, skb->len);
> @@ -3501,8 +3502,8 @@ expected:
>  
>  	__mod_ack_timer();
>  
> -	pi->num_to_ack = (pi->num_to_ack + 1) % L2CAP_DEFAULT_NUM_TO_ACK;
> -	if (pi->num_to_ack == L2CAP_DEFAULT_NUM_TO_ACK - 1)
> +	pi->num_acked = (pi->num_acked + 1) % num_to_ack;
> +	if (pi->num_acked == num_to_ack - 1)
>  		l2cap_send_ack(pi);
>  
>  	return 0;
> -- 
> 1.6.4.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Gustavo F. Padovan
http://padovan.org
