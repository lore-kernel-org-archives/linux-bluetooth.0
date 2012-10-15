Return-Path: <cyrus@holtmann.org>
Message-ID: <1350326317.26318.16.camel@aeonflux>
Subject: Re: [PATCH 11/19] Bluetooth: Add move confirm response handling
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	sunnyk@codeaurora.org
Date: Mon, 15 Oct 2012 20:38:37 +0200
In-Reply-To: <1350315248-7690-12-git-send-email-mathewm@codeaurora.org>
References: <1350315248-7690-1-git-send-email-mathewm@codeaurora.org>
	 <1350315248-7690-12-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> The move confirm response concludes the channel move command sequence.
> Receipt of this command indicates that data may begin to flow again.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap_core.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 7e31e98..ac9d34a 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4632,6 +4632,7 @@ static inline int l2cap_move_channel_confirm_rsp(struct l2cap_conn *conn,
>  						 u16 cmd_len, void *data)
>  {
>  	struct l2cap_move_chan_cfm_rsp *rsp = data;
> +	struct l2cap_chan *chan;
>  	u16 icid;
>  
>  	if (cmd_len != sizeof(*rsp))
> @@ -4641,6 +4642,31 @@ static inline int l2cap_move_channel_confirm_rsp(struct l2cap_conn *conn,
>  
>  	BT_DBG("icid 0x%4.4x", icid);
>  
> +	chan = l2cap_get_chan_by_scid(conn, icid);
> +	if (!chan)
> +		return 0;
> +
> +	__clear_chan_timer(chan);
> +
> +	if (chan->move_state == L2CAP_MOVE_WAIT_CONFIRM_RSP) {
> +		chan->move_state = L2CAP_MOVE_STABLE;
> +		chan->local_amp_id = chan->move_id;
> +
> +		if (!chan->local_amp_id && chan->hs_hchan) {
> +			/* Have moved off of AMP, free the channel */
> +			chan->hs_hchan = NULL;
> +			chan->hs_hcon = NULL;
> +
> +			/* Placeholder - free the logical link */
> +		}
> +
> +		l2cap_move_success(chan);
> +
> +		chan->move_role = L2CAP_MOVE_ROLE_NONE;
> +	}
> +
> +	l2cap_chan_unlock(chan);
> +
>  	return 0;
>  }
>  

this is how it looks fine to me. We should be doing it this style
everywhere.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


