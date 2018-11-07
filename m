Return-Path: <SRS0=TbT7=NS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6419C32789
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Nov 2018 01:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09BC120827
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Nov 2018 01:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIRAGnEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09BC120827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388875AbeKGLMl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Nov 2018 06:12:41 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45238 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388644AbeKGLMl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Nov 2018 06:12:41 -0500
Received: by mail-pf1-f195.google.com with SMTP id p17-v6so6602969pfj.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Nov 2018 17:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w8auZkXRCkJp9aVjsiXoUBTywSn3JQeKOxBwDvTRJ54=;
        b=gIRAGnECXO9nGKgp+9jlEH27XlUrZUC2zQ1G5gZx82gf2FpAtZZpfzUCDyUcoAdZiG
         Mk4HwEYrlt9ADBAqEb0ApgPIwbrZh6vJCEKUOXyFs+wbMxlIf8xqOhvV37u4evGzdGWn
         xS09Wk9h6Ma2TxtYDRSTbMNtSG3R3/tKS39Czr3GGBZ3rvCaD9tQJ0ZBUkPPVy9LPr9j
         2qtw7Pxu8K8P9JGuQNXxLRflvhGooB2zLxgiuX5kYZy9Li+kEPKZIT0qa9zgVMDTRh9Y
         q7kME6knt0mWRcEtzDnSKnBQlEHlKT3wBsdWzf2Hk/ZeTDUM39Keay2w+62qAqQdRfsc
         qm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w8auZkXRCkJp9aVjsiXoUBTywSn3JQeKOxBwDvTRJ54=;
        b=L2ArNzaF+nzEACt8XBWYB6mZIEqh1gBUFWdO4dCGT10MkUwRDz7Phc0wVRRj8QoXOu
         1a/WyaN/dmmQWiRzo2eMdTf4NngEC/E4i+gq+Ueqzuhwxu7tFK7gjoFwxOt0S+7xHObG
         0BxJMlg3MC0JJjY092N0THiN/ukqvR0v3jv2eQNk12XadjwYY/jkdbpplzucQgQi/MJu
         zr+HDjqpKny6IaBFYLyCfvHFLxRV1GwWNlwiYpPqzJkUA2XTWFi+x8qi80/YxzMTeqgF
         fd5YbKNXWH8g3ssGgfOFZslTFpXtAMazYkd5E/M4XmcqXTj14M+4XUXcbnbafQxo4N3D
         QDFw==
X-Gm-Message-State: AGRZ1gKjhx6NaaSgPTNZ+7I3zC/d0Wv0KjZgJIkRaLvDTSkbjQdGHvfL
        a+ZoO4yks8Z6XYpzIdm+jhI=
X-Google-Smtp-Source: AJdET5e/yFmxI7u2XaXpwuUhqipMpjKxWvBM4bR41kj7Ppe9iKRYdmTj+BpjSiuPJiELnbuI4OqvDQ==
X-Received: by 2002:a62:30c7:: with SMTP id w190-v6mr28061091pfw.188.1541555070535;
        Tue, 06 Nov 2018 17:44:30 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id h10sm10140454pgn.11.2018.11.06.17.44.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 17:44:29 -0800 (PST)
Date:   Tue, 6 Nov 2018 17:44:27 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     chethan tn <chethantn@gmail.com>
Cc:     chethan.tumkur.narayan@intel.com, linux-bluetooth@vger.kernel.org,
        amit.k.bag@intel.com, Raghuram Hegde <raghuram.hegde@intel.com>,
        sukumar.ghorai@intel.com, Marcel Holtmann <marcel@holtmann.org>,
        Rajat Jain <rajatja@chromium.org>
Subject: Re: [Patch v1] Bluetooth: Add Rfkill driver for Intel Bluetooth
 controller
Message-ID: <20181107014427.GA1121@dtor-ws>
References: <1540907764-26294-1-git-send-email-chethan.tumkur.narayan@intel.com>
 <CAMH2TCoG80TCheJqPhu3vxQAvgALnSh8g=jbw_QFM9BOTBq1XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMH2TCoG80TCheJqPhu3vxQAvgALnSh8g=jbw_QFM9BOTBq1XA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Chethan,

