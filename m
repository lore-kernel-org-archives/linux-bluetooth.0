Return-Path: <cyrus@holtmann.org>
Message-ID: <1350493806.26318.115.camel@aeonflux>
Subject: Re: [PATCH 07/19] Bluetooth: Add move channel confirm handling
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	sunnyk@codeaurora.org
Date: Wed, 17 Oct 2012 10:10:06 -0700
In-Reply-To: <alpine.DEB.2.02.1210161020250.13129@mathewm-linux>
References: <1350315248-7690-1-git-send-email-mathewm@codeaurora.org>
	  <1350315248-7690-8-git-send-email-mathewm@codeaurora.org>
	 <1350325523.26318.10.camel@aeonflux>
	 <alpine.DEB.2.02.1210161020250.13129@mathewm-linux>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> >> After sending a move channel response, a move responder waits for a
> >> move channel confirm command.  If the received command has a
> >> "confirmed" result the move is proceeding, and "unconfirmed" means the
> >> move has failed and the channel will not change controllers.
> >>
> >> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> >> ---
> >>  net/bluetooth/l2cap_core.c | 70 ++++++++++++++++++++++++++++++++++++++++++++--
> >>  1 file changed, 67 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> >> index aab7f79..ef744a9 100644
> >> --- a/net/bluetooth/l2cap_core.c
> >> +++ b/net/bluetooth/l2cap_core.c
> >> @@ -1030,6 +1030,42 @@ static void l2cap_move_setup(struct l2cap_chan *chan)
> >>  	set_bit(CONN_REMOTE_BUSY, &chan->conn_state);
> >>  }
> >>
> >> +static void l2cap_move_success(struct l2cap_chan *chan)
> >> +{
> >> +	BT_DBG("chan %p", chan);
> >> +
> >> +	if (chan->mode != L2CAP_MODE_ERTM)
> >> +		return;
> >> +
> >> +	switch (chan->move_role) {
> >> +	case L2CAP_MOVE_ROLE_INITIATOR:
> >> +		l2cap_tx(chan, NULL, NULL, L2CAP_EV_EXPLICIT_POLL);
> >> +		chan->rx_state = L2CAP_RX_STATE_WAIT_F;
> >> +		break;
> >> +	case L2CAP_MOVE_ROLE_RESPONDER:
> >> +		chan->rx_state = L2CAP_RX_STATE_WAIT_P;
> >> +		break;
> >> +	}
> >> +}
> >> +
> >> +static void l2cap_move_revert(struct l2cap_chan *chan)
> >> +{
> >> +	BT_DBG("chan %p", chan);
> >> +
> >> +	if (chan->mode != L2CAP_MODE_ERTM)
> >> +		return;
> >> +
> >> +	switch (chan->move_role) {
> >> +	case L2CAP_MOVE_ROLE_INITIATOR:
> >> +		l2cap_tx(chan, NULL, NULL, L2CAP_EV_EXPLICIT_POLL);
> >> +		chan->rx_state = L2CAP_RX_STATE_WAIT_F;
> >> +		break;
> >> +	case L2CAP_MOVE_ROLE_RESPONDER:
> >> +		chan->rx_state = L2CAP_RX_STATE_WAIT_P;
> >> +		break;
> >> +	}
> >> +}
> >> +
> >>  static void l2cap_chan_ready(struct l2cap_chan *chan)
> >>  {
> >>  	/* This clears all conf flags, including CONF_NOT_COMPLETE */
> >> @@ -4297,11 +4333,12 @@ static inline int l2cap_move_channel_rsp(struct l2cap_conn *conn,
> >>  	return 0;
> >>  }
> >>
> >> -static inline int l2cap_move_channel_confirm(struct l2cap_conn *conn,
> >> -					     struct l2cap_cmd_hdr *cmd,
> >> -					     u16 cmd_len, void *data)
> >> +static int l2cap_move_channel_confirm(struct l2cap_conn *conn,
> >> +				      struct l2cap_cmd_hdr *cmd,
> >> +				      u16 cmd_len, void *data)
> >>  {
> >>  	struct l2cap_move_chan_cfm *cfm = data;
> >> +	struct l2cap_chan *chan;
> >>  	u16 icid, result;
> >>
> >>  	if (cmd_len != sizeof(*cfm))
> >> @@ -4312,8 +4349,35 @@ static inline int l2cap_move_channel_confirm(struct l2cap_conn *conn,
> >>
> >>  	BT_DBG("icid 0x%4.4x, result 0x%4.4x", icid, result);
> >>
> >> +	chan = l2cap_get_chan_by_dcid(conn, icid);
> >> +	if (!chan)
> >> +		goto send_move_confirm_response;
> >> +
> >> +	if (chan->move_state == L2CAP_MOVE_WAIT_CONFIRM) {
> >> +		chan->move_state = L2CAP_MOVE_STABLE;
> >> +		if (result == L2CAP_MC_CONFIRMED) {
> >> +			chan->local_amp_id = chan->move_id;
> >> +			if (!chan->local_amp_id) {
> >> +				/* Have moved off of AMP, free the channel */
> >> +				chan->hs_hchan = NULL;
> >> +				chan->hs_hcon = NULL;
> >> +
> >> +				/* Placeholder - free the logical link */
> >> +			}
> >> +			l2cap_move_success(chan);
> >> +		} else {
> >> +			chan->move_id = chan->local_amp_id;
> >> +			l2cap_move_revert(chan);
> >> +		}
> >> +		chan->move_role = L2CAP_MOVE_ROLE_NONE;
> >> +	}
> >> +
> >> +send_move_confirm_response:
> >>  	l2cap_send_move_chan_cfm_rsp(conn, cmd->ident, icid);
> >>
> >> +	if (chan)
> >> +		l2cap_chan_unlock(chan);
> >> +
> >>  	return 0;
> >>  }
> >>
> >
> > the more I read into this one, can we not have a clean exit when (!chan)
> > for this one. Or am I missing something.
> 
> Are you thinking this should send a COMMAND_REJ if it can't find the 
> matching channel?
> 
> I think sending the confirm response is the appropriate thing to do. 
> The spec says "When a device receives a Move Channel Confirmation 
> packet it shall send a Move Channel Confirmation response packet".
> Sending this response doesn't indicate that the move was successful.

I am fine with sending a response packet. However we might have to make
it explicit a response with success and response with failure. My
concern is that the code becomes complex and hard to follow.

Regards

Marcel


