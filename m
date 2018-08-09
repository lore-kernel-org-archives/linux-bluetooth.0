Return-Path: <johan.hedberg@gmail.com>
Date: Thu, 9 Aug 2018 10:11:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Introduce BT_HCIUART_RTL configuration option
Message-ID: <20180809071132.GA11618@x1c.lan>
References: <20180808142712.88122-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180808142712.88122-1-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Aug 08, 2018, Marcel Holtmann wrote:
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -159,7 +159,6 @@ config BT_HCIUART_LL
>  config BT_HCIUART_3WIRE
>  	bool "Three-wire UART (H5) protocol support"
>  	depends on BT_HCIUART
> -	depends on BT_HCIUART_SERDEV
>  	help
>  	  The HCI Three-wire UART Transport Layer makes it possible to
>  	  user the Bluetooth HCI over a serial port interface. The HCI

This still doesn't prevent someone from explicitly selecting
BT_HCIUART_3WIRE (since it's not a virtual option like BT_RTL) but not
selecting BT_HCIUART_SERDEV. Doing that will still result in this
compiler warning:

drivers/bluetooth/hci_h5.c:934:36: warning: ‘h5_serdev_driver’ defined but not used [-Wunused-variable]
 static struct serdev_device_driver h5_serdev_driver = {
                                    ^~~~~~~~~~~~~~~~

So I think the dependency needs to either stay there, or then some
#ifdefs need to be added to hci_h5.c.

Johan
