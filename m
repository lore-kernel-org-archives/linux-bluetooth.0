Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH 2/2] Bluetooth: hci_bcm: Add suspend/resume runtime PM functions
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1440772279-9015-3-git-send-email-frederic.danis@linux.intel.com>
Date: Sun, 30 Aug 2015 14:16:20 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A33BFDFE-944A-47DF-A486-7EA3F92577C6@holtmann.org>
References: <1440772279-9015-1-git-send-email-frederic.danis@linux.intel.com> <1440772279-9015-3-git-send-email-frederic.danis@linux.intel.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Adds autosuspend runtime functionality to BCM UART driver.
> Autosuspend is enabled at end of bcm_setup.
> 
> Change some CONFIG_PM_SLEEP to CONFIG_PM as hu and is_suspended parameters
> are used during runtime PM callbacks.

I think we should do that in a separate patch to prepare for the change.

> Replace SpinLock by Mutex to be able to use it in sleepable context.
> Add a work queue to be able to perform pm_runtime commands during bcm_recv
> which is called by hci_uart_tty_receive() under spinlock.
> 
> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
> ---
> drivers/bluetooth/hci_bcm.c | 210 +++++++++++++++++++++++++++++++++-----------
> 1 file changed, 158 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 1440a56..488c812 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -32,6 +32,7 @@
> #include <linux/gpio/consumer.h>
> #include <linux/tty.h>
> #include <linux/interrupt.h>
> +#include <linux/pm_runtime.h>
> 
> #include <net/bluetooth/bluetooth.h>
> #include <net/bluetooth/hci_core.h>
> @@ -42,6 +43,8 @@
> #define BCM_NO_FIX		0
> #define BCM_FIX_ACPI_IRQ	1
> 
> +#define BCM_AUTOSUSPEND_DELAY	5000 /* default autosleep delay */
> +
> struct bcm_device {
> 	struct list_head	list;
> 
> @@ -57,7 +60,7 @@ struct bcm_device {
> 
> 	u32			init_speed;
> 
> -#ifdef CONFIG_PM_SLEEP
> +#ifdef CONFIG_PM
> 	struct hci_uart		*hu;
> 	bool			is_suspended; /* suspend/resume flag */
> 	int			irq;
> @@ -70,10 +73,11 @@ struct bcm_data {
> 	struct sk_buff_head	txq;
> 
> 	struct bcm_device	*dev;
> +	struct work_struct	pm_work;
> };
> 
> /* List of BCM BT UART devices */
> -static DEFINE_SPINLOCK(bcm_device_lock);
> +static DEFINE_MUTEX(bcm_device_lock);
> static LIST_HEAD(bcm_device_list);
> 
> static int bcm_set_baudrate(struct hci_uart *hu, unsigned int speed)
> @@ -163,7 +167,7 @@ static const struct bcm_set_sleep_mode default_sleep_params = {
> 	.bt_wake_active = 1,	/* BT_WAKE active mode: 1 = high, 0 = low */
> 	.host_wake_active = 0,	/* HOST_WAKE active mode: 1 = high, 0 = low */
> 	.allow_host_sleep = 1,	/* Allow host sleep in SCO flag */
> -	.combine_modes = 0,	/* Combine sleep and LPM flag */
> +	.combine_modes = 1,	/* Combine sleep and LPM flag */
> 	.tristate_control = 0,	/* Allow tri-state control of UART tx flag */
> 	/* Irrelevant USB flags */
> 	.usb_auto_sleep = 0,
> @@ -196,6 +200,19 @@ static int bcm_setup_sleep(struct hci_uart *hu)
> 	return 0;
> }
> 
> +static void bcm_pm_runtime_work(struct work_struct *work)
> +{
> +	struct bcm_data *bcm = container_of(work, struct bcm_data, pm_work);
> +
> +	mutex_lock(&bcm_device_lock);
> +	if (bcm_device_exists(bcm->dev)) {
> +		pm_runtime_get_sync(&bcm->dev->pdev->dev);
> +		pm_runtime_mark_last_busy(&bcm->dev->pdev->dev);
> +		pm_runtime_put_autosuspend(&bcm->dev->pdev->dev);
> +	}
> +	mutex_unlock(&bcm_device_lock);
> +}
> +
> static int bcm_open(struct hci_uart *hu)
> {
> 	struct bcm_data *bcm;
> @@ -211,7 +228,7 @@ static int bcm_open(struct hci_uart *hu)
> 
> 	hu->priv = bcm;
> 
> -	spin_lock(&bcm_device_lock);
> +	mutex_lock(&bcm_device_lock);
> 	list_for_each(p, &bcm_device_list) {
> 		struct bcm_device *dev = list_entry(p, struct bcm_device, list);
> 
> @@ -222,17 +239,19 @@ static int bcm_open(struct hci_uart *hu)
> 		if (hu->tty->dev->parent == dev->pdev->dev.parent) {
> 			bcm->dev = dev;
> 			hu->init_speed = dev->init_speed;
> -#ifdef CONFIG_PM_SLEEP
> +#ifdef CONFIG_PM
> 			dev->hu = hu;
> #endif
> 			break;
> 		}
> 	}
> 
> -	if (bcm->dev)
> +	if (bcm->dev) {
> 		bcm_gpio_set_power(bcm->dev, true);
> +		INIT_WORK(&bcm->pm_work, bcm_pm_runtime_work);
> +	}
> 
> -	spin_unlock(&bcm_device_lock);
> +	mutex_unlock(&bcm_device_lock);
> 
> 	return 0;
> }
> @@ -245,18 +264,23 @@ static int bcm_close(struct hci_uart *hu)
> 	BT_DBG("hu %p", hu);
> 
> 	/* Protect bcm->dev against removal of the device or driver */
> -	spin_lock(&bcm_device_lock);
> +	mutex_lock(&bcm_device_lock);
> 	if (bcm_device_exists(bdev)) {
> 		bcm_gpio_set_power(bdev, false);
> -#ifdef CONFIG_PM_SLEEP
> +#ifdef CONFIG_PM
> 		bdev->hu = NULL;
> 		if (device_can_wakeup(&bdev->pdev->dev)) {
> 			devm_free_irq(&bdev->pdev->dev, bdev->irq, bdev);
> 			device_init_wakeup(&bdev->pdev->dev, false);
> 		}
> +
> +		pm_runtime_disable(&bdev->pdev->dev);
> +		pm_runtime_set_suspended(&bdev->pdev->dev);
> #endif
> 	}
> -	spin_unlock(&bcm_device_lock);
> +	mutex_unlock(&bcm_device_lock);
> +
> +	cancel_work_sync(&bcm->pm_work);
> 
> 	skb_queue_purge(&bcm->txq);
> 	kfree_skb(bcm->rx_skb);
> @@ -283,12 +307,16 @@ static irqreturn_t bcm_host_wake(int irq, void *data)
> 
> 	BT_DBG("Host wake IRQ for %s", dev->name);
> 
> +	pm_runtime_get(&dev->pdev->dev);
> +	pm_runtime_mark_last_busy(&dev->pdev->dev);
> +	pm_runtime_put_autosuspend(&dev->pdev->dev);
> +
> 	return IRQ_HANDLED;
> }
> 
> static int bcm_setup(struct hci_uart *hu)
> {
> -#ifdef CONFIG_PM_SLEEP
> +#ifdef CONFIG_PM
> 	struct bcm_data *bcm = hu->priv;
> 	struct bcm_device *bdev = bcm->dev;
> #endif
> @@ -351,7 +379,7 @@ finalize:
> 		return err;
> 
> 	/* If it is not a platform device, do not enable PM functionalities */
> -	spin_lock(&bcm_device_lock);
> +	mutex_lock(&bcm_device_lock);
> 	if (!bcm_device_exists(bdev))
> 		goto unlock;
> 
> @@ -363,10 +391,16 @@ finalize:
> 			goto unlock;
> 
> 		device_init_wakeup(&bdev->pdev->dev, true);
> +
> +		pm_runtime_set_autosuspend_delay(&bdev->pdev->dev,
> +						 BCM_AUTOSUSPEND_DELAY);
> +		pm_runtime_use_autosuspend(&bdev->pdev->dev);
> +		pm_runtime_set_active(&bdev->pdev->dev);
> +		pm_runtime_enable(&bdev->pdev->dev);
> 	}
> 
> unlock:
> -	spin_unlock(&bcm_device_lock);
> +	mutex_unlock(&bcm_device_lock);
> 
> 	err = bcm_setup_sleep(hu);
> #endif
> @@ -383,6 +417,7 @@ static const struct h4_recv_pkt bcm_recv_pkts[] = {
> static int bcm_recv(struct hci_uart *hu, const void *data, int count)
> {
> 	struct bcm_data *bcm = hu->priv;
> +	int ret;
> 
> 	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
> 		return -EUNATCH;
> @@ -390,13 +425,20 @@ static int bcm_recv(struct hci_uart *hu, const void *data, int count)
> 	bcm->rx_skb = h4_recv_buf(hu->hdev, bcm->rx_skb, data, count,
> 				  bcm_recv_pkts, ARRAY_SIZE(bcm_recv_pkts));
> 	if (IS_ERR(bcm->rx_skb)) {
> -		int err = PTR_ERR(bcm->rx_skb);
> -		BT_ERR("%s: Frame reassembly failed (%d)", hu->hdev->name, err);
> +		ret = PTR_ERR(bcm->rx_skb);
> +		BT_ERR("%s: Frame reassembly failed (%d)", hu->hdev->name, ret);
> 		bcm->rx_skb = NULL;
> -		return err;
> -	}
> +	} else
> +		ret = count;
> 
> -	return count;
> +	/* mutex_lock/unlock can not be used here as this function is called
> +	 * from hci_uart_tty_receive under spinlock.
> +	 * Defer pm_runtime_* calls to work queue
> +	 */
> +	if (bcm->dev)
> +		schedule_work(&bcm->pm_work);
> +
> +	return ret;
> }
> 
> static int bcm_enqueue(struct hci_uart *hu, struct sk_buff *skb)
> @@ -415,10 +457,89 @@ static int bcm_enqueue(struct hci_uart *hu, struct sk_buff *skb)
> static struct sk_buff *bcm_dequeue(struct hci_uart *hu)
> {
> 	struct bcm_data *bcm = hu->priv;
> +	struct sk_buff *skb = NULL;
> +	struct bcm_device *bdev = NULL;
> +
> +	mutex_lock(&bcm_device_lock);
> +
> +	if (bcm_device_exists(bcm->dev)) {
> +		bdev = bcm->dev;
> +		pm_runtime_get_sync(&bdev->pdev->dev);
> +	}
> +
> +	skb = skb_dequeue(&bcm->txq);
> +
> +	if (bdev) {
> +		pm_runtime_mark_last_busy(&bdev->pdev->dev);
> +		pm_runtime_put_autosuspend(&bdev->pdev->dev);
> +	}
> +
> +	mutex_unlock(&bcm_device_lock);
> +
> +	return skb;
> +}
> +
> +#ifdef CONFIG_PM
> +static void __bcm_suspend(struct bcm_device *dev)
> +{
> +	if (!dev->is_suspended) {
> +		hci_uart_set_flow_control(dev->hu, true);
> +
> +		/* Once this returns, driver suspends BT via GPIO */
> +		dev->is_suspended = true;
> +	}
> +
> +	/* Suspend the device */
> +	if (dev->device_wakeup) {
> +		gpiod_set_value(dev->device_wakeup, false);
> +		BT_DBG("suspend, delaying 15 ms");
> +		mdelay(15);
> +	}
> +}
> +
> +static void __bcm_resume(struct bcm_device *dev)
> +{
> +	if (dev->device_wakeup) {
> +		gpiod_set_value(dev->device_wakeup, true);
> +		BT_DBG("resume, delaying 15 ms");
> +		mdelay(15);
> +	}
> +
> +	/* When this executes, the device has woken up already */
> +	if (dev->is_suspended) {
> +		dev->is_suspended = false;
> +
> +		hci_uart_set_flow_control(dev->hu, false);
> +	}
> +}
> +
> +static int bcm_runtime_suspend(struct device *dev)
> +{
> +	struct bcm_device *bdev = platform_get_drvdata(to_platform_device(dev));
> +
> +	BT_DBG("");
> 
> -	return skb_dequeue(&bcm->txq);
> +	mutex_lock(&bcm_device_lock);
> +	__bcm_suspend(bdev);
> +	mutex_unlock(&bcm_device_lock);
> +
> +	return 0;
> }
> 
> +static int bcm_runtime_resume(struct device *dev)
> +{
> +	struct bcm_device *bdev = platform_get_drvdata(to_platform_device(dev));
> +
> +	BT_DBG("");
> +
> +	mutex_lock(&bcm_device_lock);
> +	__bcm_resume(bdev);
> +	mutex_unlock(&bcm_device_lock);
> +
> +	return 0;
> +}
> +#endif
> +
> #ifdef CONFIG_PM_SLEEP
> /* Platform suspend callback */
> static int bcm_suspend(struct device *dev)
> @@ -428,24 +549,13 @@ static int bcm_suspend(struct device *dev)
> 
> 	BT_DBG("suspend (%p): is_suspended %d", bdev, bdev->is_suspended);
> 
> -	spin_lock(&bcm_device_lock);
> +	mutex_lock(&bcm_device_lock);
> 
> 	if (!bdev->hu)
> 		goto unlock;
> 
> -	if (!bdev->is_suspended) {
> -		hci_uart_set_flow_control(bdev->hu, true);
> -
> -		/* Once this callback returns, driver suspends BT via GPIO */
> -		bdev->is_suspended = true;
> -	}
> -
> -	/* Suspend the device */
> -	if (bdev->device_wakeup) {
> -		gpiod_set_value(bdev->device_wakeup, false);
> -		BT_DBG("suspend, delaying 15 ms");
> -		mdelay(15);
> -	}
> +	if (pm_runtime_active(dev))
> +		__bcm_suspend(bdev);
> 
> 	if (device_may_wakeup(&bdev->pdev->dev)) {
> 		error = enable_irq_wake(bdev->irq);
> @@ -454,7 +564,7 @@ static int bcm_suspend(struct device *dev)
> 	}
> 
> unlock:
> -	spin_unlock(&bcm_device_lock);
> +	mutex_unlock(&bcm_device_lock);
> 
> 	return 0;
> }
> @@ -466,7 +576,7 @@ static int bcm_resume(struct device *dev)
> 
> 	BT_DBG("resume (%p): is_suspended %d", bdev, bdev->is_suspended);
> 
> -	spin_lock(&bcm_device_lock);
> +	mutex_lock(&bcm_device_lock);
> 
> 	if (!bdev->hu)
> 		goto unlock;
> @@ -476,21 +586,14 @@ static int bcm_resume(struct device *dev)
> 		BT_DBG("BCM irq: disabled");
> 	}
> 
> -	if (bdev->device_wakeup) {
> -		gpiod_set_value(bdev->device_wakeup, true);
> -		BT_DBG("resume, delaying 15 ms");
> -		mdelay(15);
> -	}
> -
> -	/* When this callback executes, the device has woken up already */
> -	if (bdev->is_suspended) {
> -		bdev->is_suspended = false;
> +	__bcm_resume(bdev);
> 
> -		hci_uart_set_flow_control(bdev->hu, false);
> -	}
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> 
> unlock:
> -	spin_unlock(&bcm_device_lock);
> +	mutex_unlock(&bcm_device_lock);
> 
> 	return 0;
> }
> @@ -635,9 +738,9 @@ static int bcm_probe(struct platform_device *pdev)
> 	dev_info(&pdev->dev, "%s device registered.\n", dev->name);
> 
> 	/* Place this instance on the device list */
> -	spin_lock(&bcm_device_lock);
> +	mutex_lock(&bcm_device_lock);
> 	list_add_tail(&dev->list, &bcm_device_list);
> -	spin_unlock(&bcm_device_lock);
> +	mutex_unlock(&bcm_device_lock);
> 
> 	bcm_gpio_set_power(dev, false);
> 
> @@ -648,9 +751,9 @@ static int bcm_remove(struct platform_device *pdev)
> {
> 	struct bcm_device *dev = platform_get_drvdata(pdev);
> 
> -	spin_lock(&bcm_device_lock);
> +	mutex_lock(&bcm_device_lock);
> 	list_del(&dev->list);
> -	spin_unlock(&bcm_device_lock);
> +	mutex_unlock(&bcm_device_lock);
> 
> 	acpi_dev_remove_driver_gpios(ACPI_COMPANION(&pdev->dev));
> 
> @@ -684,7 +787,10 @@ MODULE_DEVICE_TABLE(acpi, bcm_acpi_match);
> #endif
> 
> /* Platform suspend and resume callbacks */
> -static SIMPLE_DEV_PM_OPS(bcm_pm_ops, bcm_suspend, bcm_resume);
> +static const struct dev_pm_ops bcm_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(bcm_suspend, bcm_resume)
> +	SET_RUNTIME_PM_OPS(bcm_runtime_suspend, bcm_runtime_resume, NULL)
> +};

I don't think is going to fly whey CONFIG_PM=n.

This is way to many #ifdef for my taste. I think the power management subsystem needs to get their stuff together and provide better integration. This simple driver becomes a #ifdef nightmare.

Regards

Marcel

