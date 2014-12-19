Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH] emulator: Fix magic numbers and remove dead code
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1418993645-6921-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Fri, 19 Dec 2014 14:06:53 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <041CE110-B8DA-47BF-8E7F-F206054DD815@holtmann.org>
References: <1418993645-6921-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Removes logically dead code since conditions were already checked in the
> previous statements.

this should be two patches.

> ---
> emulator/le.c | 11 ++---------
> 1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/emulator/le.c b/emulator/le.c
> index 30daa63..91cf31c 100644
> --- a/emulator/le.c
> +++ b/emulator/le.c
> @@ -1236,21 +1236,14 @@ static void cmd_le_set_data_length(struct bt_le *hci,
> 	}
> 
> 	/* Valid range for suggested max TX octets is 0x001b to 0x00fb */
> -	if (tx_len < 0x001b || tx_len > 0x00fb) {
> +	if (tx_len < DEFAULT_TX_LEN || tx_len > MAX_TX_LEN) {

MAX_TX_LEN is our max value. It just happens to be the same max for the parameter. So I would keep the magic numbers here unless we introduce official constants for default, min, max ranges somewhere else.

> 		cmd_status(hci, BT_HCI_ERR_INVALID_PARAMETERS,
> 					BT_HCI_CMD_LE_SET_DATA_LENGTH);
> 		return;
> 	}
> 
> 	/* Valid range for suggested max TX time is 0x0148 to 0x0848 */
> -	if (tx_time < 0x0148 || tx_time > 0x0848) {
> -		cmd_status(hci, BT_HCI_ERR_INVALID_PARAMETERS,
> -					BT_HCI_CMD_LE_SET_DATA_LENGTH);
> -		return;
> -	}
> -
> -	/* Max TX len and time shall be less or equal supported */

And this check is just by accident the same as the other one before. The one before is checking the max allowed values from the specification.

This one is checking our max values. It just happens to be the same. Since this is an emulator and not real code that is heavy optimized, we should instead have hci->le_max_tx_time and hci->le_max_tx_len and assigned to our max value and then check against that.

We do exactly the same for white list size and resolving list size.

> -	if (tx_len > MAX_TX_LEN || tx_time > MAX_TX_TIME) {
> +	if (tx_time < DEFAULT_TX_TIME || tx_time > MAX_TX_TIME) {
> 		cmd_status(hci, BT_HCI_ERR_INVALID_PARAMETERS,
> 					BT_HCI_CMD_LE_SET_DATA_LENGTH);
> 		return;

Regards

Marcel

