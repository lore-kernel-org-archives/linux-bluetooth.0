Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCHv2 5/9] Bluetooth: Add signal handlers for channel
 creation
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	pkrystad@codeaurora.org, andrei.emeltchenko@intel.com
Date: Wed, 19 Oct 2011 12:02:36 -0700
In-Reply-To: <1319046247-3391-6-git-send-email-mathewm@codeaurora.org>
References: <1319046247-3391-1-git-send-email-mathewm@codeaurora.org>
	 <1319046247-3391-6-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1319050958.15441.165.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> Handle both "create channel request" and "create channel response".
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap_core.c |   45 ++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 45 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index bda6da7..67f0ab6 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -3044,6 +3044,43 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn, struct l2cap_cm
>  	return 0;
>  }
>  
> +static inline int l2cap_create_channel_req(struct l2cap_conn *conn,
> +					struct l2cap_cmd_hdr *cmd, u8 *data)

so I just question myself why we keep doing u8 *data here and not just
fix everything to be a void *data.

> +{
> +	struct l2cap_create_chan_req *req =
> +		(struct l2cap_create_chan_req *) data;

Then these casting stuff would go away. And I bet it is just some
leftover from the original L2CAP code.

Or does anybody else have an idea why we keep on insisting on u8 *data?

> +	struct l2cap_create_chan_rsp rsp;
> +	u16 psm, scid;

I think we might need to have a length check here first to ensure that
the header packet is really full present.

> +
> +	psm = le16_to_cpu(req->psm);
> +	scid = le16_to_cpu(req->scid);

Otherwise this just accesses some random memory.

> +
> +	BT_DBG("psm %d, scid %d, amp_id %d", (int) psm, (int) scid,
> +		(int) req->amp_id);

Why are we casting to (int) here?

> +
> +	if (!enable_hs)
> +		return -EINVAL;
> +
> +	/* Placeholder: Always reject */
> +	rsp.dcid = 0;
> +	rsp.scid = cpu_to_le16(scid);
> +	rsp.result = L2CAP_CR_NO_MEM;
> +	rsp.status = L2CAP_CS_NO_INFO;
> +
> +	l2cap_send_cmd(conn, cmd->ident, L2CAP_CREATE_CHAN_RSP,
> +		       sizeof(rsp), &rsp);
> +
> +	return 0;
> +}
> +
> +static inline int l2cap_create_channel_rsp(struct l2cap_conn *conn,
> +					struct l2cap_cmd_hdr *cmd, u8 *data)
> +{
> +	BT_DBG("conn %p", conn);
> +
> +	return l2cap_connect_rsp(conn, cmd, data);
> +}
> +
>  static inline int l2cap_check_conn_param(u16 min, u16 max, u16 latency,
>  							u16 to_multiplier)
>  {
> @@ -3156,6 +3193,14 @@ static inline int l2cap_bredr_sig_cmd(struct l2cap_conn *conn,
>  		err = l2cap_information_rsp(conn, cmd, data);
>  		break;
>  
> +	case L2CAP_CREATE_CHAN_REQ:
> +		err = l2cap_create_channel_req(conn, cmd, data);
> +		break;
> +
> +	case L2CAP_CREATE_CHAN_RSP:
> +		err = l2cap_create_channel_rsp(conn, cmd, data);
> +		break;
> +
>  	default:
>  		BT_ERR("Unknown BR/EDR signaling command 0x%2.2x", cmd->code);
>  		err = -EINVAL;

Regards

Marcel


