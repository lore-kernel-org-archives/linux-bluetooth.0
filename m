Return-Path: <cyrus@holtmann.org>
Date: Tue, 16 Oct 2012 13:38:56 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	sunnyk@codeaurora.org, marcel@holtmann.org
Subject: Re: [PATCH 10/19] Bluetooth: Add logical link confirm
Message-ID: <20121016103855.GH14036@aemeltch-MOBL1>
References: <1350315248-7690-1-git-send-email-mathewm@codeaurora.org>
 <1350315248-7690-11-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350315248-7690-11-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Mon, Oct 15, 2012 at 08:33:59AM -0700, Mat Martineau wrote:
> The logical link confirm callback is executed when the AMP controller
> completes its logical link setup.  During a channel move, a newly
> formed logical link allows a move responder to send a move channel
> response.  A move initiator will send a move channel confirm.  A
> failed logical link will end the channel move and send an appropriate
> response or confirm command indicating a failure.
> 
> If the channel is being created on an AMP controller, L2CAP
> configuration is started after the logical link is set up.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap_core.c | 117 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 115 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index c687cc1..7e31e98 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -3779,6 +3779,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
>  		goto unlock;
>  	}
>  
> +	chan->ident = cmd->ident;
>  	l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP, len, rsp);
>  	chan->num_conf_rsp++;
>  
> @@ -4221,11 +4222,123 @@ static void l2cap_send_move_chan_cfm_rsp(struct l2cap_conn *conn, u8 ident,
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
> +	if (chan->state != BT_CONNECTED && !chan->local_amp_id)
> +		return;
> +
> +	if (!status && chan->state != BT_CONNECTED) {
> +		struct l2cap_conf_rsp rsp;
> +		u8 code;
> +
> +		/* Create channel complete */
> +		chan->hs_hcon = hchan->conn;
> +		chan->hs_hcon->l2cap_data = chan->conn;
> +
> +		code = l2cap_build_conf_rsp(chan, &rsp,
> +					    L2CAP_CONF_SUCCESS, 0);
> +		l2cap_send_cmd(chan->conn, chan->ident, L2CAP_CONF_RSP, code,
> +			       &rsp);
> +		set_bit(CONF_OUTPUT_DONE, &chan->conf_state);
> +
> +		if (test_bit(CONF_INPUT_DONE, &chan->conf_state)) {
> +			int err = 0;
> +
> +			set_default_fcs(chan);
> +
> +			if (chan->mode == L2CAP_MODE_ERTM ||
> +			    chan->mode == L2CAP_MODE_STREAMING)

Shall we check for this? Can we have here basic mode?

Best regards 
Andrei Emeltchenko 
