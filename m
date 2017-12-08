Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH v2 3/3] Bluetooth: hci_ll: Add optional nvmem BD address
 source
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1512701860-8321-4-git-send-email-david@lechnology.com>
Date: Fri, 8 Dec 2017 09:14:39 +0100
Cc: devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <B51B73A4-F05D-4466-9184-30FB88963812@holtmann.org>
References: <1512701860-8321-1-git-send-email-david@lechnology.com>
 <1512701860-8321-4-git-send-email-david@lechnology.com>
To: David Lechner <david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> This adds an optional nvmem consumer to get a BD address from an external
> source. The BD address is then set in the Bluetooth chip after the
> firmware has been loaded.
> 
> This has been tested working with a TI CC2560A chip (in a LEGO MINDSTORMS
> EV3).
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> 
> v2 changes:
> * Add support for HCI_QUIRK_INVALID_BDADDR when there is an error getting the
>  BD address from nvmem
> * Rework error handling
> * rename "mac-address" to "bd-address"
> * use bdaddr_t, bacmp and other bluetooth helper functions
> * use ll_set_bdaddr() from new, separate patch
> 
> drivers/bluetooth/hci_ll.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 55 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
> index b732004..f5fef2d 100644
> --- a/drivers/bluetooth/hci_ll.c
> +++ b/drivers/bluetooth/hci_ll.c
> @@ -53,6 +53,7 @@
> #include <net/bluetooth/bluetooth.h>
> #include <net/bluetooth/hci_core.h>
> #include <linux/gpio/consumer.h>
> +#include <linux/nvmem-consumer.h>
> 
> #include "hci_uart.h"
> 
> @@ -90,6 +91,7 @@ struct ll_device {
> 	struct serdev_device *serdev;
> 	struct gpio_desc *enable_gpio;
> 	struct clk *ext_clk;
> +	bdaddr_t bdaddr;
> };
> 
> struct ll_struct {
> @@ -715,6 +717,19 @@ static int ll_setup(struct hci_uart *hu)
> 	if (err)
> 		return err;
> 
> +	/* Set BD address if one was specified at probe */
> +	if (!bacmp(&lldev->bdaddr, BDADDR_NONE)) {
> +		/*
> +		 * This means that there was an error getting the BD address
> +		 * during probe, so mark the device as having a bad address.
> +		 */
> +		set_bit(HCI_QUIRK_INVALID_BDADDR, &hu->hdev->quirks);
> +	} else if (bacmp(&lldev->bdaddr, BDADDR_ANY)) {
> +		err = ll_set_bdaddr(hu->hdev, &lldev->bdaddr);
> +		if (err)
> +			set_bit(HCI_QUIRK_INVALID_BDADDR, &hu->hdev->quirks);
> +	}
> +
> 	/* Operational speed if any */
> 	if (hu->oper_speed)
> 		speed = hu->oper_speed;
> @@ -743,6 +758,7 @@ static int hci_ti_probe(struct serdev_device *serdev)
> {
> 	struct hci_uart *hu;
> 	struct ll_device *lldev;
> +	struct nvmem_cell *bdaddr_cell;
> 	u32 max_speed = 3000000;
> 
> 	lldev = devm_kzalloc(&serdev->dev, sizeof(struct ll_device), GFP_KERNEL);
> @@ -764,6 +780,45 @@ static int hci_ti_probe(struct serdev_device *serdev)
> 	of_property_read_u32(serdev->dev.of_node, "max-speed", &max_speed);
> 	hci_uart_set_speeds(hu, 115200, max_speed);
> 
> +	/* optional BD address from nvram */
> +	bdaddr_cell = nvmem_cell_get(&serdev->dev, "bd-address");
> +	if (IS_ERR(bdaddr_cell)) {
> +		int err = PTR_ERR(bdaddr_cell);
> +
> +		if (err == -EPROBE_DEFER)
> +			return err;
> +
> +		/*
> +		 * ENOENT means there is no matching nvmem cell and ENOSYS
> +		 * means that nvmem is not enabled in the kernel configuration.
> +		 */

Fix the comment style to this:

	/* foo
	 * bar
	 */

> +		if (err != -ENOENT && err != -ENOSYS) {
> +			/*
> +			 * If there was some other error, give userspace a
> +			 * chance to fix the problem instead of failing to load
> +			 * the driver. Using BDADDR_NONE as a flag that is
> +			 * tested later in the setup function.
> +			 */
> +			dev_warn(&serdev->dev,
> +				 "Failed to get \"bd-address\" nvmem cell (%d)\n",
> +				 err);
> +			bacpy(&lldev->bdaddr, BDADDR_NONE);
> +		}
> +	} else {
> +		bdaddr_t *bdaddr;
> +		int len;
> +
> +		bdaddr = nvmem_cell_read(bdaddr_cell, &len);
> +		if (len != sizeof(bdaddr_t)) {
> +			dev_err(&serdev->dev, "Invalid nvmem bd-address length\n");
> +			nvmem_cell_put(bdaddr_cell);
> +			return -EINVAL;
> +		}
> +
> +		baswap(&lldev->bdaddr, bdaddr);

This swapping needs a comment. Explain the format of the NVMEM storage and also which the HCI vendor command takes.

> +		nvmem_cell_put(bdaddr_cell);
> +	}
> +
> 	return hci_uart_register_device(hu, &llp);
> }

Regards

Marcel
