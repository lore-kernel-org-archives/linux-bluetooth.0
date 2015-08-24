Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH v4 2/2] Bluetooth: hci_intel: Add platform driver
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1440165583-23245-2-git-send-email-loic.poulain@intel.com>
Date: Mon, 24 Aug 2015 11:43:27 -0700
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <6E6F721F-FC4B-4AA7-A1A3-39323E3FAD80@holtmann.org>
References: <1440165583-23245-1-git-send-email-loic.poulain@intel.com> <1440165583-23245-2-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> A platform device can be used to provide some specific resources in
> order to manage the controller. In this first patch we retrieve the
> reset gpio which is used to power on/off the controller.
> 
> The main issue is to match the current tty with the correct pdev.
> In case of ACPI, we can easily find the right tty/pdev pair because
> they are both child of the same UART port.
> 
> If controller is powered-on from the driver, we need to wait for a
> HCI boot event before being able to send any command.

long term we need to look into the proposed UART Slave feature and see how we can drive that upstream. Reason is that we can not add the same code to every different vendor. The basic GPIO pieces will be most likely the same for all ACPI based Intel systems.

> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> v2: v3: none, align patch version with patch 1/2 "Intel baudrate" patch
> v4: remove device tree support, will be part of a different patch
> 
> drivers/bluetooth/hci_intel.c | 232 +++++++++++++++++++++++++++++++++++++++---
> 1 file changed, 216 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
> index 080e794..cd66282 100644
> --- a/drivers/bluetooth/hci_intel.c
> +++ b/drivers/bluetooth/hci_intel.c
> @@ -26,6 +26,10 @@
> #include <linux/skbuff.h>
> #include <linux/firmware.h>
> #include <linux/wait.h>
> +#include <linux/tty.h>
> +#include <linux/platform_device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/acpi.h>
> 
> #include <net/bluetooth/bluetooth.h>
> #include <net/bluetooth/hci_core.h>
> @@ -40,10 +44,20 @@
> #define STATE_BOOTING		4
> #define STATE_SPEED_CHANGING	5
> 
> +struct intel_device {
> +	struct list_head list;
> +	struct platform_device *pdev;
> +	struct gpio_desc *reset;
> +	struct hci_uart *hu;
> +};
> +LIST_HEAD(intel_device_list);
> +DEFINE_SPINLOCK(intel_device_list_lock);

Why is this not static?

> +
> struct intel_data {
> 	struct sk_buff *rx_skb;
> 	struct sk_buff_head txq;
> 	unsigned long flags;
> +	struct intel_device *idev;
> };
> 
> static u8 intel_convert_speed(unsigned int speed)
> @@ -78,6 +92,111 @@ static u8 intel_convert_speed(unsigned int speed)
> 	}
> }
> 
> +static int intel_device_lock(struct intel_device *idev)
> +{
> +	struct list_head *p;
> +
> +	spin_lock(&intel_device_list_lock);
> +
> +	list_for_each(p, &intel_device_list) {
> +		struct intel_device *dev = list_entry(p, struct intel_device,
> +						      list);
> +		if (dev == idev)
> +			return 0;
> +	}
> +
> +	spin_unlock(&intel_device_list_lock);
> +
> +	return -ENODEV;
> +}
> +
> +static void intel_device_unlock(struct intel_device *idev)
> +{
> +	spin_unlock(&intel_device_list_lock);
> +}

I do not like this lock/unlock helpers. They are not symmetric in any form or shape. We can not have that. The above is actually a try_lock. I have the feeling that manually coding this would make this actually easier to read.

So just grab the lock and run the list manually in each cases.

