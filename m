Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/8] Bluetooth:  Make sure the L2CAP FCS is only
 enabled for ERTM or streaming.
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <1280776810-18213-2-git-send-email-mathewm@codeaurora.org>
References: <1280776810-18213-1-git-send-email-mathewm@codeaurora.org>
	 <1280776810-18213-2-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 02 Aug 2010 12:38:32 -0700
Message-ID: <1280777912.12579.37.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap.c |   12 ++++++++----
>  1 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index 9ba1e8e..aed72f2 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -3127,8 +3127,10 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
>  		goto unlock;
>  
>  	if (l2cap_pi(sk)->conf_state & L2CAP_CONF_INPUT_DONE) {
> -		if (!(l2cap_pi(sk)->conf_state & L2CAP_CONF_NO_FCS_RECV) ||
> -		    l2cap_pi(sk)->fcs != L2CAP_FCS_NONE)
> +		if ((l2cap_pi(sk)->mode == L2CAP_MODE_ERTM ||
> +			l2cap_pi(sk)->mode == L2CAP_MODE_STREAMING) &&
> +			(!(l2cap_pi(sk)->conf_state & L2CAP_CONF_NO_FCS_RECV) ||
> +			l2cap_pi(sk)->fcs != L2CAP_FCS_NONE))
>  			l2cap_pi(sk)->fcs = L2CAP_FCS_CRC16;

this becomes unreadable and my brain starts to throw a core dump. So it
clearly needs to be put into a helper inline function.

Regards

Marcel


