Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH 1/2] Bluetooth: hci_bcm: Add wake-up capability
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1440772279-9015-2-git-send-email-frederic.danis@linux.intel.com>
Date: Sun, 30 Aug 2015 14:12:57 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A4371882-93CB-42C9-B51E-0359BCC2B2A5@holtmann.org>
References: <1440772279-9015-1-git-send-email-frederic.danis@linux.intel.com> <1440772279-9015-2-git-send-email-frederic.danis@linux.intel.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Retrieve the Interruption used by BCM device, which can be declared
> as Interruption or GpioInt in the ACPI table.
> Configure BCM device to wake-up the host.
> Enable IRQ wake while suspended.
> 
> host_wake_active parameter of Vendor Specific Command should not be
> configured with the same value for BCM2E39 and BCM2E67. So, retrieve
> the irq polarity used from the ACPI table.
> Unfortunately, ACPI table for BCM2E39 is not correct.
> So, add fix_acpi_irq parameter to bcm_device to be able to revert
> host_wake_active when sending sleep parameters.

I really do not like to introduce these things in one big patch. I prefer that we introduce the expected correct handling first and then in a second patch tweak it to fix the issue.

Is the no chance we get the ACPI tables fixed or detected except hard-coding a quirk to the ACPI modalias?

> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
> ---
> drivers/bluetooth/hci_bcm.c | 141 ++++++++++++++++++++++++++++++++++++++++++--
> 1 file changed, 136 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 835bfab..1440a56 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -31,6 +31,7 @@
> #include <linux/clk.h>
> #include <linux/gpio/consumer.h>
> #include <linux/tty.h>
> +#include <linux/interrupt.h>
> 
> #include <net/bluetooth/bluetooth.h>
> #include <net/bluetooth/hci_core.h>
> @@ -38,10 +39,14 @@
> #include "btbcm.h"
> #include "hci_uart.h"
> 
> +#define BCM_NO_FIX		0
> +#define BCM_FIX_ACPI_IRQ	1
> +
> struct bcm_device {
> 	struct list_head	list;
> 
> 	struct platform_device	*pdev;
> +	bool			fix_acpi_irq;
> 
> 	const char		*name;
> 	struct gpio_desc	*device_wakeup;
> @@ -55,6 +60,8 @@ struct bcm_device {
> #ifdef CONFIG_PM_SLEEP
> 	struct hci_uart		*hu;
> 	bool			is_suspended; /* suspend/resume flag */
> +	int			irq;
> +	u8			irq_polarity;
> #endif
> };
> 
> @@ -149,6 +156,46 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
> 	return 0;
> }
> 
> +static const struct bcm_set_sleep_mode default_sleep_params = {
> +	.sleep_mode = 1,	/* 0=Disabled, 1=UART, 2=Reserved, 3=USB */
> +	.idle_host = 2,		/* idle threshold HOST, in 300ms */
> +	.idle_dev = 2,		/* idle threshold device, in 300ms */
> +	.bt_wake_active = 1,	/* BT_WAKE active mode: 1 = high, 0 = low */
> +	.host_wake_active = 0,	/* HOST_WAKE active mode: 1 = high, 0 = low */
> +	.allow_host_sleep = 1,	/* Allow host sleep in SCO flag */
> +	.combine_modes = 0,	/* Combine sleep and LPM flag */
> +	.tristate_control = 0,	/* Allow tri-state control of UART tx flag */
> +	/* Irrelevant USB flags */
> +	.usb_auto_sleep = 0,
> +	.usb_resume_timeout = 0,
> +	.pulsed_host_wake = 0,
> +	.break_to_host = 0
> +};
> +
> +static int bcm_setup_sleep(struct hci_uart *hu)
> +{
> +	struct bcm_data *bcm = hu->priv;
> +	struct sk_buff *skb;
> +	struct bcm_set_sleep_mode sleep_params = default_sleep_params;
> +
> +	sleep_params.host_wake_active = !bcm->dev->irq_polarity;
> +	if (bcm->dev->fix_acpi_irq)
> +		sleep_params.host_wake_active = !sleep_params.host_wake_active;
> +
> +	skb = __hci_cmd_sync(hu->hdev, 0xfc27, sizeof(sleep_params),
> +			     &sleep_params, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		int err = PTR_ERR(skb);
> +		BT_ERR("Sleep VSC failed (%d)", err);
> +		return err;
> +	}
> +	kfree_skb(skb);
> +
> +	BT_DBG("bcm_setup Set Sleep Parameters VSC succeeded");
> +
> +	return 0;
> +}
> +
> static int bcm_open(struct hci_uart *hu)
> {
> 	struct bcm_data *bcm;
> @@ -193,15 +240,20 @@ static int bcm_open(struct hci_uart *hu)
> static int bcm_close(struct hci_uart *hu)
> {
> 	struct bcm_data *bcm = hu->priv;
> +	struct bcm_device *bdev = bcm->dev;
> 
> 	BT_DBG("hu %p", hu);
> 
> 	/* Protect bcm->dev against removal of the device or driver */
> 	spin_lock(&bcm_device_lock);
> -	if (bcm_device_exists(bcm->dev)) {
> -		bcm_gpio_set_power(bcm->dev, false);
> +	if (bcm_device_exists(bdev)) {
> +		bcm_gpio_set_power(bdev, false);
> #ifdef CONFIG_PM_SLEEP
> -		bcm->dev->hu = NULL;
> +		bdev->hu = NULL;
> +		if (device_can_wakeup(&bdev->pdev->dev)) {
> +			devm_free_irq(&bdev->pdev->dev, bdev->irq, bdev);
> +			device_init_wakeup(&bdev->pdev->dev, false);
> +		}
> #endif
> 	}
> 	spin_unlock(&bcm_device_lock);
> @@ -225,8 +277,21 @@ static int bcm_flush(struct hci_uart *hu)
> 	return 0;
> }
> 
> +static irqreturn_t bcm_host_wake(int irq, void *data)
> +{
> +	struct bcm_device *dev = data;
> +
> +	BT_DBG("Host wake IRQ for %s", dev->name);
> +
> +	return IRQ_HANDLED;
> +}
> +
> static int bcm_setup(struct hci_uart *hu)
> {
> +#ifdef CONFIG_PM_SLEEP
> +	struct bcm_data *bcm = hu->priv;
> +	struct bcm_device *bdev = bcm->dev;
> +#endif
> 	char fw_name[64];
> 	const struct firmware *fw;
> 	unsigned int speed;
> @@ -281,6 +346,30 @@ finalize:
> 	release_firmware(fw);
> 
> 	err = btbcm_finalize(hu->hdev);
> +#ifdef CONFIG_PM_SLEEP
> +	if (err)
> +		return err;
> +
> +	/* If it is not a platform device, do not enable PM functionalities */
> +	spin_lock(&bcm_device_lock);
> +	if (!bcm_device_exists(bdev))
> +		goto unlock;
> +
> +	if (bdev->irq > 0) {
> +		err = devm_request_irq(&bdev->pdev->dev, bdev->irq,
> +				       bcm_host_wake, IRQF_TRIGGER_RISING,
> +				       "host_wake", bdev);
> +		if (err)
> +			goto unlock;
> +
> +		device_init_wakeup(&bdev->pdev->dev, true);
> +	}
> +
> +unlock:
> +	spin_unlock(&bcm_device_lock);
> +
> +	err = bcm_setup_sleep(hu);
> +#endif

I really dislike the massive cluttering with CONFIG_PM_SLEEP. We need to come up with something that is more readable and also testable so that this does not end up in a nightmare.

It might actually means we should turn some of the power management subsystem calls into no-op inline functions with correct error codes.

> 	return err;
> }
> @@ -335,6 +424,7 @@ static struct sk_buff *bcm_dequeue(struct hci_uart *hu)
> static int bcm_suspend(struct device *dev)
> {
> 	struct bcm_device *bdev = platform_get_drvdata(to_platform_device(dev));
> +	int error;
> 
> 	BT_DBG("suspend (%p): is_suspended %d", bdev, bdev->is_suspended);
> 
> @@ -357,6 +447,12 @@ static int bcm_suspend(struct device *dev)
> 		mdelay(15);
> 	}
> 
> +	if (device_may_wakeup(&bdev->pdev->dev)) {
> +		error = enable_irq_wake(bdev->irq);
> +		if (!error)
> +			BT_DBG("BCM irq: enabled");
> +	}
> +
> unlock:
> 	spin_unlock(&bcm_device_lock);
> 
> @@ -375,6 +471,11 @@ static int bcm_resume(struct device *dev)
> 	if (!bdev->hu)
> 		goto unlock;
> 
> +	if (device_may_wakeup(&bdev->pdev->dev)) {
> +		disable_irq_wake(bdev->irq);
> +		BT_DBG("BCM irq: disabled");
> +	}
> +
> 	if (bdev->device_wakeup) {
> 		gpiod_set_value(bdev->device_wakeup, true);
> 		BT_DBG("resume, delaying 15 ms");
> @@ -397,10 +498,12 @@ unlock:
> 
> static const struct acpi_gpio_params device_wakeup_gpios = { 0, 0, false };
> static const struct acpi_gpio_params shutdown_gpios = { 1, 0, false };
> +static const struct acpi_gpio_params host_wakeup_gpios = { 2, 0, false };
> 
> static const struct acpi_gpio_mapping acpi_bcm_default_gpios[] = {
> 	{ "device-wakeup-gpios", &device_wakeup_gpios, 1 },
> 	{ "shutdown-gpios", &shutdown_gpios, 1 },
> +	{ "host-wakeup-gpios", &host_wakeup_gpios, 1 },
> 	{ },
> };
> 
> @@ -415,6 +518,17 @@ static int bcm_resource(struct acpi_resource *ares, void *data)
> 		sb = &ares->data.uart_serial_bus;
> 		if (sb->type == ACPI_RESOURCE_SERIAL_TYPE_UART)
> 			dev->init_speed = sb->default_baud_rate;
> +	} else if (ares->type == ACPI_RESOURCE_TYPE_EXTENDED_IRQ) {
> +		struct acpi_resource_extended_irq *irq;
> +
> +		irq = &ares->data.extended_irq;
> +		dev->irq_polarity = irq->polarity;
> +	} else if (ares->type == ACPI_RESOURCE_TYPE_GPIO) {
> +		struct acpi_resource_gpio *gpio;
> +
> +		gpio = &ares->data.gpio;
> +		if (gpio->connection_type == ACPI_RESOURCE_GPIO_TYPE_INT)
> +			dev->irq_polarity = gpio->polarity;
> 	}
> 
> 	/* Always tell the ACPI core to skip this resource */
> @@ -433,6 +547,8 @@ static int bcm_acpi_probe(struct bcm_device *dev)
> 	if (!id)
> 		return -ENODEV;
> 
> +	dev->fix_acpi_irq = !!id->driver_data;
> +

This needs a comment above to explain why this is correct.

> 	/* Retrieve GPIO data */
> 	dev->name = dev_name(&pdev->dev);
> 	ret = acpi_dev_add_driver_gpios(ACPI_COMPANION(&pdev->dev),
> @@ -453,6 +569,21 @@ static int bcm_acpi_probe(struct bcm_device *dev)
> 	if (IS_ERR(dev->shutdown))
> 		return PTR_ERR(dev->shutdown);
> 
> +	/* IRQ can be declared in ACPI table as Interrupt or GpioInt */
> +	dev->irq = platform_get_irq(pdev, 0);
> +	if (dev->irq <= 0) {
> +		struct gpio_desc *gpio;
> +
> +		gpio = devm_gpiod_get_optional(&pdev->dev, "host-wakeup",
> +					       GPIOD_IN);
> +		if (IS_ERR(gpio))
> +			return PTR_ERR(gpio);
> +
> +		dev->irq = gpiod_to_irq(gpio);
> +	}
> +
> +	dev_info(&pdev->dev, "BCM irq: %d\n", dev->irq);
> +
> 	/* Make sure at-least one of the GPIO is defined and that
> 	 * a name is specified for this instance
> 	 */
> @@ -545,8 +676,8 @@ static const struct hci_uart_proto bcm_proto = {
> 
> #ifdef CONFIG_ACPI
> static const struct acpi_device_id bcm_acpi_match[] = {
> -	{ "BCM2E39", 0 },
> -	{ "BCM2E67", 0 },
> +	{ "BCM2E39", BCM_FIX_ACPI_IRQ },
> +	{ "BCM2E67", BCM_NO_FIX },
> 	{ },
> };
> MODULE_DEVICE_TABLE(acpi, bcm_acpi_match);

Regards

Marcel

