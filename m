Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH v2 1/3] Bluetooth: hci_ll: add support for setting public
 address
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1512701860-8321-2-git-send-email-david@lechnology.com>
Date: Fri, 8 Dec 2017 09:07:56 +0100
Cc: devicetree <devicetree@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <8B6C3CFA-35C6-4A9B-90AB-22834B9AE2C4@holtmann.org>
References: <1512701860-8321-1-git-send-email-david@lechnology.com>
 <1512701860-8321-2-git-send-email-david@lechnology.com>
To: David Lechner <david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> This adds support for setting the public address on Texas Instruments
> Bluetooth chips using a vendor-specific command.
> 
> This has been tested on a CC2560A. The TI wiki also indicates that this
> command should work on TI WL17xx/WL18xx Bluetooth chips.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> 
> v2 changes:
> * This is a new patch in v2
> 
> drivers/bluetooth/hci_ll.c | 17 +++++++++++++++++
> 1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
> index 974a788..b732004 100644
> --- a/drivers/bluetooth/hci_ll.c
> +++ b/drivers/bluetooth/hci_ll.c
> @@ -57,6 +57,7 @@
> #include "hci_uart.h"
> 
> /* Vendor-specific HCI commands */
> +#define HCI_VS_WRITE_BD_ADDR			0xfc06
> #define HCI_VS_UPDATE_UART_HCI_BAUDRATE		0xff36
> 
> /* HCILL commands */
> @@ -662,6 +663,20 @@ static int download_firmware(struct ll_device *lldev)
> 	return err;
> }
> 
> +static int ll_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
> +{
> +	bdaddr_t bdaddr_swapped;
> +	struct sk_buff *skb;
> +
> +	baswap(&bdaddr_swapped, bdaddr);
> +	skb = __hci_cmd_sync(hdev, HCI_VS_WRITE_BD_ADDR, sizeof(bdaddr_t),
> +			     &bdaddr_swapped, HCI_INIT_TIMEOUT);
> +	if (!IS_ERR(skb))
> +		kfree_skb(skb);
> +	

You have a trailing whitespace here.

Does the HCI command really expect the BD_ADDR in the swapped order. The caller of hdev->set_bdaddr while provide it in the same order as the HCI Read BD Address command and everything in HCI. So it seems odd that you have to swap it for the vendor command.

So have you actually tested this with btmgmt public-add <xx:xx..> and checked that the address comes out correctly. I think ll_set_bdaddr should function correctly for the mgmt interface. And if needed any other caller outside of mgmt has to do the swapping.

Regards

Marcel
