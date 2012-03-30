Return-Path: <cyrus@holtmann.org>
Message-ID: <1333083098.1870.235.camel@aeonflux>
Subject: Re: [PATCHv2 2/2] Bluetooth: Functions parsing or generating ERTM
 control fields
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	pkrystad@codeaurora.org
Date: Fri, 30 Mar 2012 06:51:38 +0200
In-Reply-To: <1333067569-19247-3-git-send-email-mathewm@codeaurora.org>
References: <1333067569-19247-1-git-send-email-mathewm@codeaurora.org>
	 <1333067569-19247-3-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

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

these look wrong to me from a coding style point of view. I think we
either ignore the 80 character rule here. Or we use a define that does
this for us. Something like this:

#define __get_poll(e) (((e) & L2CAP_CTRL_POLL) >> L2CAP_CTRL_POLL_SHIFT)

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

Or maybe even something funky like this:

#define __get_ctrl(e, f) (((e) & f) >> (f ## _SHIFT))

And then you could just use it like this:

	control->sar = __get_ctrl(enhanced, L2CAP_CTRL_SAR);

Or something similar. I am just throwing ideas into the room.

Regards

Marcel


