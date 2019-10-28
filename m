Return-Path: <SRS0=W+hJ=YV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9EBCA9EC2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Oct 2019 19:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08BF621721
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Oct 2019 19:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbfJ1TJi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Oct 2019 15:09:38 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:56190 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbfJ1TJi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Oct 2019 15:09:38 -0400
Received: from marcel-macbook.fritz.box (p4FEFC197.dip0.t-ipconnect.de [79.239.193.151])
        by mail.holtmann.org (Postfix) with ESMTPSA id 11589CECCF;
        Mon, 28 Oct 2019 20:18:38 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [PATCH 2/3] Bluetooth: hci_h5: Add DT support for rtl8723bs
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191026204116.95119-3-bonstra@bonstra.fr.eu.org>
Date:   Mon, 28 Oct 2019 20:09:34 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <EEBFA5B4-AF9D-4B41-85E8-C0D304073A4F@holtmann.org>
References: <20191026204116.95119-1-bonstra@bonstra.fr.eu.org>
 <20191026204116.95119-3-bonstra@bonstra.fr.eu.org>
To:     Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>
X-Mailer: Apple Mail (2.3594.4.19)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Hugo,

> The hci_h5 already supports rtl8723bs devices discovered via ACPI. This
> commit adds support for discovering via device tree for ACPI-less
> platforms.
> 
> Signed-off-by: Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>
> ---
> drivers/bluetooth/hci_h5.c | 40 +++++++++++++++++++++++++++++++++-----
> 1 file changed, 35 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index dacf297baf59..49ac03b1a7e3 100644
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
> @@ -782,7 +783,9 @@ static const struct hci_uart_proto h5p = {
> 
> static int h5_serdev_probe(struct serdev_device *serdev)
> {
> -	const struct acpi_device_id *match;
> +	const struct acpi_device_id *acpi_match;
> +	const struct of_device_id *of_match;
> +	const char *cfgname = NULL;
> 	struct device *dev = &serdev->dev;
> 	struct h5 *h5;
> 
> @@ -797,16 +800,27 @@ static int h5_serdev_probe(struct serdev_device *serdev)
> 	serdev_device_set_drvdata(serdev, h5);
> 
> 	if (has_acpi_companion(dev)) {

then move const struct acpi_device_id *match here in the local focus.

> -		match = acpi_match_device(dev->driver->acpi_match_table, dev);
> -		if (!match)
> +		acpi_match = acpi_match_device(
> +				dev->driver->acpi_match_table, dev);
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

And have struct of_device_id *match here.

> +		of_match = of_match_device(dev->driver->of_match_table, dev);
> +		if (!of_match)
> +			return -ENODEV;
> +
> +		of_property_read_string(dev->of_node,
> +					"realtek,config-name", &cfgname);
> +
> +		h5->vnd = (const struct h5_vnd *)of_match->data;
> +		h5->id = cfgname;

So we can not just read a realtek specific variable here. This is still generic code for 3-Wire UART protocol and needs to be available to other vendors as well.

> 	}
> 
> 	h5->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
> @@ -996,6 +1010,19 @@ static const struct acpi_device_id h5_acpi_match[] = {
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
> @@ -1006,6 +1033,9 @@ static struct serdev_device_driver h5_serdev_driver = {
> 	.driver = {
> 		.name = "hci_uart_h5",
> 		.acpi_match_table = ACPI_PTR(h5_acpi_match),
> +#ifdef CONFIG_OF
> +		.of_match_table = h5_of_match,
> +#endif

Use of_match_ptr here instead of the ifdef.

> 		.pm = &h5_serdev_pm_ops,
> 	},
> };

Regards

Marcel

