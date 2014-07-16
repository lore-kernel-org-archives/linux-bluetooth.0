Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 1/2] Bluetooth: add public address configuration for Marvell USB devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1405538486-23533-1-git-send-email-bzhao@marvell.com>
Date: Wed, 16 Jul 2014 23:06:33 +0200
Cc: Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Amitkumar Karwar <akarwar@marvell.com>,
	Avinash Patil <patila@marvell.com>,
	Chin-Ran Lo <crlo@marvell.com>, Xinming Hu <huxm@marvell.com>
Message-Id: <968A8F45-B932-4343-A9C4-AA25BC91344A@holtmann.org>
References: <1405538486-23533-1-git-send-email-bzhao@marvell.com>
To: Bing Zhao <bzhao@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

> Implemented .set_bdaddr handler provided by bluetooth stack for
> Marvell devices for public address configuration.
> 
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> Signed-off-by: Bing Zhao <bzhao@marvell.com>
> ---
> drivers/bluetooth/btusb.c | 31 +++++++++++++++++++++++++++++++
> 1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index ed7b33b..9846fc4 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -48,6 +48,7 @@ static struct usb_driver btusb_driver;
> #define BTUSB_INTEL		0x100
> #define BTUSB_INTEL_BOOT	0x200
> #define BTUSB_BCM_PATCHRAM	0x400
> +#define BTUSB_MARVELL		0x800
> 
> static const struct usb_device_id btusb_table[] = {
> 	/* Generic Bluetooth USB device */
> @@ -242,6 +243,10 @@ static const struct usb_device_id blacklist_table[] = {
> 	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL },
> 	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL },
> 
> +	/* Marvell device */
> +	{ USB_DEVICE(0x1286, 0x2044), .driver_info = BTUSB_MARVELL },
> +	{ USB_DEVICE(0x1286, 0x2046), .driver_info = BTUSB_MARVELL },
> +
> 	{ }	/* Terminating entry */
> };
> 
> @@ -1455,6 +1460,29 @@ static int btusb_set_bdaddr_intel(struct hci_dev *hdev, const bdaddr_t *bdaddr)
> 	return 0;
> }
> 
> +static int btusb_set_bdaddr_marvell(struct hci_dev *hdev,
> +				    const bdaddr_t *bdaddr)
> +{
> +	struct sk_buff *skb;
> +	u8 buf[8];
> +	long ret;
> +
> +	buf[0] = 0xfe;
> +	buf[1] = sizeof(bdaddr_t);
> +	bacpy((bdaddr_t *)&buf[2], bdaddr);

you could define a packed struct for this or just use memcpy here instead.

> +
> +	skb = __hci_cmd_sync(hdev, 0xfc22, sizeof(buf), buf, HCI_INIT_TIMEOUT);

Is this opcode writing the address into flash and making it permanent or will a reboot restore it to its original address?

I am asking because for Ericsson chips this exact command with user_id 0xfe was actually making a permanent change of the BD_ADDR. What we want here is a volatile change of the address.

Regards

Marcel

