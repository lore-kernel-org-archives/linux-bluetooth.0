Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH 3/3] bluetooth: hci_ll: Add optional nvmem MAC address
 source
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1512357682-8911-4-git-send-email-david@lechnology.com>
Date: Mon, 4 Dec 2017 07:48:31 +0100
Cc: devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <D85D0FBE-E810-45A2-8E20-612EF8D9674B@holtmann.org>
References: <1512357682-8911-1-git-send-email-david@lechnology.com>
 <1512357682-8911-4-git-send-email-david@lechnology.com>
To: David Lechner <david@lechnology.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> This adds an optional nvmem consumer to get a MAC address from an external
> source. The MAC address is then set in the Bluetooth chip after the
> firmware has been loaded.
> 
> This has been tested working with a TI CC2560A chip (in a LEGO MINDSTORMS
> EV3).
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> drivers/bluetooth/hci_ll.c | 33 +++++++++++++++++++++++++++++++++
> 1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
> index 974a788..dd3b5c2 100644
> --- a/drivers/bluetooth/hci_ll.c
> +++ b/drivers/bluetooth/hci_ll.c
> @@ -53,10 +53,12 @@
> #include <net/bluetooth/bluetooth.h>
> #include <net/bluetooth/hci_core.h>
> #include <linux/gpio/consumer.h>
> +#include <linux/nvmem-consumer.h>
> 
> #include "hci_uart.h"
> 
> /* Vendor-specific HCI commands */
> +#define HCI_VS_WRITE_BD_ADDR			0xfc06
> #define HCI_VS_UPDATE_UART_HCI_BAUDRATE		0xff36

the first patch should to add support for hdev->set_bdaddr. If the hardware supports changing the BD_ADDR, then it should also be exposed via Set Public Address mgmt command. For this it is required that the writing of the BD_ADDR is non-persistent over power cycles.

> 
> /* HCILL commands */
> @@ -89,6 +91,7 @@ struct ll_device {
> 	struct serdev_device *serdev;
> 	struct gpio_desc *enable_gpio;
> 	struct clk *ext_clk;
> +	u8 *bdaddr;

I would prefer if we just store it as bdaddr_t. That will work just fine when you created the set_bdaddr helper function that you need for hdev->set_bdaddr anyway.

> };
> 
> struct ll_struct {
> @@ -698,6 +701,19 @@ static int ll_setup(struct hci_uart *hu)
> 	if (err)
> 		return err;
> 
> +	/* Set MAC address, if any */
> +	if (lldev->bdaddr) {

And here I would really prefer to use bacmp. And example here would be btqcomsmd.c on how it is done.

> +		struct sk_buff *skb;
> +
> +		skb = __hci_cmd_sync(hu->hdev, HCI_VS_WRITE_BD_ADDR, 6,
> +				     lldev->bdaddr, HCI_INIT_TIMEOUT);
> +		if (IS_ERR(skb))
> +			bt_dev_err(hu->hdev, "Failed to set MAC address (%ld)",
> +				   PTR_ERR(skb));
> +		else
> +			kfree_skb(skb);
> +	}
> +
> 	/* Operational speed if any */
> 	if (hu->oper_speed)
> 		speed = hu->oper_speed;
> @@ -726,6 +742,7 @@ static int hci_ti_probe(struct serdev_device *serdev)
> {
> 	struct hci_uart *hu;
> 	struct ll_device *lldev;
> +	struct nvmem_cell *bdaddr_cell;
> 	u32 max_speed = 3000000;

While this is unrelated to this patch, when I seed the u32 speed and the direct use of it in a __hci_cmd_sync, then that is pretty obviously not endian safe. You might really want to fix that as well.

> 	lldev = devm_kzalloc(&serdev->dev, sizeof(struct ll_device), GFP_KERNEL);
> @@ -747,6 +764,22 @@ static int hci_ti_probe(struct serdev_device *serdev)
> 	of_property_read_u32(serdev->dev.of_node, "max-speed", &max_speed);
> 	hci_uart_set_speeds(hu, 115200, max_speed);
> 
> +	/* optional MAC address from nvram */
> +	bdaddr_cell = nvmem_cell_get(&serdev->dev, "mac-address”);

I prefer really to use the term “bd-address” like we discussed for the btqcomsmd.c driver as well.

> +	if (IS_ERR(bdaddr_cell)) {
> +		int err = PTR_ERR(bdaddr_cell);
> +
> +		if (err != -ENOENT) {
> +			if (err != -EPROBE_DEFER)

	err != -ENOENT && err != -EPROBE_DEFER

> +				dev_err(&serdev->dev,
> +					"Failed to get \"mac-address\" nvmem cell\n”);

Also this is at most a warning. And more important, I would actually set the quirk BDADDR_INVALID here so that the device gets flagged as not having a valid address. The Set Public Address mgmt command can then be used from userspace to handle that situation.

> +			return err;
> +		}
> +	} else {
> +		lldev->bdaddr = nvmem_cell_read(bdaddr_cell, NULL);
> +		nvmem_cell_put(bdaddr_cell);
> +	}
> +
> 	return hci_uart_register_device(hu, &llp);
> }

Regards

Marcel

