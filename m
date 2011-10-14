Return-Path: <cyrus@holtmann.org>
Date: Fri, 14 Oct 2011 14:20:39 +0300
From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	pkrystad@codeaurora.org
Subject: Re: [PATCH 2/9] Bluetooth: Add AMP policy information to l2cap_chan
Message-ID: <20111014112037.GC32656@aemeltch-MOBL1>
References: <1318543247-27130-1-git-send-email-mathewm@codeaurora.org>
 <1318543247-27130-3-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1318543247-27130-3-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Thu, Oct 13, 2011 at 03:00:40PM -0700, Mat Martineau wrote:
> Each channel has an active AMP policy to require BR/EDR (the default),
> prefer AMP, or prefer BR/EDR.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/l2cap.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 806b950..e77d39f 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -357,6 +357,7 @@ struct l2cap_chan {
>  	__u8		num_conf_rsp;
>  
>  	__u8		fcs;
> +	__u8		amp_policy;

I would merge this patch with following one since this is only one line.

>  
>  	__u16		tx_win;
>  	__u8		max_tx;
> -- 
> 1.7.7
> 
> --
> Mat Martineau
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

