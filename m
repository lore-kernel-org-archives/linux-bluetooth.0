Return-Path: <SRS0=qOEI=NK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C195C2BC61
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Oct 2018 11:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040BF2082B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Oct 2018 11:08:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 040BF2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbeJ3UB3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Oct 2018 16:01:29 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:46909 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbeJ3UB3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Oct 2018 16:01:29 -0400
Received: from marcel-macbook.fritz.box (p4FF9F655.dip0.t-ipconnect.de [79.249.246.85])
        by mail.holtmann.org (Postfix) with ESMTPSA id 160FECEFA8;
        Tue, 30 Oct 2018 12:15:53 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH 1/2] Bluetooth: Add Rfkill driver for Intel Bluetooth
 controller
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1540896634-17173-1-git-send-email-chethan.tumkur.narayan@intel.com>
Date:   Tue, 30 Oct 2018 12:08:26 +0100
Cc:     linux-bluetooth@vger.kernel.org, amit.k.bag@intel.com,
        Raghuram Hegde <raghuram.hegde@intel.com>,
        Sukumar Ghorai <sukumar.ghorai@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <808682A2-B3E5-4269-A3A3-CDF302CB2CF6@holtmann.org>
References: <1540896634-17173-1-git-send-email-chethan.tumkur.narayan@intel.com>
To:     Chethan T N <chethan.tumkur.narayan@intel.com>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Chethan,

> Register ACPI object INTL6205 as platform Bluetooth RfKill
> driver to attach/detach Intel Bluetooth controller from
> platform USB bus.
> 
> Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Signed-off-by: Sukumar Ghorai <sukumar.ghorai@intel.com>
> ---
> drivers/platform/x86/intel_bt_rfkill.c | 133 +++++++++++++++++++++++++++++++++
> 1 file changed, 133 insertions(+)
> create mode 100644 drivers/platform/x86/intel_bt_rfkill.c

I would include the Kconfig and Makefile changes here since it is a small driver.

> diff --git a/drivers/platform/x86/intel_bt_rfkill.c b/drivers/platform/x86/intel_bt_rfkill.c
> new file mode 100644
> index 000000000000..89a3d7f4b32c
> --- /dev/null
> +++ b/drivers/platform/x86/intel_bt_rfkill.c
> @@ -0,0 +1,133 @@
> +/*
> + *  Intel Bluetooth Rfkill Driver
> + */
> +
> +#include <linux/module.h>
> +#include <linux/acpi.h>
> +#include <linux/platform_device.h>
> +#include <linux/rfkill.h>
> +#include <linux/gpio/consumer.h>
> +
> +struct btintel_rfkill_dev {
> +	struct rfkill *rfk;

Most drivers used rfkill here instead of rfk. I only found one that used this abbreviation.

> +	struct gpio_desc *reset_gpio_handler;
> +};
> +
> +static const struct acpi_gpio_params reset_gpios = { 0, 0, false };
> +static const struct acpi_gpio_mapping acpi_btintel_gpios[] = {
> +	{ "reset-gpios", &reset_gpios, 1 },
> +	{ },
> +};
> +
> +static const struct acpi_device_id btintel_acpi_match[] = {
> +	{ "INTL6205", 0 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, btintel_acpi_match);

Personally I put these above the platform_driver struct right before it is used.

> +
> +static int btintel_disable_bt(struct gpio_desc *reset_gpio)
> +{
> +	if (!reset_gpio)
> +		return -EINVAL;
> +
> +	/* This will detach the Intel BT controller */
> +	gpiod_set_value(reset_gpio, 0);
> +	return 0;
> +}
> +
> +static int btintel_enable_bt(struct gpio_desc *reset_gpio)
> +{
> +	if (!reset_gpio)
> +		return -EINVAL;
> +
> +	/* This will re-attach the Intel BT controller */
> +	gpiod_set_value(reset_gpio, 1);
> +	return 0;
> +}
> +
> +/* RFKill handlers */
> +static int bt_rfkill_set_block(void *data, bool blocked)
> +{
> +	struct btintel_rfkill_dev *bt_dev = data;
> +	int ret;

This driver needs a bit more consistency. Either btintel_rfkill or intel_bt_rfkill, but lets not get this confused with actual btintel_ code that we already have.

> +
> +	if (blocked)
> +		ret = btintel_disable_bt(bt_dev->reset_gpio_handler);
> +	else
> +		ret = btintel_enable_bt(bt_dev->reset_gpio_handler);
> +
> +	return ret;
> +}
> +static const struct rfkill_ops rfk_ops = {
> +	.set_block = bt_rfkill_set_block,
> +};
> +
> +/* ACPI object probe */
> +static int btintel_probe(struct platform_device *pdev)
> +{
> +	struct btintel_rfkill_dev *bt_dev;
> +	int result;
> +
> +	bt_dev = kzalloc(sizeof(*bt_dev), GFP_KERNEL);
> +	if (!bt_dev)
> +		return -ENOMEM;

Would’t it better to just use the devm_ version here and let it handle the lifetime tracking of the associated memory.

> +
> +	dev_set_drvdata(&pdev->dev, bt_dev);
> +
> +	if (acpi_dev_add_driver_gpios(ACPI_COMPANION(&pdev->dev),
> +				     acpi_btintel_gpios)) {
> +		kfree(bt_dev);
> +		return -EINVAL;
> +	}
> +
> +	bt_dev->reset_gpio_handler = devm_gpiod_get_optional(&pdev->dev,
> +					"reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(bt_dev->reset_gpio_handler)) {
> +		kfree(bt_dev);
> +		return PTR_ERR(bt_dev->reset_gpio_handler);
> +	}
> +
> +	bt_dev->rfk = rfkill_alloc("intel_bluetooth",
> +				   &pdev->dev,
> +				   RFKILL_TYPE_BLUETOOTH,
> +				   &rfk_ops,
> +				   bt_dev);
> +	if (!bt_dev->rfk) {
> +		kfree(bt_dev);
> +		return -ENOMEM;
> +	}
> +
> +	result = rfkill_register(bt_dev->rfk);
> +	if (result) {
> +		rfkill_destroy(bt_dev->rfk);
> +		kfree(bt_dev);
> +	}
> +
> +	return result;
> +}
> +
> +static int btintel_remove(struct platform_device *pdev)
> +{
> +	struct btintel_rfkill_dev *bt_dev = dev_get_drvdata(&pdev->dev);
> +
> +	if (bt_dev->rfk) {
> +		rfkill_unregister(bt_dev->rfk);
> +		rfkill_destroy(bt_dev->rfk);
> +	}
> +
> +	kfree(bt_dev);
> +
> +	acpi_dev_remove_driver_gpios(ACPI_COMPANION(&pdev->dev));
> +
> +	return 0;
> +}
> +
> +static struct platform_driver btintel_driver = {
> +	.probe = btintel_probe,
> +	.remove = btintel_remove,
> +	.driver = {
> +		.name = "btintel”,

I don’t like this name since it is too generic. Call it btintel_rfkill or intel_bt_rfkill.

> +		.acpi_match_table = ACPI_PTR(btintel_acpi_match),
> +	},
> +};
> +module_platform_driver(btintel_driver);

Regards

Marcel

