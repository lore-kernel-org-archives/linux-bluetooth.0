Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 Apr 2012 10:12:12 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	pkrystad@codeaurora.org, marcel@holtmann.org
Subject: Re: [PATCHv3 2/2] Bluetooth: Functions for handling ERTM control
 fields
Message-ID: <20120404071205.GA17251@aemeltch-MOBL1>
References: <1333493332-24623-1-git-send-email-mathewm@codeaurora.org>
 <1333493332-24623-3-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333493332-24623-3-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Tue, Apr 03, 2012 at 03:48:52PM -0700, Mat Martineau wrote:
> These functions encode or decode ERTM control fields (extended or
> enhanced) to or from the new l2cap_ctrl structure.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>

Looks good now.

Acked-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


> ---
>  net/bluetooth/l2cap_core.c |   99 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 650e9f5..b1eac5a 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -780,6 +780,103 @@ static inline void l2cap_send_rr_or_rnr(struct l2cap_chan *chan, u32 control)
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
> +static void __get_enhanced_control(u16 enh, struct l2cap_ctrl *control)
> +{
> +	control->reqseq = (enh & L2CAP_CTRL_REQSEQ) >> L2CAP_CTRL_REQSEQ_SHIFT;
> +	control->final = (enh & L2CAP_CTRL_FINAL) >> L2CAP_CTRL_FINAL_SHIFT;
> +
> +	if (enh & L2CAP_CTRL_FRAME_TYPE) {
> +		/* S-Frame */
> +		control->sframe = 1;
> +		control->poll = (enh & L2CAP_CTRL_POLL) >> L2CAP_CTRL_POLL_SHIFT;
> +		control->super = (enh & L2CAP_CTRL_SUPERVISE) >> L2CAP_CTRL_SUPER_SHIFT;
> +
> +		control->sar = 0;
> +		control->txseq = 0;
> +	} else {
> +		/* I-Frame */
> +		control->sframe = 0;
> +		control->sar = (enh & L2CAP_CTRL_SAR) >> L2CAP_CTRL_SAR_SHIFT;
> +		control->txseq = (enh & L2CAP_CTRL_TXSEQ) >> L2CAP_CTRL_TXSEQ_SHIFT;
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
> +static void __get_extended_control(u32 ext, struct l2cap_ctrl *control)
> +{
> +	control->reqseq = (ext & L2CAP_EXT_CTRL_REQSEQ) >> L2CAP_EXT_CTRL_REQSEQ_SHIFT;
> +	control->final = (ext & L2CAP_EXT_CTRL_FINAL) >> L2CAP_EXT_CTRL_FINAL_SHIFT;
> +
> +	if (ext & L2CAP_EXT_CTRL_FRAME_TYPE) {
> +		/* S-Frame */
> +		control->sframe = 1;
> +		control->poll = (ext & L2CAP_EXT_CTRL_POLL) >> L2CAP_EXT_CTRL_POLL_SHIFT;
> +		control->super = (ext & L2CAP_EXT_CTRL_SUPERVISE) >> L2CAP_EXT_CTRL_SUPER_SHIFT;
> +
> +		control->sar = 0;
> +		control->txseq = 0;
> +	} else {
> +		/* I-Frame */
> +		control->sframe = 0;
> +		control->sar = (ext & L2CAP_EXT_CTRL_SAR) >> L2CAP_EXT_CTRL_SAR_SHIFT;
> +		control->txseq = (ext & L2CAP_EXT_CTRL_TXSEQ) >> L2CAP_EXT_CTRL_TXSEQ_SHIFT;
> +
> +		control->poll = 0;
> +		control->super = 0;
> +	}
> +}
> +
> +static void __set_control(struct l2cap_chan *chan, struct sk_buff *skb)
> +{
> +	if (test_bit(FLAG_EXT_CTRL, &chan->flags)) {
> +		__get_extended_control(get_unaligned_le32(skb->data),
> +				       &bt_cb(skb)->control);
> +	} else {
> +		__get_enhanced_control(get_unaligned_le16(skb->data),
> +				       &bt_cb(skb)->control);
> +	}
> +}
> +
>  static inline int __l2cap_no_conn_pending(struct l2cap_chan *chan)
>  {
>  	return !test_bit(CONF_CONNECT_PEND, &chan->conf_state);
> @@ -4354,6 +4451,8 @@ static int l2cap_ertm_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
>  	u16 req_seq;
>  	int len, next_tx_seq_offset, req_seq_offset;
>  
> +	__set_control(chan, skb);
> +
>  	control = __get_control(chan, skb->data);
>  	skb_pull(skb, __ctrl_size(chan));
>  	len = skb->len;
> -- 
> 1.7.9.4
> 
> --
> Mat Martineau
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
