Return-Path: <SRS0=A2wO=YY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D2CC47E49
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Oct 2019 06:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76BA3217F9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Oct 2019 06:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfJaGUq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 31 Oct 2019 02:20:46 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:49840 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfJaGUq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 31 Oct 2019 02:20:46 -0400
Received: from [10.192.1.204] (unknown [178.18.58.186])
        by mail.holtmann.org (Postfix) with ESMTPSA id 0FA90CECF4;
        Thu, 31 Oct 2019 07:29:47 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [PATCH v2 2/3] Bluetooth: hci_h5: Add DT support for rtl8723bs
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191030224333.70241-3-bonstra@bonstra.fr.eu.org>
Date:   Thu, 31 Oct 2019 07:20:44 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <3E21484D-1E78-47AA-8118-42A3AFD45624@holtmann.org>
References: <20191030224333.70241-1-bonstra@bonstra.fr.eu.org>
 <20191030224333.70241-3-bonstra@bonstra.fr.eu.org>
To:     Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>
X-Mailer: Apple Mail (2.3594.4.19)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Hugo,

> The hci_h5 already supports Realtek controllers discovered via ACPI. This
> commit adds support for discovering via device tree for ACPI-less
> platforms.
> 
> Signed-off-by: Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>
> ---
> drivers/bluetooth/Kconfig  |  2 +-
> drivers/bluetooth/hci_h5.c | 40 +++++++++++++++++++++++++++++++++-----
> 2 files changed, 36 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index aae665a3a254..48c9a004b033 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -211,7 +211,7 @@ config BT_HCIUART_RTL
> 	depends on BT_HCIUART
> 	depends on BT_HCIUART_SERDEV
> 	depends on GPIOLIB
> -	depends on ACPI
> +	depends on (ACPI || OF)
> 	select BT_HCIUART_3WIRE
> 	select BT_RTL
> 	help
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index dacf297baf59..d4aceddaaab2 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -11,6 +11,7 @@
> #include <linux/gpio/consumer.h>
> #include <linux/kernel.h>
> #include <linux/mod_devicetable.h>
> +#include <linux/of_device.h>
> #include <linux/serdev.h>
> #include <linux/skbuff.h>
> 
> @@ -782,7 +783,6 @@ static const struct hci_uart_proto h5p = {
> 
> static int h5_serdev_probe(struct serdev_device *serdev)
> {
> -	const struct acpi_device_id *match;
> 	struct device *dev = &serdev->dev;
> 	struct h5 *h5;
> 
> @@ -797,16 +797,32 @@ static int h5_serdev_probe(struct serdev_device *serdev)
> 	serdev_device_set_drvdata(serdev, h5);
> 
> 	if (has_acpi_companion(dev)) {
> -		match = acpi_match_device(dev->driver->acpi_match_table, dev);
> -		if (!match)
> +		const struct acpi_device_id *acpi_match;
> +
> +		acpi_match = acpi_match_device(
> +				dev->driver->acpi_match_table, dev);

don’t bother with a different variable name here. Keep it match.

> +		if (!acpi_match)
> 			return -ENODEV;
> 
> -		h5->vnd = (const struct h5_vnd *)match->driver_data;
> -		h5->id  = (char *)match->id;
> +		h5->vnd = (const struct h5_vnd *)acpi_match->driver_data;
> +		h5->id  = (char *)acpi_match->id;
> 
> 		if (h5->vnd->acpi_gpio_map)
> 			devm_acpi_dev_add_driver_gpios(dev,
> 						       h5->vnd->acpi_gpio_map);
> +	} else if (dev->of_node) {
> +		const struct of_device_id *of_match;

Same here. Just keep the name as match.

> +		const char *cfgname = NULL;
> +
> +		of_match = of_match_device(dev->driver->of_match_table, dev);
> +		if (!of_match)
> +			return -ENODEV;
> +
> +		of_property_read_string(dev->of_node,
> +					"config-name", &cfgname);
> +
> +		h5->vnd = (const struct h5_vnd *)of_match->data;
> +		h5->id = cfgname;
> 	}
> 
> 	h5->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
> @@ -996,6 +1012,19 @@ static const struct acpi_device_id h5_acpi_match[] = {
> MODULE_DEVICE_TABLE(acpi, h5_acpi_match);
> #endif
> 
> +#ifdef CONFIG_OF
> +static const struct of_device_id h5_of_match[] = {
> +#ifdef CONFIG_BT_HCIUART_RTL
> +	{
> +		.compatible = "realtek,rtl8723bs-bt",
> +		.data = &rtl_vnd
> +	},
> +#endif
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, h5_of_match);
> +#endif
> +
> static const struct dev_pm_ops h5_serdev_pm_ops = {
> 	SET_SYSTEM_SLEEP_PM_OPS(h5_serdev_suspend, h5_serdev_resume)
> };
> @@ -1006,6 +1035,7 @@ static struct serdev_device_driver h5_serdev_driver = {
> 	.driver = {
> 		.name = "hci_uart_h5",
> 		.acpi_match_table = ACPI_PTR(h5_acpi_match),
> +		.of_match_table = of_match_ptr(h5_of_match),
> 		.pm = &h5_serdev_pm_ops,
> 	},
> };

Regards

Marcel

