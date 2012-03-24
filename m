Return-Path: <cyrus@holtmann.org>
Message-ID: <1332614093.1870.70.camel@aeonflux>
Subject: Re: [PATCH 2/4] Bluetooth: Add a structure to carry ERTM data in
 skb control blocks
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	pkrystad@codeaurora.org
Date: Sat, 24 Mar 2012 11:34:53 -0700
In-Reply-To: <1332547018-19468-3-git-send-email-mathewm@codeaurora.org>
References: <1332547018-19468-1-git-send-email-mathewm@codeaurora.org>
	 <1332547018-19468-3-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> Every field from ERTM control headers is now carried in the control
> block so it only has to be parsed or generated once, and can be
> efficiently accessed throughout the ERTM code.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/bluetooth.h |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index 262ebd1..f2c8bdf 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -215,6 +215,18 @@ void bt_accept_unlink(struct sock *sk);
>  struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock);
>  
>  /* Skb helpers */
> +struct l2cap_ctrl {
> +	unsigned int	sframe	: 1,
> +			poll	: 1,
> +			final	: 1,
> +			fcs	: 1,
> +			sar	: 2,
> +			super	: 2;
> +	__u16		reqseq;
> +	__u16		txseq;
> +	__u8		retries;
> +};
> +
>  struct bt_skb_cb {
>  	__u8 pkt_type;
>  	__u8 incoming;
> @@ -223,6 +235,7 @@ struct bt_skb_cb {
>  	__u8 retries;
>  	__u8 sar;
>  	__u8 force_active;
> +	struct l2cap_ctrl control;
>  };
>  #define bt_cb(skb) ((struct bt_skb_cb *)((skb)->cb))
>  

would it make sense in the future to split this into bt_skb_cb and
bt_skb_l2cap_cb? However that can be done later.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