> +
> +static int intel_set_power(struct hci_uart *hu, bool powered)
> +{
> +	struct intel_data *intel = hu->priv;
> +	struct intel_device *idev = intel->idev;
> +
> +	if (intel_device_lock(idev))
> +		return -ENODEV;
> +
> +	if (!idev->reset) {
> +		intel_device_unlock(idev);
> +		return -EINVAL;
> +	}
> +
> +	BT_DBG("%s: set power %d", hu->hdev->name, powered);
> +
> +	gpiod_set_value(idev->reset, powered);
> +
> +	intel_device_unlock(idev);
> +
> +	return 0;
> +}
> +
> +static struct intel_device *intel_get_idev(struct hci_uart *hu)
> +{
> +	struct list_head *p;
> +	struct intel_device *idev_match = NULL;
> +
> +	spin_lock(&intel_device_list_lock);
> +	list_for_each(p, &intel_device_list) {
> +		struct intel_device *idev;
> +
> +		idev = list_entry(p, struct intel_device, list);
> +
> +		/* tty device and pdev device should share the same parent
> +		 * which is the UART port.
> +		 */
> +		if (hu->tty->dev->parent == idev->pdev->dev.parent) {
> +			idev_match = idev;
> +			break;
> +		}
> +	}
> +
> +	if (idev_match) {
> +		idev_match->hu = hu;
> +		BT_INFO("hu %p, Found compatible pm device (%s)", hu,
> +			dev_name(&idev_match->pdev->dev));
> +	}
> +	spin_unlock(&intel_device_list_lock);
> +
> +	return idev_match;
> +}
> +
> +static int intel_boot_wait(struct hci_uart *hu)
> +{
> +	struct intel_data *intel = hu->priv;
> +	struct hci_dev *hdev = hu->hdev;
> +	int err;
> +
> +	if (!test_bit(STATE_BOOTING, &intel->flags))
> +		return 0;
> +
> +	BT_INFO("%s: Waiting for device to boot", hdev->name);
> +
> +	err = wait_on_bit_timeout(&intel->flags, STATE_BOOTING,
> +				  TASK_INTERRUPTIBLE,
> +				  msecs_to_jiffies(1000));
> +
> +	if (err == 1) {
> +		BT_ERR("%s: Device boot interrupted", hdev->name);
> +		clear_bit(STATE_BOOTING, &intel->flags);
> +		return -EINTR;
> +	}
> +
> +	if (err) {
> +		BT_ERR("%s: Device boot timeout", hdev->name);
> +		clear_bit(STATE_BOOTING, &intel->flags);
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
> static int intel_open(struct hci_uart *hu)
> {
> 	struct intel_data *intel;
> @@ -91,6 +210,12 @@ static int intel_open(struct hci_uart *hu)
> 	skb_queue_head_init(&intel->txq);
> 
> 	hu->priv = intel;
> +
> +	intel->idev = intel_get_idev(hu);
> +
> +	if (!intel_set_power(hu, true))
> +		set_bit(STATE_BOOTING, &intel->flags);
> +
> 	return 0;
> }
> 
> @@ -100,6 +225,13 @@ static int intel_close(struct hci_uart *hu)
> 
> 	BT_DBG("hu %p", hu);
> 
> +	intel_set_power(hu, false);
> +
> +	if (!intel_device_lock(intel->idev)) {
> +		intel->idev->hu = NULL;
> +		intel_device_unlock(intel->idev);
> +	}
> +
> 	skb_queue_purge(&intel->txq);
> 	kfree_skb(intel->rx_skb);
> 	kfree(intel);
> @@ -151,6 +283,8 @@ static int intel_set_baudrate(struct hci_uart *hu, unsigned int speed)
> 	u8 intel_speed;
> 	struct sk_buff *skb;
> 
> +	intel_boot_wait(hu);
> +
> 	BT_INFO("%s: Change controller speed to %d", hdev->name, speed);
> 
> 	/* Device will not accept speed change if Intel version has not been
> @@ -229,6 +363,8 @@ static int intel_setup(struct hci_uart *hu)
> 	if (oper_speed && init_speed && oper_speed != init_speed)
> 		speed_change = 1;
> 
> +	intel_boot_wait(hu);
> +
> 	set_bit(STATE_BOOTLOADER, &intel->flags);
> 
> 	/* Read the Intel version information to determine if the device
> @@ -537,21 +673,9 @@ done:
> 	 * 1 second. However if that happens, then just fail the setup
> 	 * since something went wrong.
> 	 */
> -	BT_INFO("%s: Waiting for device to boot", hdev->name);
> -
> -	err = wait_on_bit_timeout(&intel->flags, STATE_BOOTING,
> -				  TASK_INTERRUPTIBLE,
> -				  msecs_to_jiffies(1000));
> -
> -	if (err == 1) {
> -		BT_ERR("%s: Device boot interrupted", hdev->name);
> -		return -EINTR;
> -	}
> -
> -	if (err) {
> -		BT_ERR("%s: Device boot timeout", hdev->name);
> -		return -ETIMEDOUT;
> -	}
> +	err = intel_boot_wait(hu);
> +	if (err)
> +		return err;

If you are moving existing code out into a separate function, then that should go into a separate patch. So we can clearly see why you are doing this moving around.

> 
> 	rettime = ktime_get();
> 	delta = ktime_sub(rettime, calltime);
> @@ -583,7 +707,8 @@ static int intel_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
> 	struct intel_data *intel = hu->priv;
> 	struct hci_event_hdr *hdr;
> 
> -	if (!test_bit(STATE_BOOTLOADER, &intel->flags))
> +	if (!test_bit(STATE_BOOTLOADER, &intel->flags) &&
> +	    !test_bit(STATE_BOOTING, &intel->flags))
> 		goto recv;
> 
> 	hdr = (void *)skb->data;
> @@ -713,12 +838,87 @@ static const struct hci_uart_proto intel_proto = {
> 	.dequeue	= intel_dequeue,
> };
> 
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id intel_bt_acpi_match[] = {

Just call this intel_acpi_match. Keep it consistent in how we call things in hci_bcm.c.

> +	{ "INT33E1", 0 },
> +	{ },
> +};
> +#endif

While this is okay for now, I think what you also want to work on is a DECLARE helper that allows us to avoid the CONFIG_ACPI crap.

Something that turns the thing into nothing when ACPI is off.

> +
> +static int intel_probe(struct platform_device *pdev)
> +{
> +	struct intel_device *idev;
> +
> +	idev = devm_kzalloc(&pdev->dev, sizeof(*idev), GFP_KERNEL);
> +	if (!idev)
> +		return -ENOMEM;
> +
> +	idev->pdev = pdev;
> +
> +	if (ACPI_HANDLE(&pdev->dev)) {
> +#ifdef CONFIG_ACPI
> +		const struct acpi_device_id *id;
> +
> +		id = acpi_match_device(intel_bt_acpi_match, &pdev->dev);
> +		if (!id)
> +			return -ENODEV;
> +#endif

Do this the same as what Fred did in the hci_bcm.c.

Or can we actually get acpi_match_device fixed to become a no operation that always returns ENODEV when CONFIG_ACPI=n. I would prefer the latter actually since all this CONFIG_ACPI hackery is annoying.

> +	} else {
> +		return -ENODEV;
> +	}
> +
> +	idev->reset = devm_gpiod_get_optional(&pdev->dev, "reset",
> +					      GPIOD_OUT_LOW);
> +	if (IS_ERR(idev->reset)) {
> +		dev_err(&pdev->dev, "Unable to retrieve gpio\n");
> +		return PTR_ERR(idev->reset);
> +	}
> +
> +	platform_set_drvdata(pdev, idev);
> +
> +	/* Place this instance on the device list */
> +	spin_lock(&intel_device_list_lock);
> +	list_add_tail(&idev->list, &intel_device_list);
> +	spin_unlock(&intel_device_list_lock);
> +
> +	dev_info(&pdev->dev, "registered.\n");
> +
> +	return 0;
> +}
> +
> +static int intel_remove(struct platform_device *pdev)
> +{
> +	struct intel_device *idev = platform_get_drvdata(pdev);
> +
> +	spin_lock(&intel_device_list_lock);
> +	list_del(&idev->list);
> +	spin_unlock(&intel_device_list_lock);
> +
> +	dev_info(&pdev->dev, "unregistered.\n");
> +
> +	return 0;
> +}
> +
> +static struct platform_driver intel_driver = {
> +	.probe = intel_probe,
> +	.remove = intel_remove,
> +	.driver = {
> +		.name = "hci_intel",
> +		.acpi_match_table = ACPI_PTR(intel_bt_acpi_match),
> +		.owner = THIS_MODULE,
> +	},
> +};
> +
> int __init intel_init(void)
> {
> +	platform_driver_register(&intel_driver);
> +
> 	return hci_uart_register_proto(&intel_proto);
> }
> 
> int __exit intel_deinit(void)
> {
> +	platform_driver_unregister(&intel_driver);
> +
> 	return hci_uart_unregister_proto(&intel_proto);
> }

Regards

Marcel

