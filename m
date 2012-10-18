Return-Path: <cyrus@holtmann.org>
Message-ID: <1350594530.2026.18.camel@aeonflux>
Subject: Re: [PATCHv3 10/18] Bluetooth: Add logical link confirm
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	sunnyk@codeaurora.org, andrei.emeltchenko.news@gmail.com
Date: Thu, 18 Oct 2012 14:08:50 -0700
In-Reply-To: <1350583130-3241-11-git-send-email-mathewm@codeaurora.org>
References: <1350583130-3241-1-git-send-email-mathewm@codeaurora.org>
	 <1350583130-3241-11-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

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
>  net/bluetooth/l2cap_core.c | 120 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 118 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 7e50aa4..8e50685 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -3799,6 +3799,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
>  		goto unlock;
>  	}
>  
> +	chan->ident = cmd->ident;
>  	l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP, len, rsp);
>  	chan->num_conf_rsp++;
>  
> @@ -4241,11 +4242,126 @@ static void l2cap_send_move_chan_cfm_rsp(struct l2cap_conn *conn, u8 ident,
>  	l2cap_send_cmd(conn, ident, L2CAP_MOVE_CHAN_CFM_RSP, sizeof(rsp), &rsp);
>  }
>  
> +static void l2cap_logical_fail(struct l2cap_chan *chan)
> +{
> +	/* Logical link setup failed */
> +	if (chan->state != BT_CONNECTED) {
> +		/* Create channel failure, disconnect */
> +		l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);

		goto done;

And then the chan->move_role as switch statement?

> +	} else if (chan->move_role == L2CAP_MOVE_ROLE_RESPONDER) {
> +		l2cap_move_revert(chan);
> +		chan->move_role = L2CAP_MOVE_ROLE_NONE;
> +		chan->move_state = L2CAP_MOVE_STABLE;
> +		l2cap_send_move_chan_rsp(chan->conn, chan->ident, chan->dcid,
> +					 L2CAP_MR_NOT_SUPP);
> +	} else if (chan->move_role == L2CAP_MOVE_ROLE_INITIATOR) {
> +		if (chan->move_state == L2CAP_MOVE_WAIT_LOGICAL_COMP ||
> +		    chan->move_state == L2CAP_MOVE_WAIT_LOGICAL_CFM) {
> +			/* Remote has only sent pending or
> +			 * success responses, clean up
> +			 */
> +			l2cap_move_revert(chan);
> +			chan->move_role = L2CAP_MOVE_ROLE_NONE;
> +			chan->move_state = L2CAP_MOVE_STABLE;
> +		}
> +
> +		/* Other amp move states imply that the move
> +		 * has already aborted
> +		 */
> +		l2cap_send_move_chan_cfm(chan->conn, chan, chan->scid,
> +					 L2CAP_MC_UNCONFIRMED);
> +		__set_chan_timer(chan, L2CAP_MOVE_TIMEOUT);
> +	}
> +

done:

	/* cleanup ... */

> +	chan->hs_hchan = NULL;
> +	chan->hs_hcon = NULL;
> +
> +	/* Placeholder - free logical link */
> +}
> +
> +static void l2cap_logical_create_channel(struct l2cap_chan *chan,
> +					 struct hci_chan *hchan)
> +{
> +	struct l2cap_conf_rsp rsp;
> +	u8 code;
> +
> +	chan->hs_hcon = hchan->conn;
> +	chan->hs_hcon->l2cap_data = chan->conn;
> +
> +	code = l2cap_build_conf_rsp(chan, &rsp,
> +				    L2CAP_CONF_SUCCESS, 0);
> +	l2cap_send_cmd(chan->conn, chan->ident, L2CAP_CONF_RSP, code,
> +		       &rsp);
> +	set_bit(CONF_OUTPUT_DONE, &chan->conf_state);
> +
> +	if (test_bit(CONF_INPUT_DONE, &chan->conf_state)) {
> +		int err = 0;
> +
> +		set_default_fcs(chan);
> +
> +		err = l2cap_ertm_init(chan);
> +		if (err < 0)
> +			l2cap_send_disconn_req(chan->conn, chan, -err);
> +		else
> +			l2cap_chan_ready(chan);
> +	}
> +}
> +
> +static void l2cap_logical_move_channel(struct l2cap_chan *chan,
> +				       struct hci_chan *hchan)
> +{
> +	chan->hs_hcon = hchan->conn;
> +	chan->hs_hcon->l2cap_data = chan->conn;
> +
> +	BT_DBG("move_state %d", chan->move_state);
> +
> +	switch (chan->move_state) {
> +	case L2CAP_MOVE_WAIT_LOGICAL_COMP:
> +		/* Move confirm will be sent after a success
> +		 * response is received
> +		 */
> +		chan->move_state = L2CAP_MOVE_WAIT_RSP_SUCCESS;
> +		break;
> +	case L2CAP_MOVE_WAIT_LOGICAL_CFM:
> +		if (test_bit(CONN_LOCAL_BUSY, &chan->conn_state)) {
> +			chan->move_state = L2CAP_MOVE_WAIT_LOCAL_BUSY;
> +		} else if (chan->move_role == L2CAP_MOVE_ROLE_INITIATOR) {
> +			chan->move_state = L2CAP_MOVE_WAIT_CONFIRM_RSP;
> +			l2cap_send_move_chan_cfm(chan->conn, chan, chan->scid,
> +						 L2CAP_MR_SUCCESS);
> +			__set_chan_timer(chan, L2CAP_MOVE_TIMEOUT);
> +		} else if (chan->move_role == L2CAP_MOVE_ROLE_RESPONDER) {
> +			chan->move_state = L2CAP_MOVE_WAIT_CONFIRM;
> +			l2cap_send_move_chan_rsp(chan->conn, chan->ident,
> +						 chan->dcid, L2CAP_MR_SUCCESS);

Is the any chance to create a generic helper for the send_move_chan_*
for both roles. I have seen this snipped a few times.

> +		}
> +		break;
> +	default:
> +		/* Move was not in expected state, free the channel */
> +		chan->hs_hchan = NULL;
> +		chan->hs_hcon = NULL;
> +
> +		/* Placeholder - free the logical link */

Maybe centralizing this is a helper function. Or do we expect something
different here.

> +
> +		chan->move_state = L2CAP_MOVE_STABLE;
> +	}
> +}
> +
> +/* Call with chan locked */
>  static void l2cap_logical_cfm(struct l2cap_chan *chan, struct hci_chan *hchan,
>  			      u8 status)
>  {
> -	/* Placeholder */
> -	return;
> +	BT_DBG("chan %p, hchan %p, status %d", chan, hchan, status);
> +
> +	if (status) {
> +		l2cap_logical_fail(chan);
> +	} else if (chan->state != BT_CONNECTED) {
> +		/* Ignore logical link if channel is on BR/EDR */
> +		if (chan->local_amp_id)
> +			l2cap_logical_create_channel(chan, hchan);
> +	} else {
> +		l2cap_logical_move_channel(chan, hchan);
> +	}
>  }
>  
>  static inline int l2cap_move_channel_req(struct l2cap_conn *conn,

Regards

Marcel


