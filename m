Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH v4 5/5] Bluetooth: hci_bcm: Add suspend/resume runtime PM functions
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1442305868-6203-6-git-send-email-frederic.danis@linux.intel.com>
Date: Wed, 16 Sep 2015 04:58:44 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <EBBFA731-66B6-4EE4-A85C-BBF94EFA6AAC@holtmann.org>
References: <1442305868-6203-1-git-send-email-frederic.danis@linux.intel.com> <1442305868-6203-6-git-send-email-frederic.danis@linux.intel.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Adds autosuspend runtime functionality to BCM UART driver.
> Autosuspend is enabled at end of bcm_setup.
> 
> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
> ---
> drivers/bluetooth/hci_bcm.c | 88 ++++++++++++++++++++++++++++++++++++++++++---
> 1 file changed, 84 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 6e97f21..eec25a7 100644
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
> @@ -160,6 +163,10 @@ static irqreturn_t bcm_host_wake(int irq, void *data)
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
> @@ -183,6 +190,12 @@ static int bcm_request_irq(struct bcm_data *bcm)
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
> @@ -198,7 +211,7 @@ static const struct bcm_set_sleep_mode default_sleep_params = {
> 	.bt_wake_active = 1,	/* BT_WAKE active mode: 1 = high, 0 = low */
> 	.host_wake_active = 0,	/* HOST_WAKE active mode: 1 = high, 0 = low */
> 	.allow_host_sleep = 1,	/* Allow host sleep in SCO flag */
> -	.combine_modes = 0,	/* Combine sleep and LPM flag */
> +	.combine_modes = 1,	/* Combine sleep and LPM flag */
> 	.tristate_control = 0,	/* Allow tri-state control of UART tx flag */
> 	/* Irrelevant USB flags */
> 	.usb_auto_sleep = 0,
> @@ -284,6 +297,9 @@ static int bcm_close(struct hci_uart *hu)
> 	if (bcm_device_exists(bdev)) {
> 		bcm_gpio_set_power(bdev, false);
> #ifdef CONFIG_PM
> +		pm_runtime_disable(&bdev->pdev->dev);
> +		pm_runtime_set_suspended(&bdev->pdev->dev);
> +
> 		if (device_can_wakeup(&bdev->pdev->dev)) {
> 			devm_free_irq(&bdev->pdev->dev, bdev->irq, bdev);
> 			device_init_wakeup(&bdev->pdev->dev, false);
> @@ -400,6 +416,15 @@ static int bcm_recv(struct hci_uart *hu, const void *data, int count)
> 		bt_dev_err(hu->hdev, "Frame reassembly failed (%d)", err);
> 		bcm->rx_skb = NULL;
> 		return err;
> +	} else if (!bcm->rx_skb) {
> +		/* Delay auto-suspend when receiving completed packet */
> +		mutex_lock(&bcm_device_lock);
> +		if (bcm->dev && bcm_device_exists(bcm->dev)) {
> +			pm_runtime_get(&bcm->dev->pdev->dev);
> +			pm_runtime_mark_last_busy(&bcm->dev->pdev->dev);
> +			pm_runtime_put_autosuspend(&bcm->dev->pdev->dev);
> +		}
> +		mutex_unlock(&bcm_device_lock);
> 	}
> 
> 	return count;
> @@ -421,8 +446,27 @@ static int bcm_enqueue(struct hci_uart *hu, struct sk_buff *skb)
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
> 
> -	return skb_dequeue(&bcm->txq);
> +	if (bdev) {
> +		pm_runtime_mark_last_busy(&bdev->pdev->dev);
> +		pm_runtime_put_autosuspend(&bdev->pdev->dev);
> +	}
> +
> +	mutex_unlock(&bcm_device_lock);
> +
> +	return skb;
> }
> 
> #ifdef CONFIG_PM
> @@ -458,6 +502,34 @@ static void bcm_resume_device(struct bcm_device *bdev)
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
> +	bcm_suspend_device(bdev);
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
> +	bcm_resume_device(bdev);
> +
> +	return 0;
> +}

why are we having these two wrappers? They do nothing except adding a comment.

I rather get rid of them and put a proper comment in the bcm_suspend and bcm_resume functions that a lock needs to be held in this case. And in addition add text about the looking to the commit message.

Regards

Marcel

