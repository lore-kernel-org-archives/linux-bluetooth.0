Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 3/3] Bluetooth: hci_bcm: Add serdev support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1501576704-26423-3-git-send-email-loic.poulain@gmail.com>
Date: Fri, 4 Aug 2017 16:36:02 +0200
Cc: rjui@broadcom.com, sbranden@broadcom.com, f.fainelli@gmail.com,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-rpi-kernel@lists.infradead.org,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Message-Id: <696124D4-A5DA-46FA-A0F0-5DC74363BD23@holtmann.org>
References: <1501576704-26423-1-git-send-email-loic.poulain@gmail.com>
 <1501576704-26423-3-git-send-email-loic.poulain@gmail.com>
To: Loic Poulain <loic.poulain@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Add basic support for Broadcom serial slave devices.
> Probe the serial device, retrieve its maximum speed and
> register a new hci uart device.
> 
> Tested/compatible with bcm43438 (RPi3).
> 
> Signed-off-by: Loic Poulain <loic.poulain@gmail.com>
> ---
> v2: dt-bindings as separate patch
>    rebase on upcoming pi3 dts changes
> 
> drivers/bluetooth/hci_bcm.c | 82 ++++++++++++++++++++++++++++++++++++++++++---
> 1 file changed, 78 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 6b42372..f824738 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -27,6 +27,7 @@
> #include <linux/firmware.h>
> #include <linux/module.h>
> #include <linux/acpi.h>
> +#include <linux/of.h>
> #include <linux/platform_device.h>
> #include <linux/clk.h>
> #include <linux/gpio/consumer.h>
> @@ -34,6 +35,7 @@
> #include <linux/interrupt.h>
> #include <linux/dmi.h>
> #include <linux/pm_runtime.h>
> +#include <linux/serdev.h>
> 
> #include <net/bluetooth/bluetooth.h>
> #include <net/bluetooth/hci_core.h>
> @@ -46,6 +48,7 @@
> 
> #define BCM_AUTOSUSPEND_DELAY	5000 /* default autosleep delay */
> 
> +/* platform device driver resources */
> struct bcm_device {
> 	struct list_head	list;
> 
> @@ -68,6 +71,12 @@ struct bcm_device {
> #endif
> };
> 
> +/* serdev driver resources */
> +struct bcm_bt_device {
> +	struct hci_uart hu;
> +};

why not call this bcm_serdev for now. I think that keeps it a bit simpler.

> +
> +/* generic bcm uart resources */
> struct bcm_data {
> 	struct sk_buff		*rx_skb;
> 	struct sk_buff_head	txq;
> @@ -289,6 +298,11 @@ static int bcm_open(struct hci_uart *hu)
> 
> 	hu->priv = bcm;
> 
> +	if (hu->serdev) {
> +		serdev_device_open(hu->serdev);
> +		goto out;
> +	}
> +

Lets prefix these with comments saying that if this is a serdev / DT defined device, then we only use serdev open primitive and skip the rest.

> 	if (!hu->tty->dev)
> 		goto out;
> 
> @@ -323,6 +337,9 @@ static int bcm_close(struct hci_uart *hu)
> 
> 	bt_dev_dbg(hu->hdev, "hu %p", hu);
> 
> +	if (hu->serdev)
> +		serdev_device_close(hu->serdev);
> +

Similar here, lets have a comment that says we are closing serdev and then continue as usual.

> 	/* Protect bcm->dev against removal of the device or driver */
> 	mutex_lock(&bcm_device_lock);
> 	if (bcm_device_exists(bdev)) {
> @@ -397,8 +414,12 @@ static int bcm_setup(struct hci_uart *hu)
> 	else
> 		speed = 0;
> 
> -	if (speed)
> -		hci_uart_set_baudrate(hu, speed);
> +	if (speed) {
> +		if (hu->serdev)
> +			serdev_device_set_baudrate(hu->serdev, speed);
> +		else
> +			hci_uart_set_baudrate(hu, speed);
> +	}
> 

Here I would also add a small comment that when serdev is used a different baud rate primitive needs to be used.

> 	/* Operational speed if any */
> 	if (hu->oper_speed)
> @@ -410,8 +431,12 @@ static int bcm_setup(struct hci_uart *hu)
> 
> 	if (speed) {
> 		err = bcm_set_baudrate(hu, speed);
> -		if (!err)
> -			hci_uart_set_baudrate(hu, speed);
> +		if (!err) {
> +			if (hu->serdev)
> +				serdev_device_set_baudrate(hu->serdev, speed);
> +			else
> +				hci_uart_set_baudrate(hu, speed);
> +		}

Maybe we should split this out into a helper. Maybe call it it device_set_baudrate.

> 	}
> 
> finalize:
> @@ -903,9 +928,57 @@ static int bcm_remove(struct platform_device *pdev)
> 	},
> };
> 
> +static int bcm_serdev_probe(struct serdev_device *serdev)
> +{
> +	struct bcm_bt_device *bcmdev;
> +	u32 speed;
> +	int err;
> +
> +	bcmdev = devm_kzalloc(&serdev->dev, sizeof(*bcmdev), GFP_KERNEL);
> +	if (!bcmdev)
> +		return -ENOMEM;
> +
> +	bcmdev->hu.serdev = serdev;
> +	serdev_device_set_drvdata(serdev, bcmdev);
> +
> +	err = of_property_read_u32(serdev->dev.of_node, "max-speed", &speed);
> +	if (!err)
> +		bcmdev->hu.oper_speed = speed;
> +
> +	return hci_uart_register_device(&bcmdev->hu, &bcm_proto);
> +}

We do not need any GPIO for reset lines or anything else for the rPI3?

> +
> +static void bcm_serdev_remove(struct serdev_device *serdev)
> +{
> +	struct bcm_bt_device *bcmdev = serdev_device_get_drvdata(serdev);
> +
> +	hci_uart_unregister_device(&bcmdev->hu);
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id bcm_bluetooth_of_match[] = {
> +	{ .compatible = "brcm,bcm43438-bt" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, bcm_bluetooth_of_match);
> +#endif
> +
> +static struct serdev_device_driver bcm_serdev_driver = {
> +	.probe = bcm_serdev_probe,
> +	.remove = bcm_serdev_remove,
> +	.driver = {
> +		.name = "hci_uart_bcm",
> +		.of_match_table = of_match_ptr(bcm_bluetooth_of_match),
> +	},
> +};
> +
> int __init bcm_init(void)
> {
> +	/* For now, we need to keep both platform device
> +	 * driver (ACPI generated) and serdev driver (DT).
> +	 */
> 	platform_driver_register(&bcm_driver);
> +	serdev_device_driver_register(&bcm_serdev_driver);
> 
> 	return hci_uart_register_proto(&bcm_proto);
> }
> @@ -913,6 +986,7 @@ int __init bcm_init(void)
> int __exit bcm_deinit(void)
> {
> 	platform_driver_unregister(&bcm_driver);
> +	serdev_device_driver_unregister(&bcm_serdev_driver);
> 
> 	return hci_uart_unregister_proto(&bcm_proto);
> }

Regards

Marcel

