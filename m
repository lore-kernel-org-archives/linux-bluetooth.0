Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <4d4ac18f570efc6371bc44c70836bdd3ddee3902.1514916630.git.lukas@wunner.de>
References: <cover.1514916630.git.lukas@wunner.de> <4d4ac18f570efc6371bc44c70836bdd3ddee3902.1514916630.git.lukas@wunner.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 3 Jan 2018 08:52:51 +0100
Message-ID: <CACRpkdbdbXFN6ASshiZ8OxFEyJVrAaGbwxUUTH2KV831r-02ag@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] Bluetooth: Depend on rather than select GPIOLIB
To: Lukas Wunner <lukas@wunner.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Frederic Danis <frederic.danis.oss@gmail.com>, Loic Poulain <loic.poulain@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>, Max Shavrick <mxms@me.com>, Leif Liddy <leif.liddy@gmail.com>,
	Daniel Roschka <danielroschka@phoenitydawn.de>, Ronald Tschalaer <ronald@innovation.ch>,
	"Peter Y. Chuang" <peteryuchuang@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jan 2, 2018 at 8:08 PM, Lukas Wunner <lukas@wunner.de> wrote:

> Commit 27378f4c1b92 ("Bluetooth: Avoid WARN splat due to missing
> GPIOLIB") amended Kconfig to select GPIOLIB if BT_HCIUART_NOKIA,
> BT_HCIUART_INTEL or BT_HCIUART_BCM is enabled since all three drivers
> require it to function.
>
> The diagnosis was correct but the treatment was not.  As stated in
> Documentation/gpio/consumer.txt:
>
>     Guidelines for GPIOs consumers
>     ==============================
>
>     Drivers that can't work without standard GPIO calls should have
>     Kconfig entries that depend on GPIOLIB.
>                          ^^^^^^^^^
> Fix it.
>
> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
