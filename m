Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCHv2] Bluetooth: btusb: Fix Intel controller hang after shutdown
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1432218957-3400-1-git-send-email-loic.poulain@intel.com>
Date: Thu, 21 May 2015 21:56:19 +0200
Cc: tedd.an@intel.com, linux-bluetooth@vger.kernel.org
Message-Id: <69A96222-5518-4341-9F0B-32F3CEACCC35@holtmann.org>
References: <1432218957-3400-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

> The vendor command (0xfc3f) in btusb_shutdown_intel causes an internal
> reset with old firmware. After that, upcoming HCI command will hang due
> to a controller bug with the first HCI command sent to it.
> The workaround is to send HCI Reset command first which will reset the
> number of completed commands.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> v2: Send HCI reset from shutdown instead of using HCI_QUIRK_RESET_ON_CLOSE
> drivers/bluetooth/btusb.c | 13 +++++++++++++
> 1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index d21f3b4..589f30c 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2705,6 +2705,19 @@ static int btusb_shutdown_intel(struct hci_dev *hdev)
> 	}
> 	kfree_skb(skb);
> 
> +	/* The 0xfc3f command causes an internal reset with old firmware.
> +	 * In order to avoid the Bug with the first HCI command, we have
> +	 * to send a HCI reset which will reset the number of completed
> +	 * command.
> +	 */
> +	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		BT_ERR("%s: Shutdown HCI reset command failed (%ld)",
> +			hdev->name, PTR_ERR(skb));
> +		return PTR_ERR(skb);
> +	}
> +	kfree_skb(skb);
> +

please test this change and see if it still has the desired effect. ACK or NACK the patch based on your testing.

Regards

Marcel

