Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCHv1] Bluetooth: Check supported commands before run
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1423237552-23080-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Fri, 6 Feb 2015 09:00:39 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <7CB14AA1-0C38-4FA3-89FA-72D4BE4BC8FF@holtmann.org>
References: <1423237552-23080-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1423237552-23080-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Despite AMP initialization sequence commands are mandatory according to
> Bluetooth Spec, some implementations do not support all mentioned
> commands (specifically Remove Read Local Supported Features).
> Initialization sequence is split to two stages, second stage only run
> commands mentioned in Local Supported Commands response.
> Fixes following bug:
> ...
> < HCI Command: Read Local Supported Fea.. (0x04|0x0003) plen 0  [hci1]
> 6.525974
>> HCI Event: Command Status (0x0f) plen 4                       [hci1]
>> 6.542668
>      Read Local Supported Features (0x04|0x0003) ncmd 1
>        Status: Unknown HCI Command (0x01)
> ...
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
> net/bluetooth/hci_core.c | 56 ++++++++++++++++++++++++++++++------------------
> 1 file changed, 35 insertions(+), 21 deletions(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 3322d3f..5403155 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -399,21 +399,6 @@ static void amp_init(struct hci_request *req)
> 
> 	/* Read Local Supported Commands */
> 	hci_req_add(req, HCI_OP_READ_LOCAL_COMMANDS, 0, NULL);
> -
> -	/* Read Local Supported Features */
> -	hci_req_add(req, HCI_OP_READ_LOCAL_FEATURES, 0, NULL);
> -
> -	/* Read Local AMP Info */
> -	hci_req_add(req, HCI_OP_READ_LOCAL_AMP_INFO, 0, NULL);
> -
> -	/* Read Data Blk size */
> -	hci_req_add(req, HCI_OP_READ_DATA_BLOCK_SIZE, 0, NULL);

lets keep AMP info and block size in the original level 1. They are mandatory and do not have any default values. So if they are not supported, lets fail the init sequence.

> -
> -	/* Read Flow Control Mode */
> -	hci_req_add(req, HCI_OP_READ_FLOW_CONTROL_MODE, 0, NULL);
> -
> -	/* Read Location Data */
> -	hci_req_add(req, HCI_OP_READ_LOCATION_DATA, 0, NULL);

These two make sense to be optional since they have default values attached with it.

Regards

Marcel

> }
> 
> static void hci_init1_req(struct hci_request *req, unsigned long opt)
> @@ -578,6 +563,35 @@ static void hci_init2_req(struct hci_request *req, unsigned long opt)
> {
> 	struct hci_dev *hdev = req->hdev;
> 
> +	if (hdev->dev_type == HCI_AMP) {
> +		/* Check the supported commands and only if the the command
> +		 * is marked as supported send it
> +		 */
> +
> +		/* Read Local Supported Features */
> +		if (hdev->commands[14] & 0x20)
> +			hci_req_add(req, HCI_OP_READ_LOCAL_FEATURES, 0, NULL);
> +
> +		/* Read Local AMP Info */
> +		if (hdev->commands[22] & 0x20)
> +			hci_req_add(req, HCI_OP_READ_LOCAL_AMP_INFO, 0, NULL);
> +
> +		/* Read Data Blk size */
> +		if (hdev->commands[23] & 0x04)
> +			hci_req_add(req, HCI_OP_READ_DATA_BLOCK_SIZE, 0, NULL);
> +
> +		/* Read Flow Control Mode */
> +		if (hdev->commands[23] & 0x01)
> +			hci_req_add(req, HCI_OP_READ_FLOW_CONTROL_MODE, 0,
> +				    NULL);
> +
> +		/* Read Location Data */
> +		if (hdev->commands[22] & 0x08)
> +			hci_req_add(req, HCI_OP_READ_LOCATION_DATA, 0, NULL);
> +
> +		return;
> +	}
> +
> 	if (lmp_bredr_capable(hdev))
> 		bredr_setup(req);
> 	else
> @@ -896,17 +910,17 @@ static int __hci_init(struct hci_dev *hdev)
> 				    &dut_mode_fops);
> 	}
> 
> +	err = __hci_req_sync(hdev, hci_init2_req, 0, HCI_INIT_TIMEOUT);
> +	if (err < 0)
> +		return err;
> +

I honestly was more thinking about an AMP specific 2nd init stage.

Regards

Marcel

