Return-Path: <cyrus@holtmann.org>
Date: Mon, 26 Mar 2012 18:20:42 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	pkrystad@codeaurora.org, marcel@holtmann.org
Subject: Re: [PATCH 4/4] Bluetooth: Functions parsing or generating ERTM
 control fields
Message-ID: <20120326152040.GE18219@aemeltch-MOBL1>
References: <1332547018-19468-1-git-send-email-mathewm@codeaurora.org>
 <1332547018-19468-5-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332547018-19468-5-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Fri, Mar 23, 2012 at 04:56:58PM -0700, Mat Martineau wrote:
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

Is "& L2CAP_CTRL_FINAL" needed here and for other similar values?

Best regards 
Andrei Emeltchenko 
