Return-Path: <cyrus@holtmann.org>
Date: Thu, 26 Jul 2012 17:41:17 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	pkrystad@codeaurora.org
Subject: Re: [RFCv0 10/21] Bluetooth: Add logical link confirm
Message-ID: <20120726144115.GE2686@aemeltch-MOBL1>
References: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
 <1343260274-11953-11-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343260274-11953-11-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Wed, Jul 25, 2012 at 04:51:02PM -0700, Mat Martineau wrote:
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/l2cap.h |   1 +
>  net/bluetooth/l2cap_core.c    | 120 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 119 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index fcc971a..7c50606 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -461,6 +461,7 @@ struct l2cap_chan {
>  
>  	__u8		conf_req[64];
>  	__u8		conf_len;
> +	__u8		conf_ident;
>  	__u8		num_conf_req;
>  	__u8		num_conf_rsp;
>  
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 8d72f2e..79f9d8e 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -3717,6 +3717,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
>  		goto unlock;
>  	}
>  
> +	chan->conf_ident = cmd->ident;
>  	l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP, len, rsp);
>  	chan->num_conf_rsp++;
>  
> @@ -4161,11 +4162,126 @@ static void l2cap_send_move_chan_cfm_rsp(struct l2cap_conn *conn, u8 ident,
>  	l2cap_send_cmd(conn, ident, L2CAP_MOVE_CHAN_CFM_RSP, sizeof(rsp), &rsp);
>  }
>  
> +/* Call with chan locked */
>  static void l2cap_logical_cfm(struct l2cap_chan *chan, struct hci_chan *hchan,
>  			      u8 status)
>  {
> -	/* Placeholder */
> -	return;
> +	BT_DBG("chan %p, hchan %p, status %d", chan, hchan, status);
> +
> +	if (chan->state != BT_CONNECTED && !chan->chan_id)
> +		return;
> +
> +	if (chan && !status && chan->state != BT_CONNECTED) {

If we consider chan might be NULL we would crash in the previous reference
of chan->state.

> +		struct l2cap_conf_rsp rsp;
> +		u8 code;
> +
> +		/* Create channel complete */
> +		chan->hs_hcon = hchan->conn;
> +		chan->hs_hcon->l2cap_data = chan->conn;
> +
> +		code = l2cap_build_conf_rsp(chan, &rsp,
> +					    L2CAP_CONF_SUCCESS, 0);
> +		l2cap_send_cmd(chan->conn, chan->conf_ident,
> +			       L2CAP_CONF_RSP, code, &rsp);
> +		set_bit(CONF_OUTPUT_DONE, &chan->conf_state);
> +
> +		if (test_bit(CONF_INPUT_DONE, &chan->conf_state)) {
> +			int err = 0;
> +
> +			set_default_fcs(chan);
> +
> +			if (chan->mode == L2CAP_MODE_ERTM ||
> +			    chan->mode == L2CAP_MODE_STREAMING)
> +				err = l2cap_ertm_init(chan);
> +
> +			if (err < 0)
> +				l2cap_send_disconn_req(chan->conn, chan, -err);
> +			else
> +				l2cap_chan_ready(chan);
> +		}
> +	} else if (chan && !status) {

Otherwise we always reference chan so we might check for chan in the
beginning.

> +		/* Channel move */
> +		chan->hs_hcon = hchan->conn;
> +		chan->hs_hcon->l2cap_data = chan->conn;
> +
> +		BT_DBG("move_state %d", chan->move_state);

in the future patches I would prefer something similar to state_to_string.

...

Best regards 
Andrei Emeltchenko 

