Return-Path: <cyrus@holtmann.org>
Date: Mon, 2 Jul 2012 09:41:40 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
cc: pkrystad@codeaurora.org
Subject: Re: [PATCH] Bluetooth: Use transmit window from config response for
 ack timing
In-Reply-To: <1340753757-5641-1-git-send-email-mathewm@codeaurora.org>
Message-ID: <alpine.DEB.2.02.1207020941030.25627@mathewm-linux>
References: <1340753757-5641-1-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Tue, 26 Jun 2012, Mat Martineau wrote:

> This change addresses an L2CAP ERTM throughput problem when a remote
> device does not fully utilize the available transmit window.
>
> The L2CAP ERTM transmit window size determines the maximum number of
> unacked frames that may be outstanding at any time. It is configured
> separately for each direction of an ERTM connection. Each side sends a
> configuration request with a tx_win field indicating how many unacked
> frames it is capable of receiving before sending an ack. The
> configuration response's tx_win field shows how many frames the
> transmitter will actually send before waiting for an ack.
>
> It's important to trace both the actual transmit window (to check for
> validity of incoming frames) and the number of frames that the
> transmitter will send before waiting (to send acks at the appropriate
> time). Now there are separate tx_win and ack_win values. ack_win is
> updated based on configuration responses, and is used to determine
> when acks are sent.

Ping...

