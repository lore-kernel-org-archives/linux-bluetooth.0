Return-Path: <andriy.shevchenko@linux.intel.com>
Message-ID: <1514491453.7000.470.camel@linux.intel.com>
Subject: Re: [PATCH v2] Bluetooth: Replace dependency on SERIAL_DEV_BUS by
 selection
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan
 <gustavo@padovan.org>,  Johan Hedberg <johan.hedberg@gmail.com>,
 linux-bluetooth@vger.kernel.org, "loic . poulain @ gmail . com"
 <loic.poulain@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: "arnd.bergmann" <arnd.bergmann@linaro.org>, Rob Herring <robh@kernel.org>
Date: Thu, 28 Dec 2017 22:04:13 +0200
In-Reply-To: <20171228195503.4283-1-andriy.shevchenko@linux.intel.com>
References: <20171228195503.4283-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2017-12-28 at 21:55 +0200, Andy Shevchenko wrote:
> The change restores build behaviour for old configurations when user
> didn't know and thus didn't select SERIAL_DEV_BUS explicitly for given
> HCI modules, such as hci_bcm.
> 

+Cc: Arnd, Rob.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: get rid of recursive dependencies
>  drivers/bluetooth/Kconfig | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 60e1c7d6986d..ea3d114d19e5 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -66,7 +66,6 @@ config BT_HCIBTSDIO
>  
>  config BT_HCIUART
>  	tristate "HCI UART driver"
> -	depends on SERIAL_DEV_BUS || !SERIAL_DEV_BUS
>  	depends on TTY
>  	help
>  	  Bluetooth HCI UART driver.
> @@ -78,11 +77,6 @@ config BT_HCIUART
>  	  Say Y here to compile support for Bluetooth UART devices
> into the
>  	  kernel or say M to compile it as module (hci_uart).
>  
> -config BT_HCIUART_SERDEV
> -	bool
> -	depends on SERIAL_DEV_BUS && BT_HCIUART
> -	default y
> -
>  config BT_HCIUART_H4
>  	bool "UART (H4) protocol support"
>  	depends on BT_HCIUART
> @@ -96,8 +90,8 @@ config BT_HCIUART_H4
>  config BT_HCIUART_NOKIA
>  	tristate "UART Nokia H4+ protocol support"
>  	depends on BT_HCIUART
> -	depends on BT_HCIUART_SERDEV
>  	depends on PM
> +	select SERIAL_DEV_BUS
>  	select BT_HCIUART_H4
>  	select BT_BCM
>  	help
> @@ -134,7 +128,8 @@ config BT_HCIUART_ATH3K
>  
>  config BT_HCIUART_LL
>  	bool "HCILL protocol support"
> -	depends on BT_HCIUART_SERDEV
> +	depends on BT_HCIUART
> +	select SERIAL_DEV_BUS
>  	help
>  	  HCILL (HCI Low Level) is a serial protocol for
> communication
>  	  between Bluetooth device and host. This protocol is
> required for
> @@ -169,8 +164,8 @@ config BT_HCIUART_INTEL
>  config BT_HCIUART_BCM
>  	bool "Broadcom protocol support"
>  	depends on BT_HCIUART
> -	depends on BT_HCIUART_SERDEV
> -	depends on (!ACPI || SERIAL_DEV_CTRL_TTYPORT)
> +	select SERIAL_DEV_CTRL_TTYPORT if !ACPI
> +	select SERIAL_DEV_BUS
>  	select BT_HCIUART_H4
>  	select BT_BCM
>  	help

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
