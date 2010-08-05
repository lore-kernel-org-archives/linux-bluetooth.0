Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
Date: Thu, 5 Aug 2010 00:32:19 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/9] Bluetooth:  Only enable for L2CAP FCS for ERTM or
 streaming.
Message-ID: <20100805033218.GE7870@vigoh>
References: <1280962146-22604-1-git-send-email-mathewm@codeaurora.org>
 <1280962146-22604-2-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1280962146-22604-2-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2010-08-04 15:48:58 -0700]:

> This fixes a bug which caused the FCS setting to show L2CAP_FCS_CRC16
> with L2CAP modes other than ERTM or streaming.  At present, this only
> affects the FCS value shown with getsockopt() for basic mode.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap.c |   17 +++++++++++++----
>  1 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index 9ba1e8e..a2706d9 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -3063,6 +3063,17 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
>  	return 0;
>  }
>  
> +static inline int l2cap_fcs_needed(struct l2cap_pinfo *pi)
> +{
> +	if (pi->mode != L2CAP_MODE_ERTM && pi->mode != L2CAP_MODE_STREAMING)
> +		return 0;
> +	else {
> +		/* FCS is enabled if one or both sides request it. */
> +		return !(pi->conf_state & L2CAP_CONF_NO_FCS_RECV) ||
> +			pi->fcs == L2CAP_FCS_CRC16;
> +	}

Get ride of the else, just put the return !(pi->....

Also I would like to see the use case for the check for the ERTM and
Streaming before merge this patch. ;)

-- 
Gustavo F. Padovan
http://padovan.org
