Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH v1] Bluetooth: Replace dependency on SERIAL_DEV_BUS by
 selection
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20171228194930.3345-1-andriy.shevchenko@linux.intel.com>
Date: Thu, 28 Dec 2017 20:56:32 +0100
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        "loic . poulain @ gmail . com" <loic.poulain@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Message-Id: <6F7B9AFB-0A86-4645-8F01-2C69C8703DAD@holtmann.org>
References: <20171228194930.3345-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andy,

> The change restores build behaviour for old configurations when user
> didn't know and thus didn't select SERIAL_DEV_BUS explicitly for given
> HCI modules, such as hci_bcm.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> drivers/bluetooth/Kconfig | 14 +++++---------
> 1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 60e1c7d6986d..52dec0804b28 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -78,11 +78,6 @@ config BT_HCIUART
> 	  Say Y here to compile support for Bluetooth UART devices into the
> 	  kernel or say M to compile it as module (hci_uart).
> 
> -config BT_HCIUART_SERDEV
> -	bool
> -	depends on SERIAL_DEV_BUS && BT_HCIUART
> -	default y
> -
> config BT_HCIUART_H4
> 	bool "UART (H4) protocol support"
> 	depends on BT_HCIUART
> @@ -96,8 +91,8 @@ config BT_HCIUART_H4
> config BT_HCIUART_NOKIA
> 	tristate "UART Nokia H4+ protocol support"
> 	depends on BT_HCIUART
> -	depends on BT_HCIUART_SERDEV
> 	depends on PM
> +	select SERIAL_DEV_BUS
> 	select BT_HCIUART_H4
> 	select BT_BCM
> 	help

I have a dejavu feeling about this. Maybe it is better that Rob and Arnd comment and ACK this before we go this route.

Regards

Marcel

