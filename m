Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: Bluetooth: hci_intel: Enable IRQ wake capability
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1441818255-16128-1-git-send-email-loic.poulain@intel.com>
Date: Wed, 9 Sep 2015 10:47:38 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <28EB23BC-CDAF-4139-BFFD-4756F2829F4F@holtmann.org>
References: <1441818255-16128-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> We need to explicitly enable the IRQ wakeup mode to let the controller
> wake the system from sleep states (like suspend-to-ram).
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> drivers/bluetooth/hci_intel.c | 34 +++++++++++++++++++++++++++++-----
> 1 file changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
> index b17386b..3314823 100644
> --- a/drivers/bluetooth/hci_intel.c
> +++ b/drivers/bluetooth/hci_intel.c
> @@ -1181,11 +1181,11 @@ static int intel_acpi_probe(struct intel_device *idev)
> #endif
> 
> #ifdef CONFIG_PM
> -static int intel_suspend(struct device *dev)
> +static int intel_rt_suspend(struct device *dev)
> {
> 	struct intel_device *idev = dev_get_drvdata(dev);
> 
> -	dev_dbg(dev, "intel_suspend");
> +	dev_dbg(dev, "intel_rt_suspend");

as mentioned to Fred, I rather the generic pieces summarized as intel_suspend_device and intel_resume_device functions.

Also instead of repeating the function name in the debug string, I rather have it say something useful. The function name can be enabled via dynamic debug easily. So no point in repeating it.

> 	mutex_lock(&idev->hu_lock);
> 	if (idev->hu)
> @@ -1195,11 +1195,11 @@ static int intel_suspend(struct device *dev)
> 	return 0;
> }
> 
> -static int intel_resume(struct device *dev)
> +static int intel_rt_resume(struct device *dev)
> {
> 	struct intel_device *idev = dev_get_drvdata(dev);
> 
> -	dev_dbg(dev, "intel_resume");
> +	dev_dbg(dev, "intel_rt_resume");
> 
> 	mutex_lock(&idev->hu_lock);
> 	if (idev->hu)
> @@ -1208,11 +1208,35 @@ static int intel_resume(struct device *dev)
> 
> 	return 0;
> }
> +
> +static int intel_suspend(struct device *dev)
> +{
> +	struct intel_device *idev = dev_get_drvdata(dev);
> +
> +	dev_dbg(dev, "intel_suspend");
> +
> +	if (device_may_wakeup(dev))
> +		enable_irq_wake(idev->irq);
> +
> +	return intel_rt_suspend(dev);
> +}
> +
> +static int intel_resume(struct device *dev)
> +{
> +	struct intel_device *idev = dev_get_drvdata(dev);
> +
> +	dev_dbg(dev, "intel_resume");
> +
> +	if (device_may_wakeup(dev))
> +		disable_irq_wake(idev->irq);
> +
> +	return intel_rt_resume(dev);
> +}
> #endif
> 
> static const struct dev_pm_ops intel_pm_ops = {
> 	SET_SYSTEM_SLEEP_PM_OPS(intel_suspend, intel_resume)
> -	SET_RUNTIME_PM_OPS(intel_suspend, intel_resume, NULL)
> +	SET_RUNTIME_PM_OPS(intel_rt_suspend, intel_rt_resume, NULL)
> };

Regards

Marcel

