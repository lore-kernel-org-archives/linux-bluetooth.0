Return-Path: <SRS0=MaJy=CS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AF3C43461
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Sep 2020 16:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E5A82067C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Sep 2020 16:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgIIQCY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:02:24 -0400
Received: from mga06.intel.com ([134.134.136.31]:24720 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730588AbgIIP6l (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Sep 2020 11:58:41 -0400
IronPort-SDR: HfHz0HYwYzcxBjcfjkD1C9aIUTuzD7kyyKf/NoCG7KuonPhnss/MzaE03t2Et+vm/NeA9j5AiU
 PwQQb1cg2prA==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="219914229"
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="219914229"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 08:58:34 -0700
IronPort-SDR: IxS2NNZPAt2NRkBv9utGp2ZLBkdzxhLw/E5scRDzqhT/M++Tk2UWKTt0kNUyh6hNiaeJlEgkzL
 t8tpg9ojlopw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="333863841"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 09 Sep 2020 08:58:33 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kG2UQ-00FTRF-Ib; Wed, 09 Sep 2020 18:58:30 +0300
Date:   Wed, 9 Sep 2020 18:58:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v1 1/4] Bluetooth: hci_intel: enable on new platform
Message-ID: <20200909155830.GE1891694@smile.fi.intel.com>
References: <20200903184850.53055-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903184850.53055-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Sep 03, 2020 at 09:48:47PM +0300, Andy Shevchenko wrote:
> On new Intel platform the device is provided with INT33E3 ID.
> Append it to the list.
> 
> This will require ACPI_GPIO_QUIRK_ONLY_GPIOIO to be enabled because
> the relevant ASL looks like:
> 
> 	UartSerialBusV2 ( ... )
> 	GpioInt ( ... ) { ... }
> 	GpioIo ( ... ) { ... }
> 
> which means that first GPIO resource is an interrupt, while we are expecting it
> to be reset one (output). Do the same for host-wake because in case of
> GpioInt() the platform_get_irq() will do the job and should return correct
> Linux IRQ number. That said, host-wake GPIO can only be GpioIo() resource.
> 
> While here, drop commas in terminator lines.

Any comments?

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/bluetooth/hci_intel.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
> index f1299da6eed8..703d774be5a6 100644
> --- a/drivers/bluetooth/hci_intel.c
> +++ b/drivers/bluetooth/hci_intel.c
> @@ -1076,7 +1076,8 @@ static const struct hci_uart_proto intel_proto = {
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id intel_acpi_match[] = {
>  	{ "INT33E1", 0 },
> -	{ },
> +	{ "INT33E3", 0 },
> +	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, intel_acpi_match);
>  #endif
> @@ -1138,9 +1139,9 @@ static const struct acpi_gpio_params reset_gpios = { 0, 0, false };
>  static const struct acpi_gpio_params host_wake_gpios = { 1, 0, false };
>  
>  static const struct acpi_gpio_mapping acpi_hci_intel_gpios[] = {
> -	{ "reset-gpios", &reset_gpios, 1 },
> -	{ "host-wake-gpios", &host_wake_gpios, 1 },
> -	{ },
> +	{ "reset-gpios", &reset_gpios, 1, ACPI_GPIO_QUIRK_ONLY_GPIOIO },
> +	{ "host-wake-gpios", &host_wake_gpios, 1, ACPI_GPIO_QUIRK_ONLY_GPIOIO },
> +	{ }
>  };
>  
>  static int intel_probe(struct platform_device *pdev)
> -- 
> 2.28.0
> 

-- 
With Best Regards,
Andy Shevchenko


