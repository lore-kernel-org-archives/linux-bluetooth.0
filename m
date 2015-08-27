Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH 5/5] Bluetooth: hci_intel: Implement suspend/resume
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1440689946-13576-5-git-send-email-loic.poulain@intel.com>
Date: Thu, 27 Aug 2015 09:29:12 -0700
Cc: linux-bluetooth@vger.kernel.org, gaetan.prin@intel.com
Message-Id: <0F292130-6BBD-4113-969F-F85EA2B91239@holtmann.org>
References: <1440689946-13576-1-git-send-email-loic.poulain@intel.com> <1440689946-13576-5-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Add platform PM suspend/resume callbacks.
> Chip can be suspended/resumed via specific vendor commands which need
> to be acked by the controller.
> Enable the IRQ wake capability in order to let the controller wake the
> host in case of available data.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> drivers/bluetooth/hci_intel.c | 176 ++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 176 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
> index 99f1307..4fdcb5d 100644
> --- a/drivers/bluetooth/hci_intel.c
> +++ b/drivers/bluetooth/hci_intel.c
> @@ -45,6 +45,10 @@
> #define STATE_FIRMWARE_FAILED	3
> #define STATE_BOOTING		4
> #define STATE_TX_ACTIVE		5
> +#define STATE_SUSPENDED		7
> +#define STATE_SUSPENDING	8
> +#define STATE_RESUMING		9
> +#define STATE_LPM_ENABLED	10

at some point we really need to think about how we can combine USB and UART into a unified code block. So we need to be careful with just stuffing new states in here.

> 
> #define HCI_LPM_PKT 0xf1
> #define HCI_LPM_MAX_SIZE 10
> @@ -57,6 +61,8 @@
> 	.maxlen = HCI_LPM_MAX_SIZE
> 
> #define LPM_OP_TX_NOTIFY 0x00
> +#define LPM_OP_SUSPEND_ACK 0x02
> +#define LPM_OP_RESUME_ACK 0x03
> 
> struct hci_lpm_pkt {
> 	__u8 opcode;
> @@ -735,6 +741,8 @@ done:
> 	}
> 	kfree_skb(skb);
> 
> +	set_bit(STATE_LPM_ENABLED, &intel->flags);
> +

This should have gone in the previous patch introducing LPM support.

