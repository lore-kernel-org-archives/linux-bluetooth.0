Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCHv2 7/9] Bluetooth: Use symbolic values for the fixed
 channel map
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	pkrystad@codeaurora.org, andrei.emeltchenko@intel.com
Date: Wed, 19 Oct 2011 12:09:20 -0700
In-Reply-To: <1319046247-3391-8-git-send-email-mathewm@codeaurora.org>
References: <1319046247-3391-1-git-send-email-mathewm@codeaurora.org>
	 <1319046247-3391-8-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1319051362.15441.171.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> The A2MP fixed channel bit is only set when high-speed mode is enabled.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap_core.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 67f0ab6..f250392 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -60,7 +60,7 @@ int disable_ertm;
>  int enable_hs;
>  
>  static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN;
> -static u8 l2cap_fixed_chan[8] = { 0x02, };
> +static u8 l2cap_fixed_chan[8] = { L2CAP_FC_L2CAP, };
>  
>  static LIST_HEAD(chan_list);
>  static DEFINE_RWLOCK(chan_list_lock);
> @@ -2975,6 +2975,10 @@ static inline int l2cap_information_req(struct l2cap_conn *conn, struct l2cap_cm
>  	} else if (type == L2CAP_IT_FIXED_CHAN) {
>  		u8 buf[12];
>  		struct l2cap_info_rsp *rsp = (struct l2cap_info_rsp *) buf;
> +
> +		if (enable_hs)
> +			l2cap_fixed_chan[0] |= L2CAP_FC_A2MP;
> +
>  		rsp->type   = cpu_to_le16(L2CAP_IT_FIXED_CHAN);
>  		rsp->result = cpu_to_le16(L2CAP_IR_SUCCESS);
>  		memcpy(buf + 4, l2cap_fixed_chan, 8);

doing it this way is a bit sneaky actually. Since it does not really
allow disabling HS once you enabled it.

Maybe doing feature enabling/disabling (and also for LE) is better
handled via /sys/kernel/debug/bluetooth/enable_hs.

Regards

Marcel


