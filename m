Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] blutooth: try to improve CONFIG_SERIAL_DEV_BUS dependency
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170419175051.4177480-1-arnd@arndb.de>
Date: Wed, 19 Apr 2017 22:09:33 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Message-Id: <4F901B46-50C3-4932-9923-8E4FF69191B9@holtmann.org>
References: <20170419175051.4177480-1-arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arnd,

> With CONFIG_SERIAL_DEV_BUS=m, the hci_serdev.o file does not actually
> get built into hci_uart.o as the Makefile doesn't pick it up, leading
> to a link error with anything referring to it:
> 
> ERROR: "hci_uart_register_device" [drivers/bluetooth/hci_nokia.ko] undefined!
> scripts/Makefile.modpost:91: recipe for target '__modpost' failed
> 
> Changing this in the Makefile would cause another problem when
> hci_uart itself is built-in and cannot reference symbols from the
> serdev module.
> 
> This tries to address both problems by introducing a new hidden
> Kconfig symbol that controls both the compilation of hci_serdev.o
> and whether the Nokia driver can be selected. This seems to address
> the problem for me, though there might be a better way to do it.
> 
> Fixes: 7bb318680e86 ("Bluetooth: add nokia driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> drivers/bluetooth/Kconfig  | 8 +++++++-
> drivers/bluetooth/Makefile | 2 +-
> 2 files changed, 8 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
