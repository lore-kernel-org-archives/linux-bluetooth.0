Return-Path: <cyrus@holtmann.org>
Message-ID: <1332614889.1870.77.camel@aeonflux>
Subject: Re: [PATCH 4/4] Bluetooth: Functions parsing or generating ERTM
 control fields
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	pkrystad@codeaurora.org
Date: Sat, 24 Mar 2012 11:48:09 -0700
In-Reply-To: <1332547018-19468-5-git-send-email-mathewm@codeaurora.org>
References: <1332547018-19468-1-git-send-email-mathewm@codeaurora.org>
	 <1332547018-19468-5-git-send-email-mathewm@codeaurora.org>
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

this looks all good, but with the latest complaints from davem about
coding style, I have no idea on how to format these and similar ones
properly.

So you might have to redo these, but in general all good.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


