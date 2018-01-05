Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH v2 01/10] Bluetooth: Depend on rather than select GPIOLIB
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <4d4ac18f570efc6371bc44c70836bdd3ddee3902.1514916630.git.lukas@wunner.de>
Date: Fri, 5 Jan 2018 19:27:08 +0100
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Frederic Danis <frederic.danis.oss@gmail.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Max Shavrick <mxms@me.com>, Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        Ronald Tschalaer <ronald@innovation.ch>,
        "Peter Y. Chuang" <peteryuchuang@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Message-Id: <8D2574D3-0C47-4759-A0B4-BC065E746C25@holtmann.org>
References: <cover.1514916630.git.lukas@wunner.de>
 <4d4ac18f570efc6371bc44c70836bdd3ddee3902.1514916630.git.lukas@wunner.de>
To: Lukas Wunner <lukas@wunner.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukas,

> Commit 27378f4c1b92 ("Bluetooth: Avoid WARN splat due to missing
> GPIOLIB") amended Kconfig to select GPIOLIB if BT_HCIUART_NOKIA,
> BT_HCIUART_INTEL or BT_HCIUART_BCM is enabled since all three drivers
> require it to function.
> 
> The diagnosis was correct but the treatment was not.  As stated in
> Documentation/gpio/consumer.txt:
> 
>    Guidelines for GPIOs consumers
>    ==============================
> 
>    Drivers that can't work without standard GPIO calls should have
>    Kconfig entries that depend on GPIOLIB.
>                         ^^^^^^^^^
> Fix it.
> 
> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
> drivers/bluetooth/Kconfig | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

