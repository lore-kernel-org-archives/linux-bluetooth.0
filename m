Return-Path: <cyrus@holtmann.org>
Date: Fri, 19 Oct 2012 11:25:41 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	sunnyk@codeaurora.org, marcel@holtmann.org
Subject: Re: [PATCHv3 11/18] Bluetooth: Add move confirm response handling
Message-ID: <20121019082540.GH4249@aemeltch-MOBL1>
References: <1350583130-3241-1-git-send-email-mathewm@codeaurora.org>
 <1350583130-3241-12-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350583130-3241-12-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Thu, Oct 18, 2012 at 10:58:43AM -0700, Mat Martineau wrote:
> The move confirm response concludes the channel move command sequence.
> Receipt of this command indicates that data may begin to flow again.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>

Acked-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com> 

> ---
>  net/bluetooth/l2cap_core.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 8e50685..f315530 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4661,6 +4661,7 @@ static inline int l2cap_move_channel_confirm_rsp(struct l2cap_conn *conn,
>  						 u16 cmd_len, void *data)
>  {
>  	struct l2cap_move_chan_cfm_rsp *rsp = data;
> +	struct l2cap_chan *chan;
>  	u16 icid;
>  
>  	if (cmd_len != sizeof(*rsp))
> @@ -4670,6 +4671,31 @@ static inline int l2cap_move_channel_confirm_rsp(struct l2cap_conn *conn,
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
> -- 
> 1.7.12.3
> 
> --
> Mat Martineau
> 
> Employee of Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
