Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH v2 4/4] Bluetooth: hci_bcm: Add suspend/resume runtime PM functions
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1441373747-23042-5-git-send-email-frederic.danis@linux.intel.com>
Date: Fri, 4 Sep 2015 12:15:19 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <CBC77539-71FB-4A84-B849-A9987BD29488@holtmann.org>
References: <1441373747-23042-1-git-send-email-frederic.danis@linux.intel.com> <1441373747-23042-5-git-send-email-frederic.danis@linux.intel.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Adds autosuspend runtime functionality to BCM UART driver.
> Autosuspend is enabled at end of bcm_setup.
> 
> Add a work queue to be able to perform pm_runtime commands during bcm_recv
> which is called by hci_uart_tty_receive() under spinlock.
> 
> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
> ---
> drivers/bluetooth/hci_bcm.c | 111 ++++++++++++++++++++++++++++++++++++++++++--
> 1 file changed, 107 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 7f63f2b..a226249 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -33,6 +33,7 @@
> #include <linux/tty.h>
> #include <linux/interrupt.h>
> #include <linux/dmi.h>
> +#include <linux/pm_runtime.h>
> 
> #include <net/bluetooth/bluetooth.h>
> #include <net/bluetooth/hci_core.h>
> @@ -40,6 +41,8 @@
> #include "btbcm.h"
> #include "hci_uart.h"
> 
> +#define BCM_AUTOSUSPEND_DELAY	5000 /* default autosleep delay */
> +
> struct bcm_device {
> 	struct list_head	list;
> 
> @@ -67,6 +70,9 @@ struct bcm_data {
> 	struct sk_buff_head	txq;
> 
> 	struct bcm_device	*dev;
> +#ifdef CONFIG_PM
> +	struct work_struct	pm_work;
> +#endif
> };
> 
> /* List of BCM BT UART devices */
> @@ -160,6 +166,10 @@ static irqreturn_t bcm_host_wake(int irq, void *data)
> 
> 	bt_dev_dbg(bdev, "Host wake IRQ");
> 
> +	pm_runtime_get(&bdev->pdev->dev);
> +	pm_runtime_mark_last_busy(&bdev->pdev->dev);
> +	pm_runtime_put_autosuspend(&bdev->pdev->dev);
> +
> 	return IRQ_HANDLED;
> }
> 
> @@ -183,6 +193,12 @@ static int bcm_request_irq(struct bcm_data *bcm)
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
> @@ -198,7 +214,7 @@ static const struct bcm_set_sleep_mode default_sleep_params = {
> 	.bt_wake_active = 1,	/* BT_WAKE active mode: 1 = high, 0 = low */
> 	.host_wake_active = 0,	/* HOST_WAKE active mode: 1 = high, 0 = low */
> 	.allow_host_sleep = 1,	/* Allow host sleep in SCO flag */
> -	.combine_modes = 0,	/* Combine sleep and LPM flag */
> +	.combine_modes = 1,	/* Combine sleep and LPM flag */
> 	.tristate_control = 0,	/* Allow tri-state control of UART tx flag */
> 	/* Irrelevant USB flags */
> 	.usb_auto_sleep = 0,
> @@ -228,9 +244,28 @@ static int bcm_setup_sleep(struct hci_uart *hu)
> 
> 	return 0;
> }
> +
> +static void bcm_pm_runtime_work(struct work_struct *work)
> +{
> +	struct bcm_data *bcm = container_of(work, struct bcm_data, pm_work);
> +
> +	mutex_lock(&bcm_device_lock);
> +	if (bcm_device_exists(bcm->dev)) {
> +		pm_runtime_get(&bcm->dev->pdev->dev);
> +		pm_runtime_mark_last_busy(&bcm->dev->pdev->dev);
> +		pm_runtime_put_autosuspend(&bcm->dev->pdev->dev);
> +	}
> +	mutex_unlock(&bcm_device_lock);
> +}
> +
> +static bool bcm_schedule_work(struct bcm_data *bcm)
> +{
> +	return schedule_work(&bcm->pm_work);
> +}
> #else
> static inline int bcm_request_irq(struct bcm_data *bcm) { return 0; }
> static inline int bcm_setup_sleep(struct hci_uart *hu) { return 0; }
> +static inline bool bcm_schedule_work(struct bcm_data *bcm) { return false; }
> #endif
> 
> static int bcm_open(struct hci_uart *hu)
> @@ -261,6 +296,7 @@ static int bcm_open(struct hci_uart *hu)
> 			hu->init_speed = dev->init_speed;
> #ifdef CONFIG_PM
> 			dev->hu = hu;
> +			INIT_WORK(&bcm->pm_work, bcm_pm_runtime_work);
> #endif
> 			bcm_gpio_set_power(bcm->dev, true);
> 			break;
> @@ -284,6 +320,11 @@ static int bcm_close(struct hci_uart *hu)
> 	if (bcm_device_exists(bdev)) {
> 		bcm_gpio_set_power(bdev, false);
> #ifdef CONFIG_PM
> +		cancel_work_sync(&bcm->pm_work);
> +
> +		pm_runtime_disable(&bdev->pdev->dev);
> +		pm_runtime_set_suspended(&bdev->pdev->dev);
> +
> 		if (device_can_wakeup(&bdev->pdev->dev)) {
> 			devm_free_irq(&bdev->pdev->dev, bdev->irq, bdev);
> 			device_init_wakeup(&bdev->pdev->dev, false);
> @@ -393,6 +434,13 @@ static int bcm_recv(struct hci_uart *hu, const void *data, int count)
> 	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
> 		return -EUNATCH;
> 
> +	/* mutex_lock/unlock can not be used here as this function is called
> +	 * from hci_uart_tty_receive under spinlock.
> +	 * Defer pm_runtime_* calls to work queue
> +	 */
> +	if (bcm->dev)
> +		bcm_schedule_work(bcm);
> +
> 	bcm->rx_skb = h4_recv_buf(hu->hdev, bcm->rx_skb, data, count,
> 				  bcm_recv_pkts, ARRAY_SIZE(bcm_recv_pkts));
> 	if (IS_ERR(bcm->rx_skb)) {
> @@ -421,8 +469,27 @@ static int bcm_enqueue(struct hci_uart *hu, struct sk_buff *skb)
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
> +		/* Shall be resumed here */
> +	}
> +
> +	skb = skb_dequeue(&bcm->txq);
> +
> +	if (bdev) {
> +		pm_runtime_mark_last_busy(&bdev->pdev->dev);
> +		pm_runtime_put_autosuspend(&bdev->pdev->dev);
> +	}
> 
> -	return skb_dequeue(&bcm->txq);
> +	mutex_unlock(&bcm_device_lock);
> +
> +	return skb;
> }
> 
> #ifdef CONFIG_PM
> @@ -458,6 +525,34 @@ static void __bcm_resume(struct bcm_device *bdev)
> 		hci_uart_set_flow_control(bdev->hu, false);
> 	}
> }
> +
> +static int bcm_runtime_suspend(struct device *dev)
> +{
> +	struct bcm_device *bdev = platform_get_drvdata(to_platform_device(dev));
> +
> +	bt_dev_dbg(bdev, "");
> +
> +	/* bcm_device_lock held is not required here as bcm_runtime_suspend
> +	 * is only called when device is attached.
> +	 */
> +	__bcm_suspend(bdev);
> +
> +	return 0;
> +}
> +
> +static int bcm_runtime_resume(struct device *dev)
> +{
> +	struct bcm_device *bdev = platform_get_drvdata(to_platform_device(dev));
> +
> +	bt_dev_dbg(bdev, "");
> +
> +	/* bcm_device_lock held is not required here as bcm_runtime_resume
> +	 * is only called when device is attached.
> +	 */
> +	__bcm_resume(bdev);
> +
> +	return 0;
> +}
> #endif
> 
> #ifdef CONFIG_PM_SLEEP
> @@ -474,7 +569,8 @@ static int bcm_suspend(struct device *dev)
> 	if (!bdev->hu)
> 		goto unlock;
> 
> -	__bcm_suspend(bdev);
> +	if (pm_runtime_active(dev))
> +		__bcm_suspend(bdev);
> 
> 	if (device_may_wakeup(&bdev->pdev->dev)) {
> 		error = enable_irq_wake(bdev->irq);
> @@ -510,6 +606,10 @@ static int bcm_resume(struct device *dev)
> unlock:
> 	mutex_unlock(&bcm_device_lock);
> 
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
> 	return 0;
> }
> #endif
> @@ -726,7 +826,10 @@ MODULE_DEVICE_TABLE(acpi, bcm_acpi_match);
> #endif
> 
> /* Platform suspend and resume callbacks */
> -static SIMPLE_DEV_PM_OPS(bcm_pm_ops, bcm_suspend, bcm_resume);
> +static const struct dev_pm_ops bcm_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(bcm_suspend, bcm_resume)
> +	SET_RUNTIME_PM_OPS(bcm_runtime_suspend, bcm_runtime_resume, NULL)

I think you really need to explain why runtime suspend and system sleep is actually different for Broadcom based devices. Since for the Intel ones it turned out to be the same (at least for now).

> +};
> 
> static struct platform_driver bcm_driver = {
> 	.probe = bcm_probe,

Regards

Marcel

