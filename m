Return-Path: <cyrus@holtmann.org>
Message-ID: <55E9A500.8060609@intel.com>
Date: Fri, 04 Sep 2015 16:04:48 +0200
From: Loic Poulain <loic.poulain@intel.com>
MIME-Version: 1.0
To: Frederic Danis <frederic.danis@linux.intel.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 2/4] Bluetooth: hci_bcm: Fix IRQ polarity for T100
References: <1441373747-23042-1-git-send-email-frederic.danis@linux.intel.com> <1441373747-23042-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1441373747-23042-3-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> +/* IRQ polarity of some chipset are not defined correctly in ACPI table. */
> +static const struct dmi_system_id bcm_wrong_irq_dmi_table[] = {
> +#if defined(CONFIG_DMI) && defined(CONFIG_X86)
> +	{
> +		/* Asus T100TA */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "T100TA"),
> +		},
> +	},
> +#endif
> +	{ }
> +};
> +
>   static int bcm_acpi_probe(struct bcm_device *dev)
>   {
>   	struct platform_device *pdev = dev->pdev;
> @@ -608,6 +623,12 @@ static int bcm_acpi_probe(struct bcm_device *dev)
>
>   	acpi_dev_get_resources(adev, &resources, bcm_resource, dev);
>
> +	if (strstr(id->id, "BCM2E39") &&
> +	    dmi_check_system(bcm_wrong_irq_dmi_table)) {
> +		bt_dev_dbg(dev, "Fix irq polarity");
> +		dev->irq_polarity = !dev->irq_polarity;
> +	}

Since you now the right polarity on ASUS T100 you should just set the 
right one, not invert the current one. Imagine that T100 receive a BIOS
update with the polarity fixed, it will be inverted to a incorrect value.

Regards,
Loic

-- 
Intel Open Source Technology Center
http://oss.intel.com/
