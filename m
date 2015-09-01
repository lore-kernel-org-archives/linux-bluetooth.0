Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH 2/3] Bluetooth: hci_intel: Add PM support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1441118530-18154-2-git-send-email-loic.poulain@intel.com>
Date: Tue, 1 Sep 2015 08:05:10 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <687B701E-224F-466F-B1E9-06D0FAC8CC7A@holtmann.org>
References: <1441118530-18154-1-git-send-email-loic.poulain@intel.com> <1441118530-18154-2-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Add PM suspend/resume callbacks which call lpm_suspend/resume.
> Add LPM ack in threaded IRQ handler to notify the controller that
> resume is complete.
> Protect hci_uart against concurrent removing during suspend/resume.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> drivers/bluetooth/hci_intel.c | 66 +++++++++++++++++++++++++++++++++++++------
> 1 file changed, 58 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
> index 387961a..8651803 100644
> --- a/drivers/bluetooth/hci_intel.c
> +++ b/drivers/bluetooth/hci_intel.c
> @@ -68,6 +68,8 @@ struct intel_device {
> 	struct list_head list;
> 	struct platform_device *pdev;
> 	struct gpio_desc *reset;
> +	struct hci_uart *hu;
> +	struct mutex hu_lock;
> 	int irq;
> };
> 
> @@ -156,14 +158,7 @@ static int intel_wait_lpm_transaction(struct hci_uart *hu)
> 	return err;
> }
> 
> -static irqreturn_t intel_irq(int irq, void *dev_id)
> -{
> -	struct intel_device *idev = dev_id;
> -
> -	dev_info(&idev->pdev->dev, "hci_intel irq\n");
> -
> -	return IRQ_HANDLED;
> -}
> +static irqreturn_t intel_irq(int irq, void *dev_id);

I prefer to avoid forward declaration if possible. Can we get the code reordered?

> static int intel_set_power(struct hci_uart *hu, bool powered)
> {
> @@ -192,6 +187,10 @@ static int intel_set_power(struct hci_uart *hu, bool powered)
> 
> 		gpiod_set_value(idev->reset, powered);
> 
> +		mutex_lock(&idev->hu_lock);
> +		idev->hu = powered ? hu : NULL;
> +		mutex_unlock(&idev->hu_lock);
> +

I prefer if add a comment block around this code to explain why we are doing this.

> 		if (idev->irq < 0)
> 			break;
> 
> @@ -1061,6 +1060,20 @@ static const struct hci_uart_proto intel_proto = {
> 	.dequeue	= intel_dequeue,
> };
> 
> +static irqreturn_t intel_irq(int irq, void *dev_id)
> +{
> +	struct intel_device *idev = dev_id;
> +
> +	dev_info(&idev->pdev->dev, "hci_intel irq\n");
> +
> +	mutex_lock(&idev->hu_lock);
> +	if (idev->hu)
> +		intel_lpm_host_wake(idev->hu);
> +	mutex_unlock(&idev->hu_lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
> #ifdef CONFIG_ACPI
> static const struct acpi_device_id intel_acpi_match[] = {
> 	{ "INT33E1", 0 },
> @@ -1085,6 +1098,40 @@ static int intel_acpi_probe(struct intel_device *idev)
> }
> #endif
> 
> +#ifdef CONFIG_PM_SLEEP
> +static int intel_suspend(struct device *dev)
> +{
> +	struct intel_device *idev = dev_get_drvdata(dev);
> +
> +	dev_dbg(dev, "intel_suspend");
> +
> +	mutex_lock(&idev->hu_lock);
> +	if (idev->hu)
> +		intel_lpm_suspend(idev->hu);
> +	mutex_unlock(&idev->hu_lock);
> +
> +	return 0;
> +}
> +
> +static int intel_resume(struct device *dev)
> +{
> +	struct intel_device *idev = dev_get_drvdata(dev);
> +
> +	dev_dbg(dev, "intel_resume");
> +
> +	mutex_lock(&idev->hu_lock);
> +	if (idev->hu)
> +		intel_lpm_resume(idev->hu);
> +	mutex_unlock(&idev->hu_lock);
> +
> +	return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops intel_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(intel_suspend, intel_resume)
> +};
> +
> static int intel_probe(struct platform_device *pdev)
> {
> 	struct intel_device *idev;
> @@ -1093,6 +1140,8 @@ static int intel_probe(struct platform_device *pdev)
> 	if (!idev)
> 		return -ENOMEM;
> 
> +	mutex_init(&idev->hu_lock);
> +
> 	idev->pdev = pdev;
> 
> 	if (ACPI_HANDLE(&pdev->dev)) {
> @@ -1169,6 +1218,7 @@ static struct platform_driver intel_driver = {
> 	.driver = {
> 		.name = "hci_intel",
> 		.acpi_match_table = ACPI_PTR(intel_acpi_match),
> +		.pm = &intel_pm_ops,
> 	},
> };

Regards

Marcel