> no_lpm:
> 	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_CMD_TIMEOUT);
> 	if (IS_ERR(skb))
> @@ -812,12 +820,28 @@ static void intel_recv_lpm_notification(struct hci_dev *hdev, int value)
> static int intel_recv_lpm(struct hci_dev *hdev, struct sk_buff *skb)
> {
> 	struct hci_lpm_pkt *lpm = (void *)skb->data;
> +	struct hci_uart *hu = hci_get_drvdata(hdev);
> +	struct intel_data *intel = hu->priv;
> 
> 	switch (lpm->opcode) {
> 	case LPM_OP_TX_NOTIFY:
> 		if (lpm->dlen)
> 			intel_recv_lpm_notification(hdev, lpm->data[0]);
> 		break;
> +	case LPM_OP_SUSPEND_ACK:
> +		set_bit(STATE_SUSPENDED, &intel->flags);
> +		if (test_and_clear_bit(STATE_SUSPENDING, &intel->flags)) {
> +			smp_mb__after_atomic();
> +			wake_up_bit(&intel->flags, STATE_SUSPENDING);
> +		}
> +		break;
> +	case LPM_OP_RESUME_ACK:
> +		clear_bit(STATE_SUSPENDED, &intel->flags);
> +		if (test_and_clear_bit(STATE_RESUMING, &intel->flags)) {
> +			smp_mb__after_atomic();
> +			wake_up_bit(&intel->flags, STATE_SUSPENDING);
> +		}

Is this a typo with RESUMING vs SUSPENDING? Otherwise better call this LPM_TRANSACTION or something that makes clear that we are doing a LPM change. Since we can only have one at a time.

> +		break;
> 	default:
> 		BT_ERR("%s: unknown LPM opcode (%02x)", hdev->name,
> 		       lpm->opcode);
> @@ -895,6 +919,111 @@ static struct sk_buff *intel_dequeue(struct hci_uart *hu)
> 	return skb;
> }
> 
> +static int intel_lpm_suspend(struct hci_uart *hu)
> +{
> +	static const u8 suspend[] = {0x01, 0x01, 0x01};
> +	struct intel_data *intel = hu->priv;
> +	struct sk_buff *skb;
> +	int err;
> +
> +	if (!test_bit(STATE_LPM_ENABLED, &intel->flags) ||
> +	    test_bit(STATE_SUSPENDED, &intel->flags))
> +		return 0;
> +
> +	if (test_bit(STATE_TX_ACTIVE, &intel->flags))
> +		return -EAGAIN;
> +
> +	BT_DBG("%s: suspending", hu->hdev->name);
> +
> +	skb = bt_skb_alloc(sizeof(suspend), GFP_KERNEL);
> +	if (!skb) {
> +		BT_ERR("Failed to allocate memory for suspend packet");
> +		return -ENOMEM;
> +	}
> +
> +	memcpy(skb_put(skb, sizeof(suspend)), suspend, sizeof(suspend));
> +	bt_cb(skb)->pkt_type = HCI_LPM_PKT;
> +
> +	set_bit(STATE_SUSPENDING, &intel->flags);
> +
> +	skb_queue_tail(&intel->txq, skb);
> +	hci_uart_tx_wakeup(hu);
> +
> +	err = wait_on_bit_timeout(&intel->flags, STATE_SUSPENDING,
> +				  TASK_INTERRUPTIBLE,
> +				  msecs_to_jiffies(1000));
> +	if (err == 1) {
> +		BT_ERR("%s: Device suspend interrupted", hu->hdev->name);
> +		clear_bit(STATE_SUSPENDING, &intel->flags);
> +		return -EINTR;
> +	}
> +
> +	if (err) {
> +		BT_ERR("%s: Device suspend timeout", hu->hdev->name);
> +		clear_bit(STATE_SUSPENDING, &intel->flags);
> +		return -ETIMEDOUT;
> +	}
> +
> +	if (!test_bit(STATE_SUSPENDED, &intel->flags)) {
> +		BT_ERR("%s: Device suspend error", hu->hdev->name);
> +		return -EINVAL;
> +	}

This keeps repeating itself. Create a helper function like I did with the booting one.

> +
> +	BT_DBG("%s: suspended", hu->hdev->name);
> +
> +	return 0;
> +}
> +
> +static int intel_lpm_resume(struct hci_uart *hu)
> +{
> +	struct intel_data *intel = hu->priv;
> +	struct sk_buff *skb;
> +	int err;
> +
> +	if (!test_bit(STATE_LPM_ENABLED, &intel->flags) ||
> +	    !test_bit(STATE_SUSPENDED, &intel->flags))
> +		return 0;
> +
> +	BT_DBG("%s: resuming", hu->hdev->name);
> +
> +	skb = bt_skb_alloc(0, GFP_KERNEL);
> +	if (!skb) {
> +		BT_ERR("Failed to allocate memory for resume packet");
> +		return -ENOMEM;
> +	}
> +
> +	bt_cb(skb)->pkt_type = 0xf0;

Introduce a define for this type like you did for the other one.

> +
> +	set_bit(STATE_RESUMING, &intel->flags);
> +
> +	skb_queue_tail(&intel->txq, skb);
> +	hci_uart_tx_wakeup(hu);
> +
> +	err = wait_on_bit_timeout(&intel->flags, STATE_RESUMING,
> +				  TASK_INTERRUPTIBLE,
> +				  msecs_to_jiffies(1000));
> +	if (err == 1) {
> +		BT_ERR("%s: Device resume interrupted", hu->hdev->name);
> +		clear_bit(STATE_RESUMING, &intel->flags);
> +		return -EINTR;
> +	}
> +
> +	if (err) {
> +		BT_ERR("%s: Device resume timeout", hu->hdev->name);
> +		clear_bit(STATE_RESUMING, &intel->flags);
> +		return -ETIMEDOUT;
> +	}
> +
> +	if (test_bit(STATE_SUSPENDED, &intel->flags)) {
> +		BT_ERR("%s: Device resume error", hu->hdev->name);
> +		return -EINVAL;
> +	}
> +
> +	BT_DBG("%s: resumed", hu->hdev->name);
> +
> +	return 0;
> +}
> +
> static const struct hci_uart_proto intel_proto = {
> 	.id		= HCI_UART_INTEL,
> 	.name		= "Intel",
> @@ -1025,6 +1154,52 @@ static int intel_remove(struct platform_device *pdev)
> 	return 0;
> }
> 
> +static int intel_suspend(struct device *dev)
> +{
> +	struct intel_device *idev = dev_get_drvdata(dev);
> +	struct intel_data *intel;
> +
> +	dev_dbg(dev, "intel_suspend\n");
> +
> +	if ((idev->irq < 0) || !device_may_wakeup(dev))
> +		return 0;

No ( ) around idev->irq < 0.

> +
> +	mutex_lock(&intel_data_list_lock);
> +	intel = intel_data_get(idev);
> +	if (intel)
> +		intel_lpm_suspend(intel->hu);
> +	mutex_unlock(&intel_data_list_lock);
> +
> +	enable_irq_wake(idev->irq);
> +
> +	return 0;
> +}
> +
> +static int intel_resume(struct device *dev)
> +{
> +	struct intel_device *idev = dev_get_drvdata(dev);
> +	struct intel_data *intel;
> +
> +	dev_dbg(dev, "intel_resume\n");
> +
> +	if ((idev->irq < 0) || !device_may_wakeup(dev))
> +		return 0;
> +
> +	disable_irq_wake(idev->irq);
> +
> +	mutex_lock(&intel_data_list_lock);
> +	intel = intel_data_get(idev);
> +	if (intel)
> +		intel_lpm_resume(intel->hu);
> +	mutex_unlock(&intel_data_list_lock);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops intel_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(intel_suspend, intel_resume)
> +};
> +

You need #ifdef CONFIG_PM_SLEEP.

> static struct platform_driver intel_driver = {
> 	.probe = intel_probe,
> 	.remove = intel_remove,
> @@ -1032,6 +1207,7 @@ static struct platform_driver intel_driver = {
> 		.name = "hci_intel",
> 		.acpi_match_table = ACPI_PTR(intel_acpi_match),
> 		.owner = THIS_MODULE,
> +		.pm = &intel_pm_ops,
> 	},
> };

Regards

Marcel

