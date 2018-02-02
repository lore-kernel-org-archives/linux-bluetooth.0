Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] Bluetooth: btusb: Add support for Intel Bluetooth device
 22560 [8087:0026]
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1517571696-32239-1-git-send-email-amit.k.bag@intel.com>
Date: Fri, 2 Feb 2018 15:23:00 +0100
Cc: linux-bluetooth@vger.kernel.org, tedd.an@intel.com,
        jaya.p.g@intel.com, ravishankar.srivatsa@intel.com
Message-Id: <9B43E34B-A3A3-4C42-85BB-82C1C1750AA3@holtmann.org>
References: <1517571696-32239-1-git-send-email-amit.k.bag@intel.com>
To: Amit K Bag <amit.k.bag@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amit,

> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
> ---
> drivers/bluetooth/btusb.c | 7 +++++++
> 1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 2a55380ad730..37082a833ca6 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -339,6 +339,7 @@ static const struct usb_device_id blacklist_table[] = {
> 
> 	/* Intel Bluetooth devices */
> 	{ USB_DEVICE(0x8087, 0x0025), .driver_info = BTUSB_INTEL_NEW },
> +	{ USB_DEVICE(0x8087, 0x0026), .driver_info = BTUSB_INTEL_NEW },
> 	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
> 	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL },
> 	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL },
> @@ -2057,6 +2058,8 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
> 	case 0x0c:	/* WsP */
> 	case 0x11:	/* JfP */
> 	case 0x12:	/* ThP */
> +	case 0x13:	/* Quasar */
> +	case 0x14:	/* Quasar */

can we use the product names here please. It is okay to list more than one.

Regards

Marcel

