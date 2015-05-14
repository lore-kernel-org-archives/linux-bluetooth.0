Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] btdev: Add LE Encrypt command support to emulator
Date: Thu, 14 May 2015 17:13:53 +0200
Message-ID: <4300955.AQe8Faykq9@leonov>
In-Reply-To: <1431518942-24753-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1431518942-24753-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wednesday 13 of May 2015 15:09:00 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Add basic crypto support to btdev using Linux crypto infrastructure.
> ---
>  emulator/btdev.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/emulator/btdev.c b/emulator/btdev.c
> index ad65cf8..c95a5c7 100644
> --- a/emulator/btdev.c
> +++ b/emulator/btdev.c
> @@ -35,6 +35,7 @@
> 
>  #include "src/shared/util.h"
>  #include "src/shared/timeout.h"
> +#include "src/shared/crypto.h"
>  #include "monitor/bt.h"
>  #include "btdev.h"
> 
> @@ -75,6 +76,8 @@ struct btdev {
> 
>  	struct hook *hook_list[MAX_HOOK_ENTRIES];
> 
> +	struct bt_crypto *crypto;
> +
>          uint16_t manufacturer;
>          uint8_t  version;
>  	uint16_t revision;
> @@ -414,6 +417,7 @@ static void set_le_commands(struct btdev *btdev)
>  	btdev->commands[26] |= 0x04;	/* LE Set Scan Parameters */
>  	btdev->commands[26] |= 0x08;	/* LE Set Scan Enable */
>  	btdev->commands[26] |= 0x40;	/* LE Read White List Size */
> +	btdev->commands[27] |= 0x40;	/* LE Encrypt */
>  	btdev->commands[27] |= 0x80;	/* LE Rand */
>  	btdev->commands[28] |= 0x08;	/* LE Read Supported States */
>  	btdev->commands[28] |= 0x10;	/* LE Receiver Test */
> @@ -605,6 +609,9 @@ struct btdev *btdev_create(enum btdev_type type,
> uint16_t id)
> 
>  	get_bdaddr(id, index, btdev->bdaddr);
> 
> +	if (type == BTDEV_TYPE_BREDRLE || type == BTDEV_TYPE_LE)
> +		btdev->crypto = bt_crypto_new();

bt_crypto_new() may fail if kernel is missing support for it. Should it be 
checked here?

Also crypto should be cleaned up in btdev_destroy().

> +
>  	return btdev;
>  }
> 
> @@ -1910,6 +1917,7 @@ static void default_cmd(struct btdev *btdev, uint16_t
> opcode, const struct bt_hci_cmd_le_set_scan_enable *lsse;
>  	const struct bt_hci_cmd_le_start_encrypt *lse;
>  	const struct bt_hci_cmd_le_ltk_req_reply *llrr;
> +	const struct bt_hci_cmd_le_encrypt *lenc_cmd;
>  	const struct bt_hci_cmd_read_local_amp_assoc *rlaa_cmd;
>  	const struct bt_hci_cmd_read_rssi *rrssi;
>  	const struct bt_hci_cmd_read_tx_power *rtxp;
> @@ -1956,6 +1964,7 @@ static void default_cmd(struct btdev *btdev, uint16_t
> opcode, struct bt_hci_rsp_le_read_adv_tx_power lratp;
>  	struct bt_hci_rsp_le_read_supported_states lrss;
>  	struct bt_hci_rsp_le_read_white_list_size lrwls;
> +	struct bt_hci_rsp_le_encrypt lenc;
>  	struct bt_hci_rsp_le_rand lr;
>  	struct bt_hci_rsp_le_test_end lte;
>  	struct bt_hci_rsp_remote_name_request_cancel rnrc_rsp;
> @@ -2860,6 +2869,20 @@ static void default_cmd(struct btdev *btdev, uint16_t
> opcode, cmd_complete(btdev, opcode, &status, sizeof(status));
>  		break;
> 
> +	case BT_HCI_CMD_LE_ENCRYPT:
> +		if (btdev->type == BTDEV_TYPE_BREDR)
> +			goto unsupported;
> +		lenc_cmd = data;
> +		if (!bt_crypto_e(btdev->crypto, lenc_cmd->key,
> +				 lenc_cmd->plaintext, lenc.data)) {
> +			cmd_status(btdev, BT_HCI_ERR_COMMAND_DISALLOWED,
> +				   opcode);
> +			break;
> +		}
> +		lenc.status = BT_HCI_ERR_SUCCESS;
> +		cmd_complete(btdev, opcode, &lenc, sizeof(lenc));
> +		break;
> +
>  	case BT_HCI_CMD_LE_READ_SUPPORTED_STATES:
>  		if (btdev->type == BTDEV_TYPE_BREDR)
>  			goto unsupported;

-- 
BR
Szymon Janc
