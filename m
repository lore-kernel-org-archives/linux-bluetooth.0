Return-Path: <cyrus@holtmann.org>
Date: Sun, 25 Mar 2012 13:34:20 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, pkrystad@codeaurora.org,
	marcel@holtmann.org
Subject: Re: [PATCH 4/4] Bluetooth: Functions parsing or generating ERTM
 control fields
Message-ID: <20120325163420.GD3106@joana>
References: <1332547018-19468-1-git-send-email-mathewm@codeaurora.org>
 <1332547018-19468-5-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332547018-19468-5-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2012-03-23 16:56:58 -0700]:

> These functions encode or decode ERTM control fields (extended or
> enhanced) to or from the new l2cap_control structure.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap_core.c |  120 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 120 insertions(+)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index ad73696..890cfb9 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -787,6 +787,118 @@ static inline void l2cap_send_rr_or_rnr(struct l2cap_chan *chan, u32 control)
>  	l2cap_send_sframe(chan, control);
>  }
>  
> +static u16 __pack_enhanced_control(struct l2cap_ctrl *control)
> +{
> +	u16 packed;
> +
> +	packed = (control->reqseq << L2CAP_CTRL_REQSEQ_SHIFT) &
> +		L2CAP_CTRL_REQSEQ;
> +	packed |= (control->final << L2CAP_CTRL_FINAL_SHIFT) &
> +		L2CAP_CTRL_FINAL;
> +
> +	if (control->sframe) {
> +		packed |= (control->poll << L2CAP_CTRL_POLL_SHIFT) &
> +			L2CAP_CTRL_POLL;
> +		packed |= (control->super << L2CAP_CTRL_SUPER_SHIFT) &
> +			L2CAP_CTRL_SUPERVISE;
> +		packed |= L2CAP_CTRL_FRAME_TYPE;
> +	} else {
> +		packed |= (control->sar << L2CAP_CTRL_SAR_SHIFT) &
> +			L2CAP_CTRL_SAR;
> +		packed |= (control->txseq << L2CAP_CTRL_TXSEQ_SHIFT) &
> +			L2CAP_CTRL_TXSEQ;
> +	}
> +
> +	return packed;
> +}
> +
> +static void __get_enhanced_control(u16 enhanced,
> +					struct l2cap_ctrl *control)

wrong style here.

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
> +	packed = (control->reqseq << L2CAP_EXT_CTRL_REQSEQ_SHIFT) &
> +		L2CAP_EXT_CTRL_REQSEQ;
> +	packed |= (control->final << L2CAP_EXT_CTRL_FINAL_SHIFT) &
> +		L2CAP_EXT_CTRL_FINAL;
> +
> +	if (control->sframe) {
> +		packed |= (control->poll << L2CAP_EXT_CTRL_POLL_SHIFT) &
> +			L2CAP_EXT_CTRL_POLL;
> +		packed |= (control->super << L2CAP_EXT_CTRL_SUPER_SHIFT) &
> +			L2CAP_EXT_CTRL_SUPERVISE;
> +		packed |= L2CAP_EXT_CTRL_FRAME_TYPE;
> +	} else {
> +		packed |= (control->sar << L2CAP_EXT_CTRL_SAR_SHIFT) &
> +			L2CAP_EXT_CTRL_SAR;
> +		packed |= (control->txseq << L2CAP_EXT_CTRL_TXSEQ_SHIFT) &
> +			L2CAP_EXT_CTRL_TXSEQ;
> +	}
> +
> +	return packed;
> +}
> +
> +static void __get_extended_control(u32 extended,
> +				struct l2cap_ctrl *control)

wrong style here

	Gustavo
