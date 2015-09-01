Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH 3/3] Bluetooth: hci_intel: Add runtime PM support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1441118530-18154-3-git-send-email-loic.poulain@intel.com>
Date: Tue, 1 Sep 2015 08:09:40 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <00A4FA75-DFA4-4890-A4A1-A4969FE5A313@holtmann.org>
References: <1441118530-18154-1-git-send-email-loic.poulain@intel.com> <1441118530-18154-3-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Implement runtime PM suspend/resume callbacks.
> If LPM supported, controller is put into supsend after a delay of
> inactivity (1s). Inactivity is based on LPM idle notification and
> host TX traffic.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> drivers/bluetooth/hci_intel.c | 97 ++++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 95 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
> index 8651803..622d28d 100644
> --- a/drivers/bluetooth/hci_intel.c
> +++ b/drivers/bluetooth/hci_intel.c
> @@ -32,6 +32,7 @@
> #include <linux/gpio/consumer.h>
> #include <linux/acpi.h>
> #include <linux/interrupt.h>
> +#include <linux/pm_runtime.h>
> 
> #include <net/bluetooth/bluetooth.h>
> #include <net/bluetooth/hci_core.h>
> @@ -58,6 +59,8 @@
> #define LPM_OP_SUSPEND_ACK 0x02
> #define LPM_OP_RESUME_ACK 0x03
> 
> +#define LPM_SUSPEND_DELAY_MS 1000
> +
> struct hci_lpm_pkt {
> 	__u8 opcode;
> 	__u8 dlen;
> @@ -79,6 +82,8 @@ static DEFINE_MUTEX(intel_device_list_lock);
> struct intel_data {
> 	struct sk_buff *rx_skb;
> 	struct sk_buff_head txq;
> +	struct work_struct busy_work;
> +	struct hci_uart *hu;
> 	unsigned long flags;
> };
> 
> @@ -207,9 +212,17 @@ static int intel_set_power(struct hci_uart *hu, bool powered)
> 			}
> 
> 			device_wakeup_enable(&idev->pdev->dev);
> +
> +			pm_runtime_set_active(&idev->pdev->dev);
> +			pm_runtime_use_autosuspend(&idev->pdev->dev);
> +			pm_runtime_set_autosuspend_delay(&idev->pdev->dev,
> +							 LPM_SUSPEND_DELAY_MS);
> +			pm_runtime_enable(&idev->pdev->dev);
> 		} else if (!powered && device_may_wakeup(&idev->pdev->dev)) {
> 			devm_free_irq(&idev->pdev->dev, idev->irq, idev);
> 			device_wakeup_disable(&idev->pdev->dev);
> +
> +			pm_runtime_disable(&idev->pdev->dev);
> 		}
> 	}
> 
> @@ -218,6 +231,27 @@ static int intel_set_power(struct hci_uart *hu, bool powered)
> 	return err;
> }
> 
> +static void intel_busy_work(struct work_struct *work)
> +{
> +	struct list_head *p;
> +	struct intel_data *intel = container_of(work, struct intel_data,
> +						busy_work);
> +
> +	mutex_lock(&intel_device_list_lock);
> +	list_for_each(p, &intel_device_list) {
> +		struct intel_device *idev = list_entry(p, struct intel_device,
> +						      list);
> +
> +		if (intel->hu->tty->dev->parent == idev->pdev->dev.parent) {
> +			pm_runtime_get(&idev->pdev->dev);
> +			pm_runtime_mark_last_busy(&idev->pdev->dev);
> +			pm_runtime_put_autosuspend(&idev->pdev->dev);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&intel_device_list_lock);
> +}
> +
> static int intel_open(struct hci_uart *hu)
> {
> 	struct intel_data *intel;
> @@ -229,6 +263,9 @@ static int intel_open(struct hci_uart *hu)
> 		return -ENOMEM;
> 
> 	skb_queue_head_init(&intel->txq);
> +	INIT_WORK(&intel->busy_work, intel_busy_work);
> +
> +	intel->hu = hu;
> 
> 	hu->priv = intel;
> 
> @@ -246,6 +283,8 @@ static int intel_close(struct hci_uart *hu)
> 
> 	intel_set_power(hu, false);
> 
> +	cancel_work_sync(&intel->busy_work);
> +
> 	skb_queue_purge(&intel->txq);
> 	kfree_skb(intel->rx_skb);
> 	kfree(intel);
> @@ -817,10 +856,12 @@ static void intel_recv_lpm_notify(struct hci_dev *hdev, int value)
> 
> 	bt_dev_dbg(hdev, "TX idle notification (%d)", value);
> 
> -	if (value)
> +	if (value) {
> 		set_bit(STATE_TX_ACTIVE, &intel->flags);
> -	else
> +		schedule_work(&intel->busy_work);
> +	} else {
> 		clear_bit(STATE_TX_ACTIVE, &intel->flags);
> +	}
> }
> 
> static int intel_recv_lpm(struct hci_dev *hdev, struct sk_buff *skb)
> @@ -895,9 +936,24 @@ static int intel_recv(struct hci_uart *hu, const void *data, int count)
> static int intel_enqueue(struct hci_uart *hu, struct sk_buff *skb)
> {
> 	struct intel_data *intel = hu->priv;
> +	struct list_head *p;
> 
> 	BT_DBG("hu %p skb %p", hu, skb);
> 
> +	mutex_lock(&intel_device_list_lock);
> +	list_for_each(p, &intel_device_list) {
> +		struct intel_device *idev = list_entry(p, struct intel_device,
> +						      list);
> +
> +		if (hu->tty->dev->parent == idev->pdev->dev.parent) {
> +			pm_runtime_get_sync(&idev->pdev->dev);

just for my own clarification. Why this is get_sync and the other just get?

> +			pm_runtime_mark_last_busy(&idev->pdev->dev);
> +			pm_runtime_put_autosuspend(&idev->pdev->dev);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&intel_device_list_lock);
> +
> 	skb_queue_tail(&intel->txq, skb);
> 
> 	return 0;
> @@ -1071,6 +1127,10 @@ static irqreturn_t intel_irq(int irq, void *dev_id)
> 		intel_lpm_host_wake(idev->hu);
> 	mutex_unlock(&idev->hu_lock);
> 
> +	pm_runtime_get(&idev->pdev->dev);
> +	pm_runtime_mark_last_busy(&idev->pdev->dev);
> +	pm_runtime_put_autosuspend(&idev->pdev->dev);
> +
> 	return IRQ_HANDLED;
> }
> 
> @@ -1128,8 +1188,41 @@ static int intel_resume(struct device *dev)
> }
> #endif
> 
> +#ifdef CONFIG_PM
> +static int intel_rt_suspend(struct device *dev)
> +{
> +	struct intel_device *idev = dev_get_drvdata(dev);
> +	int err = 0;
> +
> +	dev_dbg(dev, "intel_suspend");
> +
> +	mutex_lock(&idev->hu_lock);
> +	if (idev->hu)
> +		err = intel_lpm_suspend(idev->hu);
> +	mutex_unlock(&idev->hu_lock);
> +
> +	return err;
> +}
> +
> +static int intel_rt_resume(struct device *dev)
> +{
> +	struct intel_device *idev = dev_get_drvdata(dev);
> +	int err = 0;
> +
> +	dev_dbg(dev, "intel_resume");
> +
> +	mutex_lock(&idev->hu_lock);
> +	if (idev->hu)
> +		err = intel_lpm_resume(idev->hu);
> +	mutex_unlock(&idev->hu_lock);
> +
> +	return err;
> +}
> +#endif

Aren't these exactly the same? Why are we differentiating them.

> +
> static const struct dev_pm_ops intel_pm_ops = {
> 	SET_SYSTEM_SLEEP_PM_OPS(intel_suspend, intel_resume)
> +	SET_RUNTIME_PM_OPS(intel_rt_suspend, intel_rt_resume, NULL)
> };
> 
> static int intel_probe(struct platform_device *pdev)

Regards

Marcel

