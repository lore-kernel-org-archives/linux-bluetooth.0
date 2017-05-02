Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] bluetooth: hci_uart: fix kconfig dependency
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170502131501.15851-1-tobias.regnery@gmail.com>
Date: Tue, 2 May 2017 20:07:14 +0200
Cc: Rob Herring <robh@kernel.org>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <A632A059-D8DF-4D7E-B76E-6D1208C93C73@holtmann.org>
References: <20170502131501.15851-1-tobias.regnery@gmail.com>
To: Tobias Regnery <tobias.regnery@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tobias,

> We see the following link error with CONFIG_BT_HCIUART=y,
> CONFIG_BT_HCIUART_LL=y and CONFIG_SERIAL_DEV_BUS=m:
> 
> drivers/built-in.o: In function 'll_close':
> supp.c:(.text+0x55add4): undefined reference to 'serdev_device_close'
> supp.c:(.text+0x55add4): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol 'serdev_device_close'
> drivers/built-in.o: In function 'll_open':
> supp.c:(.text+0x55aed0): undefined reference to 'serdev_device_open'
> supp.c:(.text+0x55aed0): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol 'serdev_device_open'
> drivers/built-in.o: In function `hci_ti_probe':
> supp.c:(.text+0x55b00c): undefined reference to 'hci_uart_register_device'
> supp.c:(.text+0x55b00c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol 'hci_uart_register_device'
> drivers/built-in.o: In function `ll_setup':
> supp.c:(.text+0x55b08c): undefined reference to 'serdev_device_set_flow_control'
> supp.c:(.text+0x55b08c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol 'serdev_device_set_flow_control'
> supp.c:(.text+0x55b324): undefined reference to 'serdev_device_set_baudrate'
> supp.c:(.text+0x55b324): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol 'serdev_device_set_baudrate'
> drivers/built-in.o: In function 'll_init':
> supp.c:(.init.text+0x1b508): undefined reference to '__serdev_device_driver_register'
> supp.c:(.init.text+0x1b508): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol '__serdev_device_driver_register'
> 
> Fix this by dependig BT_HCIUART_LL on the BT_HCIUART_SERDEV symbol.
> This implies a dependency on BT_HCIUART and hci_ll.c is only compiled in
> if SERIAl_DEV_BUS is built in or SERIAL_DEV_BUS and BT_HCIUART are
> modules.
> 
> Fixes: 371805522f87 ("bluetooth: hci_uart: add LL protocol serdev driver support")
> Signed-off-by: Tobias Regnery <tobias.regnery@gmail.com>
> ---
> Hi,
> 
> I'm not sure if this is the right fix because the dependencies are quite
> complicated but at least the build failure goes away with this change.
> 
> drivers/bluetooth/Kconfig | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
