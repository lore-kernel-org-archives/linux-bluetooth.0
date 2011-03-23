Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Mar 2011 08:20:02 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Par-Gunnar Hjalmdahl <par-gunnar.p.hjalmdahl@stericsson.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, <devel@driverdev.osuosl.org>, Linus
 Walleij <linus.walleij@linaro.org>, Linus Walleij
 <linus.walleij@stericsson.com>, Arnd Bergmann <arnd@arndb.de>, Vitaly Wool
 <vitalywool@gmail.com>, Marcel Holtmann <marcel@holtmann.org>,
 linux-kernel@vger.kernel.org, Lukasz Rymanowski
 <Lukasz.Rymanowski@tieto.com>, linux-bluetooth@vger.kernel.org, Pavan Savoy
 <pavan_savoy@sify.com>, Lee Jones <lee.jones@linaro.org>, Alan Cox
 <alan@lxorguk.ukuu.org.uk>, Par-Gunnar Hjalmdahl <pghatwork@gmail.com>
Subject: Re: [PATCH 1/2] staging: Add ST-Ericsson CG2900 driver
Message-Id: <20110323082002.bd60cea1.rdunlap@xenotime.net>
In-Reply-To: <1300888771-26437-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
References: <1300888771-26437-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 23 Mar 2011 14:59:31 +0100 Par-Gunnar Hjalmdahl wrote:

> This patch adds support for the ST-Ericsson CG2900
> Connectivity Combo controller (Bluetooth, FM, GPS).
> 
> diff --git a/drivers/staging/cg2900/Kconfig b/drivers/staging/cg2900/Kconfig
> new file mode 100644
> index 0000000..d0ba5c7
> --- /dev/null
> +++ b/drivers/staging/cg2900/Kconfig
> @@ -0,0 +1,52 @@
> +#
> +# CG2900
> +#
> +
> +config CG2900
> +	tristate "Support ST-Ericsson CG2900 main structure"
> +	depends on NET && MFD_SUPPORT
> +	help
> +	  Support for ST-Ericsson CG2900 Connectivity Combo controller main structure.
> +	  Supports multiple functionalities muxed over a Bluetooth HCI H:4 interface.
> +	  CG2900 support Bluetooth, FM radio, and GPS.
> +
> +config CG2900_CHIP
> +	tristate "Support CG2900 Connectivity controller"
> +	depends on CG2900
> +	help
> +	  Support for ST-Ericsson CG2900 Connectivity Controller
> +
> +config STLC2690_CHIP
> +	tristate "Support STLC2690 Connectivity controller"
> +	depends on CG2900
> +	help
> +	  Support for ST-Ericsson STLC2690 Connectivity Controller
> +
> +config CG2900_UART
> +	tristate "Support CG2900 UART transport"
> +	depends on CG2900
> +	select BT
> +	select BT_HCIUART
> +	help
> +	  Support for UART as transport for ST-Ericsson CG2900 Connectivity
> +	  Controller
> +
> +config CG2900_AUDIO
> +	tristate "Support CG2900 audio interface"
> +	depends on CG2900
> +	help
> +	  Support for ST-Ericsson CG2900 Connectivity audio interface. Gives a
> +	  module the ability to setup audio paths within the CG2900 controller.
> +

Just to be clear:  the cg2900_audio driver does not use any current kernel
sound/audio interfaces, right?


> +config CG2900_TEST
> +	tristate "Support CG2900 Test Char Device"
> +	depends on CG2900
> +	help
> +	  Support for ST-Ericsson CG2900 Test Character Device.
> +
> +config BT_CG2900
> +	tristate "ST-Ericsson CG2900 Bluetooth driver"
> +	depends on CG2900 && BT
> +	help
> +	  Select if ST-Ericsson CG2900 Connectivity controller shall be used as
> +	  Bluetooth controller for BlueZ.


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
