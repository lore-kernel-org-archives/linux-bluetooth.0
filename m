Return-Path: <robh@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170511114223.2744939-1-arnd@arndb.de>
References: <20170511114223.2744939-1-arnd@arndb.de>
From: Rob Herring <robh@kernel.org>
Date: Thu, 11 May 2017 10:03:01 -0500
Message-ID: <CAL_JsqJbAmXnZjaNhM+9ejd-qvo9S00XjKsB_RcyjtrRiv-FCQ@mail.gmail.com>
Subject: Re: [PATCH] bluetooth: hci_ll: add proper SERDEV dependency
To: Arnd Bergmann <arnd@arndb.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, Bjorn Andersson <bjorn.andersson@linaro.org>,
	"David S. Miller" <davem@davemloft.net>, Andy Gross <andy.gross@linaro.org>,
	Loic Poulain <loic.poulain@intel.com>, Sebastian Reichel <sre@kernel.org>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, May 11, 2017 at 6:41 AM, Arnd Bergmann <arnd@arndb.de> wrote:
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

I thought this was okay because of the differences with the nokia
driver, but I should have tested it. In hindsight, serdev as a module
is really a PIA considering that it effectively has to be built-in due
to TTY dependencies.

Acked-by: Rob Herring <robh@kernel.org>

>
> Fixes: 371805522f87 ("bluetooth: hci_uart: add LL protocol serdev driver support")
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/bluetooth/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
