Return-Path: <cyrus@holtmann.org>
Date: Fri, 30 Mar 2012 10:26:49 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	pkrystad@codeaurora.org, marcel@holtmann.org
Subject: Re: [PATCHv2 2/2] Bluetooth: Functions parsing or generating ERTM
 control fields
Message-ID: <20120330072646.GB12694@aemeltch-MOBL1>
References: <1333067569-19247-1-git-send-email-mathewm@codeaurora.org>
 <1333067569-19247-3-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333067569-19247-3-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Thu, Mar 29, 2012 at 05:32:49PM -0700, Mat Martineau wrote:
> These functions encode or decode ERTM control fields (extended or
> enhanced) to or from the new l2cap_control structure.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap_core.c |  108 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 108 insertions(+)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 2414ddd..8905386 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -789,6 +789,106 @@ static inline void l2cap_send_rr_or_rnr(struct l2cap_chan *chan, u32 control)
>  	l2cap_send_sframe(chan, control);
>  }
>  
> +static u16 __pack_enhanced_control(struct l2cap_ctrl *control)
> +{
> +	u16 packed;
> +
> +	packed = control->reqseq << L2CAP_CTRL_REQSEQ_SHIFT;
> +	packed |= control->final << L2CAP_CTRL_FINAL_SHIFT;
> +
> +	if (control->sframe) {
> +		packed |= control->poll << L2CAP_CTRL_POLL_SHIFT;
> +		packed |= control->super << L2CAP_CTRL_SUPER_SHIFT;
> +		packed |= L2CAP_CTRL_FRAME_TYPE;
> +	} else {
> +		packed |= control->sar << L2CAP_CTRL_SAR_SHIFT;
> +		packed |= control->txseq << L2CAP_CTRL_TXSEQ_SHIFT;
> +	}
> +
> +	return packed;
> +}
> +
> +static void __get_enhanced_control(u16 enhanced,
> +				   struct l2cap_ctrl *control)
> +{
> +	control->reqseq = (enhanced & L2CAP_CTRL_REQSEQ) >>
> +		L2CAP_CTRL_REQSEQ_SHIFT;
> +	control->final = (enhanced & L2CAP_CTRL_FINAL) >>
> +		L2CAP_CTRL_FINAL_SHIFT;
> +
> +	if (enhanced & L2CAP_CTRL_FRAME_TYPE) {
> +		/* S-Frame */
> +		control->sframe = 1;
> +		control->poll = (enhanced & L2CAP_CTRL_POLL) >>
> +			L2CAP_CTRL_POLL_SHIFT;
> +		control->super = (enhanced & L2CAP_CTRL_SUPERVISE) >>
> +			L2CAP_CTRL_SUPER_SHIFT;
> +
> +		control->sar = 0;
> +		control->txseq = 0;
> +	} else {
> +		/* I-Frame */
> +		control->sframe = 0;
> +		control->sar = (enhanced & L2CAP_CTRL_SAR) >>
> +			L2CAP_CTRL_SAR_SHIFT;
> +		control->txseq = (enhanced & L2CAP_CTRL_TXSEQ) >>
> +			L2CAP_CTRL_TXSEQ_SHIFT;
> +
> +		control->poll = 0;
> +		control->super = 0;
> +	}
> +}
> +
> +static u32 __pack_extended_control(struct l2cap_ctrl *control)
> +{
> +	u32 packed;
> +
> +	packed = control->reqseq << L2CAP_EXT_CTRL_REQSEQ_SHIFT;
> +	packed |= control->final << L2CAP_EXT_CTRL_FINAL_SHIFT;
> +
> +	if (control->sframe) {
> +		packed |= control->poll << L2CAP_EXT_CTRL_POLL_SHIFT;
> +		packed |= control->super << L2CAP_EXT_CTRL_SUPER_SHIFT;
> +		packed |= L2CAP_EXT_CTRL_FRAME_TYPE;
> +	} else {
> +		packed |= control->sar << L2CAP_EXT_CTRL_SAR_SHIFT;
> +		packed |= control->txseq << L2CAP_EXT_CTRL_TXSEQ_SHIFT;
> +	}
> +
> +	return packed;
> +}
> +
> +static void __get_extended_control(u32 extended,
> +				   struct l2cap_ctrl *control)
> +{
> +	control->reqseq = (extended & L2CAP_EXT_CTRL_REQSEQ) >>
> +		L2CAP_EXT_CTRL_REQSEQ_SHIFT;
> +	control->final = (extended & L2CAP_EXT_CTRL_FINAL) >>
> +		L2CAP_EXT_CTRL_FINAL_SHIFT;
> +
> +	if (extended & L2CAP_EXT_CTRL_FRAME_TYPE) {
> +		/* S-Frame */
> +		control->sframe = 1;
> +		control->poll = (extended & L2CAP_EXT_CTRL_POLL) >>
> +			L2CAP_EXT_CTRL_POLL_SHIFT;
> +		control->super = (extended & L2CAP_EXT_CTRL_SUPERVISE) >>
> +			L2CAP_EXT_CTRL_SUPER_SHIFT;
> +
> +		control->sar = 0;
> +		control->txseq = 0;
> +	} else {
> +		/* I-Frame */
> +		control->sframe = 0;
> +		control->sar = (extended & L2CAP_EXT_CTRL_SAR) >>
> +			L2CAP_EXT_CTRL_SAR_SHIFT;
> +		control->txseq = (extended & L2CAP_EXT_CTRL_TXSEQ) >>
> +			L2CAP_EXT_CTRL_TXSEQ_SHIFT;
> +
> +		control->poll = 0;
> +		control->super = 0;
> +	}
> +}
> +
>  static inline int __l2cap_no_conn_pending(struct l2cap_chan *chan)
>  {
>  	return !test_bit(CONF_CONNECT_PEND, &chan->conf_state);
> @@ -4350,6 +4450,14 @@ static int l2cap_ertm_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
>  	u16 req_seq;
>  	int len, next_tx_seq_offset, req_seq_offset;
>  
> +	if (test_bit(FLAG_EXT_CTRL, &chan->flags)) {
> +		__get_extended_control(get_unaligned_le32(skb->data),
> +				       &bt_cb(skb)->control);
> +	} else {
> +		__get_enhanced_control(get_unaligned_le16(skb->data),
> +				       &bt_cb(skb)->control);
> +	}
> +

Here I would change it to function, something like: __set_control(chan, skb);

Otherwise looks good.

Best regards 
Andrei Emeltchenko 

>  	control = __get_control(chan, skb->data);
>  	skb_pull(skb, __ctrl_size(chan));
>  	len = skb->len;
> -- 
