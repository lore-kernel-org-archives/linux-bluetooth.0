Return-Path: <cyrus@holtmann.org>
Message-ID: <1321893880.2011.14.camel@aeonflux>
Subject: Re: [PATCH 2/2] Bluetooth: Ignore HCI_Read_Local_Commands failures
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 21 Nov 2011 17:44:40 +0100
In-Reply-To: <1321888740-15598-2-git-send-email-johan.hedberg@gmail.com>
References: <1321888740-15598-1-git-send-email-johan.hedberg@gmail.com>
	 <1321888740-15598-2-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Some 1.2 controllers will fail the HCI_Read_Local_Commands HCI command
> even though (according to the specification) they should support it.
> Since this HCI command is part of the controller init sequence
> controllers broken in this manner would be unusable. Since not having
> the list of supported commands is not critical for these controllers it
> is better to just ignore failures in this case (additionally, this is
> also how older kernels used to behave).
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_core.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 9218888..1719257 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -106,6 +106,13 @@ void hci_req_complete(struct hci_dev *hdev, __u16 cmd, int result)
>  	if (test_bit(HCI_INIT, &hdev->flags) && hdev->init_last_cmd != cmd)
>  		return;
>  
> +	/* Some 1.2 controllers report failure for HCI_Read_Local_Commands
> +	 * even though they should support it. Since it's not a critical
> +	 * issue not to have a proper result from them just ignore a
> +	 * failure status */
> +	if (cmd == HCI_OP_READ_LOCAL_COMMANDS && result != 0)
> +		result = 0;
> +

this is pretty ugly handling. Can't we come up with something better?

Regards

Marcel


