Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [RFC] btdev: Send Link Key Request on Authentication Requested
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1387812799-21728-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Mon, 23 Dec 2013 07:41:04 -0800
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <A4B43619-23FC-4B82-BFBE-7B701C9B45A7@holtmann.org>
References: <1387812799-21728-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> The Link Key Request event shall be generated when Simple Pairing Mode
> is enabled.
> ---
> emulator/btdev.c | 13 +++++++++++++
> 1 file changed, 13 insertions(+)
> 
> diff --git a/emulator/btdev.c b/emulator/btdev.c
> index b1e804b..c0cfdef 100644
> --- a/emulator/btdev.c
> +++ b/emulator/btdev.c
> @@ -2005,6 +2005,19 @@ static void default_cmd_completion(struct btdev *btdev, uint16_t opcode,
> 		conn_complete(btdev, rcr->bdaddr, BT_HCI_ERR_UNKNOWN_CONN_ID);
> 		break;
> 
> +	case BT_HCI_CMD_AUTH_REQUESTED:
> +		if (btdev->type == BTDEV_TYPE_LE)
> +			return;

please make sure that you send correct command status event first. The Core specification is pretty detailed on what needs to be send when here.

> +
> +		if (btdev->simple_pairing_mode) {
> +			struct bt_hci_evt_link_key_request lkr;
> +
> +			memcpy(lkr.bdaddr, btdev->conn->bdaddr, 6);
> +			send_event(btdev, BT_HCI_EVT_LINK_KEY_REQUEST, &lkr,
> +								sizeof(lkr));
> +		}
> +		break;
> +
> 	case BT_HCI_CMD_REMOTE_NAME_REQUEST:
> 		if (btdev->type == BTDEV_TYPE_LE)
> 			return;

Regards

Marcel

