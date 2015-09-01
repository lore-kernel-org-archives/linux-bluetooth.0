Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH v2 3/3] Bluetooth: hci_intel: Add runtime PM support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1441125663-17708-3-git-send-email-loic.poulain@intel.com>
Date: Tue, 1 Sep 2015 15:23:21 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <8480EC70-359A-4D42-928D-A914A0243627@holtmann.org>
References: <1441125663-17708-1-git-send-email-loic.poulain@intel.com> <1441125663-17708-3-git-send-email-loic.poulain@intel.com>
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
> v2: Add pm_runtime comments.
>     Use same suspend/resume callbacks for pm and runtime pm.
> 
> drivers/bluetooth/hci_intel.c | 72 +++++++++++++++++++++++++++++++++++++++++--
> 1 file changed, 69 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
> index 5143554..8faf765 100644
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
> @@ -282,6 +287,11 @@ static irqreturn_t intel_irq(int irq, void *dev_id)
> 		intel_lpm_host_wake(idev->hu);
> 	mutex_unlock(&idev->hu_lock);
> 
> +	/* Host/Controller are now LPM resumed, trigger a new delayed suspend */
> +	pm_runtime_get(&idev->pdev->dev);
> +	pm_runtime_mark_last_busy(&idev->pdev->dev);
> +	pm_runtime_put_autosuspend(&idev->pdev->dev);
> +
> 	return IRQ_HANDLED;
> }
> 
> @@ -337,9 +347,17 @@ static int intel_set_power(struct hci_uart *hu, bool powered)
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
> @@ -348,6 +366,28 @@ static int intel_set_power(struct hci_uart *hu, bool powered)
> 	return err;
> }
> 
> +static void intel_busy_work(struct work_struct *work)
> +{
> +	struct list_head *p;
> +	struct intel_data *intel = container_of(work, struct intel_data,
> +						busy_work);
> +
> +	/* Link is busy, delay the suspend */
> +	mutex_lock(&intel_device_list_lock);
> +	list_for_each(p, &intel_device_list) {
> +		struct intel_device *idev = list_entry(p, struct intel_device,
> +						      list);

Please double-check that list is indented correctly.

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
> @@ -359,6 +399,9 @@ static int intel_open(struct hci_uart *hu)
> 		return -ENOMEM;
> 
> 	skb_queue_head_init(&intel->txq);
> +	INIT_WORK(&intel->busy_work, intel_busy_work);
> +
> +	intel->hu = hu;
> 
> 	hu->priv = intel;
> 
> @@ -376,6 +419,8 @@ static int intel_close(struct hci_uart *hu)
> 
> 	intel_set_power(hu, false);
> 
> +	cancel_work_sync(&intel->busy_work);
> +

Is this the right spot? Would you cancel the busy work first and then power down?

> 	skb_queue_purge(&intel->txq);
> 	kfree_skb(intel->rx_skb);
> 	kfree(intel);
> @@ -947,10 +992,12 @@ static void intel_recv_lpm_notify(struct hci_dev *hdev, int value)
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
> @@ -1025,9 +1072,27 @@ static int intel_recv(struct hci_uart *hu, const void *data, int count)
> static int intel_enqueue(struct hci_uart *hu, struct sk_buff *skb)
> {
> 	struct intel_data *intel = hu->priv;
> +	struct list_head *p;
> 
> 	BT_DBG("hu %p skb %p", hu, skb);
> 
> +	/* Be sure our controller is resumed and potential LPM transaction
> +	 * completed before enqueuing any packet.
> +	 */
> +	mutex_lock(&intel_device_list_lock);
> +	list_for_each(p, &intel_device_list) {
> +		struct intel_device *idev = list_entry(p, struct intel_device,
> +						      list);

Same as above, but this might be just looking weird in a diff. So just double check.

> +
> +		if (hu->tty->dev->parent == idev->pdev->dev.parent) {
> +			pm_runtime_get_sync(&idev->pdev->dev);
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
> @@ -1101,7 +1166,7 @@ static int intel_acpi_probe(struct intel_device *idev)
> }
> #endif
> 
> -#ifdef CONFIG_PM_SLEEP
> +#ifdef CONFIG_PM
> static int intel_suspend(struct device *dev)
> {
> 	struct intel_device *idev = dev_get_drvdata(dev);
> @@ -1133,6 +1198,7 @@ static int intel_resume(struct device *dev)
> 
> static const struct dev_pm_ops intel_pm_ops = {
> 	SET_SYSTEM_SLEEP_PM_OPS(intel_suspend, intel_resume)
> +	SET_RUNTIME_PM_OPS(intel_suspend, intel_resume, NULL)
> };

Regards

Marcel

