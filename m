Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] bluetooth: hci_ll: add proper SERDEV dependency
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170511114223.2744939-1-arnd@arndb.de>
Date: Thu, 18 May 2017 16:58:46 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andy Gross <andy.gross@linaro.org>,
        Loic Poulain <loic.poulain@intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <F0016B65-D5E6-4487-9932-8B1A1064224F@holtmann.org>
References: <20170511114223.2744939-1-arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arnd,

> When SERDEV is a loadable module, and the HCI code is built-in, we
> get a link error:
> 
> drivers/bluetooth/built-in.o: In function `ll_close':
> hci_ll.c:(.text+0x278d): undefined reference to `serdev_device_close'
> drivers/bluetooth/built-in.o: In function `hci_ti_probe':
> hci_ll.c:(.text+0x283c): undefined reference to `hci_uart_register_device'
> drivers/bluetooth/built-in.o: In function `ll_setup':
> hci_ll.c:(.text+0x289e): undefined reference to `serdev_device_set_flow_control'
> hci_ll.c:(.text+0x2b9c): undefined reference to `serdev_device_set_baudrate'
> drivers/bluetooth/built-in.o: In function `ll_open':
> hci_ll.c:(.text+0x2c77): undefined reference to `serdev_device_open'
> drivers/bluetooth/built-in.o: In function `ll_init':
> (.init.text+0x10d): undefined reference to `__serdev_device_driver_register'
> 
> We already have CONFIG_BT_HCIUART_SERDEV as a Kconfig symbol that is
> set when the serdev code is reachable by a driver. Unlike the nokia
> driver, this one can also be built when serdev is completely disabled,
> so we add a dependency on serdev either being usable or disabled here.
> 
> Fixes: 371805522f87 ("bluetooth: hci_uart: add LL protocol serdev driver support")
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> drivers/bluetooth/Kconfig | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index a63130ef2b98..b2cf0ae6b62d 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -133,6 +133,7 @@ config BT_HCIUART_ATH3K
> config BT_HCIUART_LL
> 	bool "HCILL protocol support"
> 	depends on BT_HCIUART
> +	depends on BT_HCIUART_SERDEV || SERIAL_DEV_BUS=n
> 	help
> 	  HCILL (HCI Low Level) is a serial protocol for communication
> 	  between Bluetooth device and host. This protocol is required for

this does not apply against bluetooth-next tree. Can you respin it with the acks.

Regards

Marcel

