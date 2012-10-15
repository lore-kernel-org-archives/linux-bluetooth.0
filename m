Return-Path: <cyrus@holtmann.org>
Message-ID: <1350326647.26318.21.camel@aeonflux>
Subject: Re: [PATCH 15/19] Bluetooth: Configure appropriate timeouts for AMP
 controllers
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	sunnyk@codeaurora.org
Date: Mon, 15 Oct 2012 20:44:07 +0200
In-Reply-To: <1350315248-7690-16-git-send-email-mathewm@codeaurora.org>
References: <1350315248-7690-1-git-send-email-mathewm@codeaurora.org>
	 <1350315248-7690-16-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> The L2CAP spec recommends specific retransmit and monitor timeouts for
> ERTM channels that are on AMP controllers.  These timeouts are
> calculated from the AMP controller's best effort flush timeout.
> 
> BR/EDR controllers use the default retransmit and monitor timeouts.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap_core.c | 47 ++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 41 insertions(+), 6 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index cf1dc4e..dbcd1e3 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -2965,6 +2965,44 @@ static inline bool __l2cap_efs_supported(struct l2cap_chan *chan)
>  	return enable_hs && chan->conn->feat_mask & L2CAP_FEAT_EXT_FLOW;
>  }
>  
> +static void __l2cap_set_ertm_timeouts(struct l2cap_chan *chan,
> +				      struct l2cap_conf_rfc *rfc)
> +{
> +	if (chan->local_amp_id && chan->hs_hcon) {
> +		u64 ertm_to = chan->hs_hcon->hdev->amp_be_flush_to;
> +
> +		/* Class 1 devices have must have ERTM timeouts
> +		 * exceeding the Link Supervision Timeout.  The
> +		 * default Link Supervision Timeout for AMP
> +		 * controllers is 10 seconds.
> +		 *
> +		 * Class 1 devices use 0xffffffff for their
> +		 * best-effort flush timeout, so the clamping logic
> +		 * will result in a timeout that meets the above
> +		 * requirement.  ERTM timeouts are 16-bit values, so
> +		 * the maximum timeout is 65.535 seconds.
> +		 */
> +
> +		/* Convert timeout to milliseconds and round */
> +		ertm_to = div_u64(ertm_to + 999, 1000);

don't we have a proper ROUND function for this?

> +
> +		/* This is the recommended formula for class 2 devices
> +		 * that start ERTM timers when packets are sent to the
> +		 * controller.
> +		 */
> +		ertm_to = 3 * ertm_to + 500;
> +
> +		if (ertm_to > 0xffff)
> +			ertm_to = 0xffff;
> +
> +		rfc->retrans_timeout = cpu_to_le16((u16) ertm_to);
> +		rfc->monitor_timeout = rfc->retrans_timeout;
> +	} else {
> +		rfc->retrans_timeout = __constant_cpu_to_le16(L2CAP_DEFAULT_RETRANS_TO);
> +		rfc->monitor_timeout = __constant_cpu_to_le16(L2CAP_DEFAULT_MONITOR_TO);
> +	}
> +}
> +
>  static inline void l2cap_txwin_setup(struct l2cap_chan *chan)
>  {
>  	if (chan->tx_win > L2CAP_DEFAULT_TX_WINDOW &&
> @@ -3031,8 +3069,8 @@ done:
>  	case L2CAP_MODE_ERTM:
>  		rfc.mode            = L2CAP_MODE_ERTM;
>  		rfc.max_transmit    = chan->max_tx;
> -		rfc.retrans_timeout = 0;
> -		rfc.monitor_timeout = 0;
> +
> +		__l2cap_set_ertm_timeouts(chan, &rfc);
>  
>  		size = min_t(u16, L2CAP_DEFAULT_MAX_PDU_SIZE, chan->conn->mtu -
>  			     L2CAP_EXT_HDR_SIZE - L2CAP_SDULEN_SIZE -
> @@ -3260,10 +3298,7 @@ done:
>  			rfc.max_pdu_size = cpu_to_le16(size);
>  			chan->remote_mps = size;
>  
> -			rfc.retrans_timeout =
> -				__constant_cpu_to_le16(L2CAP_DEFAULT_RETRANS_TO);
> -			rfc.monitor_timeout =
> -				__constant_cpu_to_le16(L2CAP_DEFAULT_MONITOR_TO);
> +			__l2cap_set_ertm_timeouts(chan, &rfc);
>  
>  			set_bit(CONF_MODE_DONE, &chan->conf_state);
>  

Otherwise, looks good.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