On Mon, Nov 05, 2018 at 02:46:26PM +0530, chethan tn wrote:
> Hi,
> 
> We are planning to further implement the followings, kindly please
> provide your suggestions.
> 1. To handle more than 1 Intel BT controller connected to platform,
> will keep list of the objects in "static const struct acpi_device_id
> intel_bt_rfkill_acpi_match[] ". And keep a list of "struct
> intel_bt_rfkill_dev" for each of the acpi object.
> 2.  With this implementation from user space RF kill for the device
> object is achieved, however need to map the rfkill object with the
> corresponding "hdev" so that on error from the controller kernel can
> do the reset through this RF Kill driver.

I am confused, why you model a generic chip reset functionality via
RFKill subsystem. As far as I understand, the issue is that you want to
be able to reset the chip when it gets confused and not actually disable
the chip/stop it from emitting RF signals.

I believe this functionality should be contained in the driver and you
simply need to come with a way to tie the adapter instance with data in
ACPI, probably based on physical USB connection.

Thanks.

> 
> Best Regards
> Chethan
> On Tue, Oct 30, 2018 at 7:27 PM Chethan T N
> <chethan.tumkur.narayan@intel.com> wrote:
> >
> > From: Raghuram Hegde <raghuram.hegde@intel.com>
> >
> > Register ACPI object INTL6205 as platform Bluetooth RfKill
> > driver to attach/detach Intel Bluetooth controller from
> > platform USB bus.
> >
> > Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
> > Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> > Signed-off-by: Sukumar Ghorai <sukumar.ghorai@intel.com>
> > ---
> >  drivers/platform/x86/Kconfig           |   9 +++
> >  drivers/platform/x86/Makefile          |   1 +
> >  drivers/platform/x86/intel_bt_rfkill.c | 123 +++++++++++++++++++++++++++++++++
> >  3 files changed, 133 insertions(+)
> >  create mode 100644 drivers/platform/x86/intel_bt_rfkill.c
> >
> > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> > index 0c1aa6c314f5..bf050ba644c6 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -1229,6 +1229,15 @@ config I2C_MULTI_INSTANTIATE
> >           To compile this driver as a module, choose M here: the module
> >           will be called i2c-multi-instantiate.
> >
> > +config INTEL_BT_RFKILL
> > +       tristate "Intel bluetooth platform rfkill support"
> > +       depends on ACPI
> > +       depends on RFKILL || !RFKILL
> > +       ---help---
> > +         This option adds support for rfkill switch on Intel bluetooth
> > +         controllers.
> > +         If you have a PC with Intel Bluetooth controller, choose Y.
> > +
> >  endif # X86_PLATFORM_DEVICES
> >
> >  config PMC_ATOM
> > diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> > index e6d1becf81ce..af9ac3cd6151 100644
> > --- a/drivers/platform/x86/Makefile
> > +++ b/drivers/platform/x86/Makefile
> > @@ -92,3 +92,4 @@ obj-$(CONFIG_MLX_PLATFORM)    += mlx-platform.o
> >  obj-$(CONFIG_INTEL_TURBO_MAX_3) += intel_turbo_max_3.o
> >  obj-$(CONFIG_INTEL_CHTDC_TI_PWRBTN)    += intel_chtdc_ti_pwrbtn.o
> >  obj-$(CONFIG_I2C_MULTI_INSTANTIATE)    += i2c-multi-instantiate.o
> > +obj-$(CONFIG_INTEL_BT_RFKILL)   += intel_bt_rfkill.o
> > diff --git a/drivers/platform/x86/intel_bt_rfkill.c b/drivers/platform/x86/intel_bt_rfkill.c
> > new file mode 100644
> > index 000000000000..904440dadb64
> > --- /dev/null
> > +++ b/drivers/platform/x86/intel_bt_rfkill.c
> > @@ -0,0 +1,123 @@
> > +/*
> > + *  Intel Bluetooth Rfkill Driver
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/acpi.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/rfkill.h>
> > +#include <linux/gpio/consumer.h>
> > +
> > +struct intel_bt_rfkill_dev {
> > +       struct rfkill *rfkill;
> > +       struct gpio_desc *reset_gpio_handler;
> > +};
> > +
> > +static const struct acpi_gpio_params reset_gpios = { 0, 0, false };
> > +static const struct acpi_gpio_mapping acpi_intel_bt_rfkill_gpios[] = {
> > +       { "reset-gpios", &reset_gpios, 1 },
> > +       { },
> > +};
> > +
> > +static int intel_bt_disable(struct gpio_desc *reset_gpio)
> > +{
> > +       if (!reset_gpio)
> > +               return -EINVAL;
> > +
> > +       /* This will detach the Intel BT controller */
> > +       gpiod_set_value(reset_gpio, 0);
> > +       return 0;
> > +}
> > +
> > +static int intel_bt_enable(struct gpio_desc *reset_gpio)
> > +{
> > +       if (!reset_gpio)
> > +               return -EINVAL;
> > +
> > +       /* This will re-attach the Intel BT controller */
> > +       gpiod_set_value(reset_gpio, 1);
> > +       return 0;
> > +}
> > +
> > +/* RFKill handlers */
> > +static int intel_bt_rfkill_set_block(void *data, bool blocked)
> > +{
> > +       struct intel_bt_rfkill_dev *bt_dev = data;
> > +       int ret;
> > +
> > +       if (blocked)
> > +               ret = intel_bt_disable(bt_dev->reset_gpio_handler);
> > +       else
> > +               ret = intel_bt_enable(bt_dev->reset_gpio_handler);
> > +
> > +       return ret;
> > +}
> > +static const struct rfkill_ops rfk_ops = {
> > +       .set_block = intel_bt_rfkill_set_block,
> > +};
> > +
> > +/* ACPI object probe */
> > +static int intel_bt_rfkill_probe(struct platform_device *pdev)
> > +{
> > +       struct intel_bt_rfkill_dev *bt_dev;
> > +       int result;
> > +
> > +       bt_dev = devm_kzalloc(&pdev->dev, sizeof(*bt_dev), GFP_KERNEL);
> > +       if (!bt_dev)
> > +               return -ENOMEM;
> > +
> > +       dev_set_drvdata(&pdev->dev, bt_dev);
> > +
> > +       if (acpi_dev_add_driver_gpios(ACPI_COMPANION(&pdev->dev),
> > +                                    acpi_intel_bt_rfkill_gpios))
> > +               return -EINVAL;
> > +
> > +       bt_dev->reset_gpio_handler = devm_gpiod_get_optional(&pdev->dev,
> > +                                       "reset", GPIOD_OUT_HIGH);
> > +       if (IS_ERR(bt_dev->reset_gpio_handler))
> > +               return PTR_ERR(bt_dev->reset_gpio_handler);
> > +
> > +       bt_dev->rfkill = rfkill_alloc("intel_bluetooth",
> > +                                  &pdev->dev,
> > +                                  RFKILL_TYPE_BLUETOOTH,
> > +                                  &rfk_ops,
> > +                                  bt_dev);
> > +       if (!bt_dev->rfkill)
> > +               return -ENOMEM;
> > +
> > +       result = rfkill_register(bt_dev->rfkill);
> > +       if (result)
> > +               rfkill_destroy(bt_dev->rfkill);
> > +
> > +       return result;
> > +}
> > +
> > +static int intel_bt_rfkill_remove(struct platform_device *pdev)
> > +{
> > +       struct intel_bt_rfkill_dev *bt_dev = dev_get_drvdata(&pdev->dev);
> > +
> > +       if (bt_dev->rfkill) {
> > +               rfkill_unregister(bt_dev->rfkill);
> > +               rfkill_destroy(bt_dev->rfkill);
> > +       }
> > +
> > +       acpi_dev_remove_driver_gpios(ACPI_COMPANION(&pdev->dev));
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct acpi_device_id intel_bt_rfkill_acpi_match[] = {
> > +       { "INTL6205", 0 },
> > +       { },
> > +};
> > +MODULE_DEVICE_TABLE(acpi, intel_bt_rfkill_acpi_match);
> > +
> > +static struct platform_driver intel_bt_rfkill_driver = {
> > +       .probe = intel_bt_rfkill_probe,
> > +       .remove = intel_bt_rfkill_remove,
> > +       .driver = {
> > +               .name = "intel_bt_rfkill",
> > +               .acpi_match_table = ACPI_PTR(intel_bt_rfkill_acpi_match),
> > +       },
> > +};
> > +module_platform_driver(intel_bt_rfkill_driver);
> > --
> > 2.7.4

-- 
Dmitry
