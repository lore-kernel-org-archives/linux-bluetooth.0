Return-Path: <cyrus@holtmann.org>
Message-ID: <1352594676.16204.25.camel@aeonflux>
Subject: Re: [RFCv3 3/3] Bluetooth: Add sample BT USB mini-driver
From: Marcel Holtmann <marcel@holtmann.org>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Cc: linux-bluetooth@vger.kernel.org, albert.o.ho@intel.com,
	johan.hedberg@intel.com, tedd.hj.an@gmail.com
Date: Sun, 11 Nov 2012 01:44:36 +0100
In-Reply-To: <3643102.0sb8ltOP1V@tedd-ubuntu>
References: <3643102.0sb8ltOP1V@tedd-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

> This patch adds sample BT USB mini-driver
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
>  drivers/bluetooth/btusb.c        |    3 +
>  drivers/bluetooth/btusb_sample.c |  189 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 192 insertions(+)
>  create mode 100644 drivers/bluetooth/btusb_sample.c
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 39a1e6c..630d938 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -193,6 +193,9 @@ static struct usb_device_id blacklist_table[] = {
>  	/* Frontline ComProbe Bluetooth Sniffer */
>  	{ USB_DEVICE(0x16d3, 0x0002), .driver_info = BTUSB_SNIFFER },
>  
> +	/* BT USB sample mini-driver */
> +	{ USB_DEVICE(0x1234, 0x5678), .driver_info = BTUSB_IGNORE },
> +
>  	{ }	/* Terminating entry */
>  };

we should convert BCM92035 into a mini-driver for demo purposes. It is
the perfect candidate and as a nice extra result, I can remove the
stupid hdev->driver_init queue.

Regards

Marcel


