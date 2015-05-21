Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] Bluetooth: btusb: Fix Intel controller hang after shutdown
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1432208564-3341-1-git-send-email-loic.poulain@intel.com>
Date: Thu, 21 May 2015 14:24:35 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <9FDA3DA7-41A0-4380-A79B-8F5F867BB7C7@holtmann.org>
References: <1432208564-3341-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> The vendor command (0xfc3f) in btusb_shutdown_intel causes an internal
> reset with old firmware. The controller has a bug with the first HCI
> command sent to it. The workaround is to send HCI Reset command first
> which will reset the number of completed commands.
> 
> This patch adds the HCI_QUIRK_RESET_ON_CLOSE flag for Intel controller
> so that a HCI reset command will always follow a intel shutdown.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> drivers/bluetooth/btusb.c | 7 +++++++
> 1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index d21f3b4..36881e8 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3140,6 +3140,13 @@ static int btusb_probe(struct usb_interface *intf,
> 		hdev->set_bdaddr = btintel_set_bdaddr;
> 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
> 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
> +
> +		/* The shutdown causes an internal reset with old firmware.
> +		 * In order to avoid the Bug with the first HCI command, we have
> +		 * to send a HCI reset which will reset the number of completed
> +		 * command.
> +		 */
> +		set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);

the problem with this quirk is that the HCI Reset is now never sent when brining up the controller. That is not the right fix either. I think it needs to be in the Intel specific shutdown callback.

Not sending HCI Reset as the first command should only be done for Bluetooth 1.0b controllers and some Bluetooth 1.1 controllers. For all others sending HCI Reset as first command is the right thing to do.

Regards

Marcel