>
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
> include/net/bluetooth/l2cap.h |  1 +
> net/bluetooth/l2cap_core.c    | 59 +++++++++++++++++++++++++------------------
> 2 files changed, 35 insertions(+), 25 deletions(-)
>
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index d80e3f0..e64304e 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -464,6 +464,7 @@ struct l2cap_chan {
>
> 	__u16		tx_win;
> 	__u16		tx_win_max;
> +	__u16		ack_win;
> 	__u8		max_tx;
> 	__u16		retrans_timeout;
> 	__u16		monitor_timeout;
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index d42dfdc..1558183 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -431,6 +431,7 @@ void l2cap_chan_set_defaults(struct l2cap_chan *chan)
> 	chan->max_tx = L2CAP_DEFAULT_MAX_TX;
> 	chan->tx_win = L2CAP_DEFAULT_TX_WINDOW;
> 	chan->tx_win_max = L2CAP_DEFAULT_TX_WINDOW;
> +	chan->ack_win = L2CAP_DEFAULT_TX_WINDOW;
> 	chan->sec_level = BT_SECURITY_LOW;
>
> 	set_bit(FLAG_FORCE_ACTIVE, &chan->flags);
> @@ -1877,10 +1878,10 @@ static void l2cap_send_ack(struct l2cap_chan *chan)
> 				frames_to_ack = 0;
> 		}
>
> -		/* Ack now if the tx window is 3/4ths full.
> +		/* Ack now if the window is 3/4ths full.
> 		 * Calculate without mul or div
> 		 */
> -		threshold = chan->tx_win;
> +		threshold = chan->ack_win;
> 		threshold += threshold << 1;
> 		threshold >>= 2;
>
> @@ -2786,6 +2787,7 @@ static inline void l2cap_txwin_setup(struct l2cap_chan *chan)
> 						L2CAP_DEFAULT_TX_WINDOW);
> 		chan->tx_win_max = L2CAP_DEFAULT_TX_WINDOW;
> 	}
> +	chan->ack_win = chan->tx_win;
> }
>
> static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data)
> @@ -3175,10 +3177,9 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len, voi
> 			break;
>
> 		case L2CAP_CONF_EWS:
> -			chan->tx_win = min_t(u16, val,
> -						L2CAP_DEFAULT_EXT_WINDOW);
> +			chan->ack_win = min_t(u16, val, chan->ack_win);
> 			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EWS, 2,
> -							chan->tx_win);
> +					   chan->tx_win);
> 			break;
>
> 		case L2CAP_CONF_EFS:
> @@ -3207,6 +3208,9 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len, voi
> 			chan->retrans_timeout = le16_to_cpu(rfc.retrans_timeout);
> 			chan->monitor_timeout = le16_to_cpu(rfc.monitor_timeout);
> 			chan->mps    = le16_to_cpu(rfc.max_pdu_size);
> +			if (!test_bit(FLAG_EXT_CTRL, &chan->flags))
> +				chan->ack_win = min_t(u16, chan->ack_win,
> +						      rfc.txwin_size);
>
> 			if (test_bit(FLAG_EFS_ENABLE, &chan->flags)) {
> 				chan->local_msdu = le16_to_cpu(efs.msdu);
> @@ -3268,7 +3272,17 @@ static void l2cap_conf_rfc_get(struct l2cap_chan *chan, void *rsp, int len)
> {
> 	int type, olen;
> 	unsigned long val;
> -	struct l2cap_conf_rfc rfc;
> +	/* Use sane default values in case a misbehaving remote device
> +	 * did not send an RFC or extended window size option.
> +	 */
> +	u16 txwin_ext = chan->ack_win;
> +	struct l2cap_conf_rfc rfc = {
> +		.mode = chan->mode,
> +		.retrans_timeout = __constant_cpu_to_le16(L2CAP_DEFAULT_RETRANS_TO),
> +		.monitor_timeout = __constant_cpu_to_le16(L2CAP_DEFAULT_MONITOR_TO),
> +		.max_pdu_size = cpu_to_le16(chan->imtu),
> +		.txwin_size = min_t(u16, chan->ack_win, L2CAP_DEFAULT_TX_WINDOW),
> +	};
>
> 	BT_DBG("chan %p, rsp %p, len %d", chan, rsp, len);
>
> @@ -3278,32 +3292,27 @@ static void l2cap_conf_rfc_get(struct l2cap_chan *chan, void *rsp, int len)
> 	while (len >= L2CAP_CONF_OPT_SIZE) {
> 		len -= l2cap_get_conf_opt(&rsp, &type, &olen, &val);
>
> -		if (type != L2CAP_CONF_RFC)
> -			continue;
> -
> -		if (olen != sizeof(rfc))
> +		switch (type) {
> +		case L2CAP_CONF_RFC:
> +			if (olen == sizeof(rfc))
> +				memcpy(&rfc, (void *)val, olen);
> 			break;
> -
> -		memcpy(&rfc, (void *)val, olen);
> -		goto done;
> +		case L2CAP_CONF_EWS:
> +			txwin_ext = val;
> +			break;
> +		}
> 	}
>
> -	/* Use sane default values in case a misbehaving remote device
> -	 * did not send an RFC option.
> -	 */
> -	rfc.mode = chan->mode;
> -	rfc.retrans_timeout = __constant_cpu_to_le16(L2CAP_DEFAULT_RETRANS_TO);
> -	rfc.monitor_timeout = __constant_cpu_to_le16(L2CAP_DEFAULT_MONITOR_TO);
> -	rfc.max_pdu_size = cpu_to_le16(chan->imtu);
> -
> -	BT_ERR("Expected RFC option was not found, using defaults");
> -
> -done:
> 	switch (rfc.mode) {
> 	case L2CAP_MODE_ERTM:
> 		chan->retrans_timeout = le16_to_cpu(rfc.retrans_timeout);
> 		chan->monitor_timeout = le16_to_cpu(rfc.monitor_timeout);
> -		chan->mps    = le16_to_cpu(rfc.max_pdu_size);
> +		chan->mps = le16_to_cpu(rfc.max_pdu_size);
> +		if (test_bit(FLAG_EXT_CTRL, &chan->flags))
> +			chan->ack_win = min_t(u16, chan->ack_win, txwin_ext);
> +		else
> +			chan->ack_win = min_t(u16, chan->ack_win,
> +					      rfc.txwin_size);
> 		break;
> 	case L2CAP_MODE_STREAMING:
> 		chan->mps    = le16_to_cpu(rfc.max_pdu_size);
> -- 
> 1.7.11.1


--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum


