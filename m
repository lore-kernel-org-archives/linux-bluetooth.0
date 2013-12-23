Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Dec 2013 19:06:51 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2] btdev: Return Command Status for Authentication
 Requested
Message-ID: <20131223170651.GA17118@x220.p-661hnu-f1>
References: <1387811245-21272-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387811245-21272-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Dec 23, 2013, Andrei Emeltchenko wrote:
> Add support for "Authentication Requested" command
> ---
>  emulator/btdev.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/emulator/btdev.c b/emulator/btdev.c
> index d0dff74..b1e804b 100644
> --- a/emulator/btdev.c
> +++ b/emulator/btdev.c
> @@ -268,6 +268,7 @@ static void set_bredr_commands(struct btdev *btdev)
>  	btdev->commands[0]  |= 0x80;	/* Cancel Create Connection */
>  	btdev->commands[1]  |= 0x01;	/* Accept Connection Request */
>  	btdev->commands[1]  |= 0x02;	/* Reject Connection Request */
> +	btdev->commands[1]  |= 0x80;	/* Authentication Requested */
>  	btdev->commands[2]  |= 0x08;	/* Remote Name Request */
>  	btdev->commands[2]  |= 0x10;	/* Cancel Remote Name Request */
>  	btdev->commands[2]  |= 0x20;	/* Read Remote Supported Features */
> @@ -1191,6 +1192,12 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
>  		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
>  		break;
>  
> +	case BT_HCI_CMD_AUTH_REQUESTED:
> +		if (btdev->type == BTDEV_TYPE_LE)
> +			return;

I think this should be "goto unsupported;" instead of a direct return.

Johan
