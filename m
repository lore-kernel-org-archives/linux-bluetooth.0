Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCHv3 8/9] Bluetooth: Add signal handlers for channel moves
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	pkrystad@codeaurora.org, andrei.emeltchenko@intel.com
Date: Wed, 02 Nov 2011 07:25:02 +0100
In-Reply-To: <1320186568-25493-9-git-send-email-mathewm@codeaurora.org>
References: <1320186568-25493-1-git-send-email-mathewm@codeaurora.org>
	 <1320186568-25493-9-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1320215103.15441.270.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> AMP channels can be moved between BR/EDR and AMP controllers using a
> sequence of signals. Every attempted channel move involves a series of
> four signals:

<snip>

>  {
> @@ -3266,6 +3390,23 @@ static inline int l2cap_bredr_sig_cmd(struct l2cap_conn *conn,
>  		err = l2cap_create_channel_rsp(conn, cmd, data);
>  		break;
>  
> +	case L2CAP_MOVE_CHAN_REQ:
> +		err = l2cap_move_channel_req(conn, cmd, cmd_len, data);
> +		break;
> +
> +	case L2CAP_MOVE_CHAN_RSP:
> +		err = l2cap_move_channel_rsp(conn, cmd, cmd_len, data);
> +		break;
> +
> +	case L2CAP_MOVE_CHAN_CFM:
> +		err = l2cap_move_channel_confirm(conn, cmd, cmd_len, data);
> +		break;
> +
> +	case L2CAP_MOVE_CHAN_CFM_RSP:
> +		err = l2cap_move_channel_confirm_rsp(conn, cmd, cmd_len, data);
> +		break;
> +
> +
>  	default:
>  		BT_ERR("Unknown BR/EDR signaling command 0x%2.2x", cmd->code);
>  		err = -EINVAL;

and this is the coding style damage. You sneaked in two empty lines
here.

Regards

Marcel


