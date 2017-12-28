Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1514464858.7000.334.camel@linux.intel.com>
Subject: Re: [PATCH 3/3] Bluetooth: Avoid WARN splat due to missing GPIOLIB
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Lukas Wunner <lukas@wunner.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Frederic Danis <frederic.danis.oss@gmail.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Max Shavrick <mxms@me.com>, Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        Ronald Tschalaer <ronald@innovation.ch>,
        "Peter Y. Chuang" <peteryuchuang@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date: Thu, 28 Dec 2017 14:40:58 +0200
In-Reply-To: <CACRpkdb=Wj9dEfu7YEfQCA94MdBNQmp5UwHOgRsTZX=bf5d-Hw@mail.gmail.com>
References: <5e3106d673c3c41bf92c91f1f43bf30682511366.1514143015.git.lukas@wunner.de>
         <9ef8be4ef80c38b693e5755c738a88de9c907944.1514143015.git.lukas@wunner.de>
         <1514450477.7000.302.camel@linux.intel.com>
         <20171228091805.GA1559@wunner.de>
         <1514453177.7000.320.camel@linux.intel.com>
         <CACRpkdb=Wj9dEfu7YEfQCA94MdBNQmp5UwHOgRsTZX=bf5d-Hw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2017-12-28 at 13:29 +0100, Linus Walleij wrote:
> On Thu, Dec 28, 2017 at 10:26 AM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, 2017-12-28 at 10:18 +0100, Lukas Wunner wrote:
> > > On Thu, Dec 28, 2017 at 10:41:17AM +0200, Andy Shevchenko wrote:
> > > > On Tue, 2017-12-26 at 17:07 +0200, Lukas Wunner wrote:

> > > Hm okay, Documentation/gpio/consumer.txt says:
> > > 
> > >     Guidelines for GPIOs consumers
> > >     ==============================
> > > 
> > >     Drivers that can't work without standard GPIO calls should
> > > have
> > >     Kconfig entries that depend on GPIOLIB.
> > > 
> > > So a "depends on GPIOLIB" would be more appropriate, right?
> > 
> > Yes, but still wrong for this certain driver. It *can* work w/o
> > GPIOLIB.
> > Now you have done unnecessary dependency for that case.
> 
> No I think it should use depends on GPIOLIB.
> 
> The reason is that the driver uses unconditional devm_gpiod_get(),
> not devm_gpiod_get_optional().

How come?
I just checked the code, all three use _optional() variant.

I checked in bcm_get_resources().

> 
> The only thing you achieve if you do not have a GPIOLIB is a driver
> that always exits probe with an error.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
