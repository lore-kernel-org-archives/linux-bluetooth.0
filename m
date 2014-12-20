Return-Path: <cyrus@holtmann.org>
Message-ID: <1419108192.27548.7.camel@x220>
Subject: Re: [PATCH]  bluetooth: Add hci_h4p driver
From: Paul Bolle <pebolle@tiscali.nl>
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list
	 <linux-kernel@vger.kernel.org>, linux-arm-kernel
	 <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org,
	tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi,
	ivo.g.dimitrov.75@gmail.com, linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org
Date: Sat, 20 Dec 2014 21:43:12 +0100
In-Reply-To: <20141220202314.GA8484@amd>
References: <20141213223727.GA13894@amd> <20141220202314.GA8484@amd>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Pavel,

On Sat, 2014-12-20 at 21:23 +0100, Pavel Machek wrote:
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -243,4 +243,13 @@ config BT_WILINK
>  	  Say Y here to compile support for Texas Instrument's WiLink7 driver
>  	  into the kernel or say M to compile it as module (btwilink).
>  
> +config BT_NOKIA_H4P
> +	tristate "HCI driver with H4 Nokia extensions"
> +	help
> +	  Bluetooth HCI driver with H4 extensions.  This driver provides
> +	  support for H4+ Bluetooth chip with vendor-specific H4 extensions.
> +
> +	  Say Y here to compile support for h4 extended devices into the kernel
> +	  or say M to compile it as module (btnokia_h4p).

Will this module be called btnokia_h4p or ...

> +
>  endmenu
> diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
> index 9fe8a87..624ef3fc 100644
> --- a/drivers/bluetooth/Makefile
> +++ b/drivers/bluetooth/Makefile
> @@ -31,4 +31,7 @@ hci_uart-$(CONFIG_BT_HCIUART_ATH3K)	+= hci_ath.o
>  hci_uart-$(CONFIG_BT_HCIUART_3WIRE)	+= hci_h5.o
>  hci_uart-objs				:= $(hci_uart-y)
>  
> +obj-$(CONFIG_BT_NOKIA_H4P)      += nokia_h4p.o

... nokia_h4p?

> +nokia_h4p-objs := nokia_core.o nokia_fw.o nokia_uart.o
> +
>  ccflags-y += -D__CHECK_ENDIAN__

Or did I miss some make magic here?

Thanks,


Paul Bolle
