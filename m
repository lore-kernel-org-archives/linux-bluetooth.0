Return-Path: <cyrus@holtmann.org>
Message-ID: <1350494669.26318.123.camel@aeonflux>
Subject: Re: [PATCHv2 17/19] Bluetooth: Send create channel request instead
 of connect for AMP
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	sunnyk@codeaurora.org
Date: Wed, 17 Oct 2012 10:24:29 -0700
In-Reply-To: <1350430593-23565-18-git-send-email-mathewm@codeaurora.org>
References: <1350430593-23565-1-git-send-email-mathewm@codeaurora.org>
	 <1350430593-23565-18-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> When the channel policy is set to prefer AMP, then an L2CAP channel is
> set up using the "create channel" command rather than the "connect"
> command.  A physical link is also set up before sending "create
> channel".
> 
> Behavior is unchanged if enable_hs is false.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap_core.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 7e8fe84..17d917b 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -58,6 +58,9 @@ static void l2cap_send_disconn_req(struct l2cap_conn *conn,
>  static void l2cap_tx(struct l2cap_chan *chan, struct l2cap_ctrl *control,
>  		     struct sk_buff_head *skbs, u8 event);
>  
> +static void l2cap_logical_cfm(struct l2cap_chan *chan, struct hci_chan *hchan,
> +			      u8 status);
> +

any chance to avoid this forward declaration by moving some functions
around?

>  /* ---- L2CAP channels ---- */
>  
>  static struct l2cap_chan *__l2cap_get_chan_by_dcid(struct l2cap_conn *conn,
> @@ -576,6 +579,13 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
>  			mgr->bredr_chan = NULL;
>  	}
>  
> +	if (chan->hs_hchan) {
> +		chan->hs_hchan = NULL;
> +		chan->hs_hcon = NULL;
> +
> +		/* Placeholder - free logical link */
> +	}
> +
>  	chan->ops->teardown(chan, err);
>  
>  	if (test_bit(CONF_NOT_COMPLETE, &chan->conf_state))
> @@ -1126,6 +1136,7 @@ static void l2cap_start_connection(struct l2cap_chan *chan)
>  {
>  	if (__amp_capable(chan)) {
>  		BT_DBG("chan %p AMP capable: discover AMPs", chan);
> +		set_bit(CONF_CONNECT_PEND, &chan->conf_state);
>  		a2mp_discover_amp(chan);
>  	} else {
>  		l2cap_send_conn_req(chan);
> @@ -1271,6 +1282,16 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
>  				rsp.status = __constant_cpu_to_le16(L2CAP_CS_AUTHEN_PEND);
>  			}
>  
> +			if (rsp.result == __constant_cpu_to_le16(L2CAP_CR_SUCCESS) &&
> +			    chan->local_amp_id) {
> +				/* Placeholder - uncomment when amp functions
> +				 * are available
> +				amp_accept_physical(chan, chan->local_amp_id);
> +				 */
> +				l2cap_chan_unlock(chan);
> +				continue;
> +			}
> +
>  			l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_RSP,
>  				       sizeof(rsp), &rsp);
>  
> @@ -3359,6 +3380,18 @@ done:
>  			rfc.mode = chan->mode;
>  		}
>  
> +		if (test_bit(CONF_LOC_CONF_PEND, &chan->conf_state) &&
> +		    chan->local_amp_id) {
> +			struct hci_chan *hchan = NULL;
> +
> +			/* Placeholder - get hci_chan for logical link */
> +
> +			if (hchan && hchan->state == BT_CONNECTED) {
> +				l2cap_logical_cfm(chan, hchan,
> +						  L2CAP_MR_SUCCESS);
> +			}
> +		}
> +
>  		if (result == L2CAP_CONF_SUCCESS)
>  			set_bit(CONF_OUTPUT_DONE, &chan->conf_state);
>  	}
> @@ -6367,6 +6400,15 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
>  					stat = L2CAP_CS_AUTHOR_PEND;
>  					chan->ops->defer(chan);
>  				} else {
> +					if (chan->local_amp_id) {
> +						/* Placeholder - accept physical
> +						 * link
> +						amp_accept_physical(chan,
> +							chan->local_amp_id);
> +						*/
> +						continue;
> +					}
> +
>  					__l2cap_state_change(chan, BT_CONFIG);
>  					res = L2CAP_CR_SUCCESS;
>  					stat = L2CAP_CS_NO_INFO;

Check the forward declaration and fix it if possible. Otherwise this is
fine.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


