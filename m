Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1490531296.708.3.camel@linux.intel.com>
Subject: Re: [PATCH v1] Bluetooth: hci_bcm: Support platform enumeration
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Date: Sun, 26 Mar 2017 15:28:16 +0300
In-Reply-To: <20170310122820.7584-1-andriy.shevchenko@linux.intel.com>
References: <20170310122820.7584-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2017-03-10 at 14:28 +0200, Andy Shevchenko wrote:
> Until now the driver supports only ACPI enumeration. Nevertheless
> Intel Edison SoM has Broadcom Wi-Fi + BT chip and neither ACPI nor DT
> enumeration mechanism.
> 
> Enable pure platform driver in order to support Intel Edison SoM.
> 

Any comment on this?

> Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/bluetooth/hci_bcm.c | 50 ++++++++++++++++++++++++++++++----
> -----------
>  1 file changed, 33 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 5262a2077d7a..a26a4ca6968b 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -697,28 +697,14 @@ static int bcm_resource(struct acpi_resource
> *ares, void *data)
>  	/* Always tell the ACPI core to skip this resource */
>  	return 1;
>  }
> +#endif /* CONFIG_ACPI */
>  
> -static int bcm_acpi_probe(struct bcm_device *dev)
> +static int bcm_platform_probe(struct bcm_device *dev)
>  {
>  	struct platform_device *pdev = dev->pdev;
> -	LIST_HEAD(resources);
> -	const struct dmi_system_id *dmi_id;
> -	const struct acpi_gpio_mapping *gpio_mapping =
> acpi_bcm_int_last_gpios;
> -	const struct acpi_device_id *id;
> -	int ret;
>  
>  	dev->name = dev_name(&pdev->dev);
>  
> -	/* Retrieve GPIO data */
> -	id = acpi_match_device(pdev->dev.driver->acpi_match_table,
> &pdev->dev);
> -	if (id)
> -		gpio_mapping = (const struct acpi_gpio_mapping *) id-
> >driver_data;
> -
> -	ret = acpi_dev_add_driver_gpios(ACPI_COMPANION(&pdev->dev),
> -					gpio_mapping);
> -	if (ret)
> -		return ret;
> -
>  	dev->clk = devm_clk_get(&pdev->dev, NULL);
>  
>  	dev->device_wakeup = devm_gpiod_get_optional(&pdev->dev,
> @@ -755,6 +741,33 @@ static int bcm_acpi_probe(struct bcm_device *dev)
>  		return -EINVAL;
>  	}
>  
> +	return 0;
> +}
> +
> +#ifdef CONFIG_ACPI
> +static int bcm_acpi_probe(struct bcm_device *dev)
> +{
> +	struct platform_device *pdev = dev->pdev;
> +	LIST_HEAD(resources);
> +	const struct dmi_system_id *dmi_id;
> +	const struct acpi_gpio_mapping *gpio_mapping =
> acpi_bcm_int_last_gpios;
> +	const struct acpi_device_id *id;
> +	int ret;
> +
> +	/* Retrieve GPIO data */
> +	id = acpi_match_device(pdev->dev.driver->acpi_match_table,
> &pdev->dev);
> +	if (id)
> +		gpio_mapping = (const struct acpi_gpio_mapping *) id-
> >driver_data;
> +
> +	ret = acpi_dev_add_driver_gpios(ACPI_COMPANION(&pdev->dev),
> +					gpio_mapping);
> +	if (ret)
> +		return ret;
> +
> +	ret = bcm_platform_probe(dev);
> +	if (ret)
> +		return ret;
> +
>  	/* Retrieve UART ACPI info */
>  	ret = acpi_dev_get_resources(ACPI_COMPANION(&dev->pdev->dev),
>  				     &resources, bcm_resource, dev);
> @@ -789,7 +802,10 @@ static int bcm_probe(struct platform_device
> *pdev)
>  
>  	dev->pdev = pdev;
>  
> -	ret = bcm_acpi_probe(dev);
> +	if (has_acpi_companion(&pdev->dev))
> +		ret = bcm_acpi_probe(dev);
> +	else
> +		ret = bcm_platform_probe(dev);
>  	if (ret)
>  		return ret;
>  

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
