Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Aug 2012 16:51:07 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	pkrystad@codeaurora.org
Subject: Re: [RFCv0 14/21] Bluetooth: Handle physical link completion
Message-ID: <20120815135105.GA3555@aemeltch-MOBL1>
References: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
 <1343260274-11953-15-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343260274-11953-15-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Wed, Jul 25, 2012 at 04:51:06PM -0700, Mat Martineau wrote:
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap_core.c | 147 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 147 insertions(+)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index d981d87..7e253ce 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -975,6 +975,19 @@ static void l2cap_send_conn_req(struct l2cap_chan *chan)
>  	l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_REQ, sizeof(req), &req);
>  }
>  
> +static void l2cap_send_create_chan_req(struct l2cap_chan *chan, u8 chan_id)
> +{
> +	struct l2cap_create_chan_req req;
> +	req.scid = cpu_to_le16(chan->scid);
> +	req.psm  = chan->psm;
> +	req.amp_id = chan_id;
> +
> +	chan->ident = l2cap_get_ident(chan->conn);
> +
> +	l2cap_send_cmd(chan->conn, chan->ident, L2CAP_CREATE_CHAN_REQ,
> +		       sizeof(req), &req);
> +}
> +
>  static void l2cap_move_setup(struct l2cap_chan *chan)
>  {
>  	struct sk_buff *skb;
> @@ -4119,6 +4132,24 @@ static int l2cap_create_channel_req(struct l2cap_conn *conn,
>  	return 0;
>  }
>  
> +static void l2cap_send_move_chan_req(struct l2cap_chan *chan, u8 dest_amp_id)
> +{
> +	struct l2cap_move_chan_req req;
> +	u8 ident;
> +
> +	BT_DBG("chan %p, dest_amp_id %d", chan, dest_amp_id);
> +
> +	ident = l2cap_get_ident(chan->conn);
> +	if (chan)

I think that the check is not needed otherwise you crash at referencing
chan->scid below.

> +		chan->ident = ident;
> +
> +	req.icid = cpu_to_le16(chan->scid);
> +	req.dest_amp_id = dest_amp_id;
> +
> +	l2cap_send_cmd(chan->conn, ident, L2CAP_MOVE_CHAN_REQ, sizeof(req),
> +		       &req);
> +}
> +
>  static void l2cap_send_move_chan_rsp(struct l2cap_conn *conn, u8 ident,
>  				     u16 icid, u16 result)
>  {
> @@ -4284,6 +4315,122 @@ static void l2cap_logical_cfm(struct l2cap_chan *chan, struct hci_chan *hchan,
>  	}
>  }
>  
> +void l2cap_physical_cfm(struct l2cap_chan *chan, int result, u8 local_id,
> +			u8 remote_id)
> +{
> +	BT_DBG("chan %p, result %d, local_id %d, remote_id %d", chan, result,
> +	       local_id, remote_id);
> +
> +	l2cap_chan_lock(chan);
> +
> +	if (chan->state == BT_DISCONN || chan->state == BT_CLOSED) {
> +		l2cap_chan_unlock(chan);
> +		return;
> +	}
> +
> +	if (chan->state != BT_CONNECTED) {
> +		if (!test_bit(CONF_CONNECT_PEND, &chan->conf_state)) {
> +			struct l2cap_conn_rsp rsp;
> +			char buf[128];
> +			rsp.scid = cpu_to_le16(chan->dcid);
> +			rsp.dcid = cpu_to_le16(chan->scid);
> +
> +			/* Incoming channel on AMP */
> +			if (result == L2CAP_CR_SUCCESS) {
> +				/* Send successful response */
> +				rsp.result = cpu_to_le16(L2CAP_CR_SUCCESS);
> +				rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);
> +			} else {
> +				/* Send negative response */
> +				rsp.result = cpu_to_le16(L2CAP_CR_NO_MEM);
> +				rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);
> +			}
> +
> +			l2cap_send_cmd(chan->conn, chan->ident,
> +				       L2CAP_CREATE_CHAN_RSP,
> +				       sizeof(rsp), &rsp);
> +
> +			if (result == L2CAP_CR_SUCCESS) {
> +				__l2cap_state_change(chan, BT_CONFIG);
> +				set_bit(CONF_REQ_SENT, &chan->conf_state);
> +				l2cap_send_cmd(chan->conn,
> +					       l2cap_get_ident(chan->conn),
> +					       L2CAP_CONF_REQ,
> +					       l2cap_build_conf_req(chan, buf),
> +					       buf);
> +				chan->num_conf_req++;
> +			}
> +		} else {
> +			/* Outgoing channel on AMP */
> +			if (result == L2CAP_CR_SUCCESS) {
> +				chan->chan_id = local_id;
> +				l2cap_send_create_chan_req(chan, remote_id);
> +			} else {
> +				/* Revert to BR/EDR connect */
> +				l2cap_send_conn_req(chan);
> +			}
> +		}
> +	} else if (result == L2CAP_MR_SUCCESS &&
> +		   chan->move_role == L2CAP_MOVE_ROLE_INITIATOR) {
> +		l2cap_move_setup(chan);
> +		chan->move_id = local_id;
> +		chan->move_state = L2CAP_MOVE_WAIT_RSP;
> +
> +		l2cap_send_move_chan_req(chan, remote_id);
> +		__set_chan_timer(chan, L2CAP_MOVE_TIMEOUT);
> +	} else if (result == L2CAP_MR_SUCCESS &&
> +		   chan->move_role == L2CAP_MOVE_ROLE_RESPONDER) {
> +		struct hci_chan *hchan = NULL;
> +
> +		/* Placeholder - get hci_chan for logical link */
> +
> +		if (hchan) {
> +			if (hchan->state == BT_CONNECTED) {
> +				/* Logical link is ready to go */
> +				chan->hs_hcon = hchan->conn;
> +				chan->hs_hcon->l2cap_data = chan->conn;
> +				chan->move_state = L2CAP_MOVE_WAIT_CONFIRM;
> +				l2cap_send_move_chan_rsp(chan->conn,
> +							 chan->move_cmd_ident,
> +							 chan->dcid,
> +							 L2CAP_MR_SUCCESS);
> +
> +				l2cap_logical_cfm(chan, hchan,
> +						  L2CAP_MR_SUCCESS);
> +			} else {
> +				/* Wait for logical link to be ready */
> +				chan->move_state = L2CAP_MOVE_WAIT_LOGICAL_CFM;
> +			}
> +		} else {
> +			/* Logical link not available */
> +			l2cap_send_move_chan_rsp(chan->conn,
> +						 chan->move_cmd_ident,
> +						 chan->dcid,
> +						 L2CAP_MR_NOT_ALLOWED);
> +		}
> +	} else {
> +		if (chan->move_role == L2CAP_MOVE_ROLE_RESPONDER) {
> +			u8 rsp_result;
> +			if (result == -EINVAL)
> +				rsp_result = L2CAP_MR_BAD_ID;
> +			else
> +				rsp_result = L2CAP_MR_NOT_ALLOWED;
> +
> +			l2cap_send_move_chan_rsp(chan->conn,
> +						 chan->move_cmd_ident,
> +						 chan->dcid, rsp_result);
> +		}
> +
> +		chan->move_role = L2CAP_MOVE_ROLE_NONE;
> +		chan->move_state = L2CAP_MOVE_STABLE;
> +
> +		/* Restart data transmission */
> +		l2cap_ertm_send(chan);
> +	}
> +
> +	l2cap_chan_unlock(chan);
> +}

I feel that this function is too big. Maybe we could split channel move
and channel create operations?

Best regards 
Andrei Emeltchenko 

