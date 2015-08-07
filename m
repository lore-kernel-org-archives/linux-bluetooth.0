Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH v2 2/4] net: rfkill: gpio: Make BCM2E39 support optional
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1438959640-15476-3-git-send-email-frederic.danis@linux.intel.com>
Date: Fri, 7 Aug 2015 09:42:25 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <52614EB8-833E-475F-BE90-85C7C4C394DE@holtmann.org>
References: <1438959640-15476-1-git-send-email-frederic.danis@linux.intel.com> <1438959640-15476-3-git-send-email-frederic.danis@linux.intel.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> In case of kernel configured to build Bluetooth BCM UART driver, do not
> support BCM2E39 in rfkill-gpio.
> 
> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
> ---
> net/rfkill/rfkill-gpio.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
> index d5d58d9..16d7a3a 100644
> --- a/net/rfkill/rfkill-gpio.c
> +++ b/net/rfkill/rfkill-gpio.c
> @@ -164,7 +164,9 @@ static int rfkill_gpio_remove(struct platform_device *pdev)
> #ifdef CONFIG_ACPI
> static const struct acpi_device_id rfkill_acpi_match[] = {
> 	{ "BCM2E1A", RFKILL_TYPE_BLUETOOTH },
> +#ifndef CONFIG_BT_HCIUART_BCM
> 	{ "BCM2E39", RFKILL_TYPE_BLUETOOTH },
> +#endif

since we are supporting the Broadcom device properly now, lets just remove that entry here. No need to make it optional.

Regards

Marcel

