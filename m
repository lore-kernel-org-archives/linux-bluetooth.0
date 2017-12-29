Return-Path: <foo00@h08.hostsharing.net>
Date: Fri, 29 Dec 2017 10:51:35 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Frederic Danis <frederic.danis.oss@gmail.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>, Max Shavrick <mxms@me.com>,
	Leif Liddy <leif.liddy@gmail.com>,
	Daniel Roschka <danielroschka@phoenitydawn.de>,
	Ronald Tschalaer <ronald@innovation.ch>,
	"Peter Y. Chuang" <peteryuchuang@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Bluetooth: Avoid WARN splat due to missing GPIOLIB
Message-ID: <20171229095135.GA25623@wunner.de>
References: <5e3106d673c3c41bf92c91f1f43bf30682511366.1514143015.git.lukas@wunner.de>
 <9ef8be4ef80c38b693e5755c738a88de9c907944.1514143015.git.lukas@wunner.de>
 <1514450477.7000.302.camel@linux.intel.com>
 <20171228091805.GA1559@wunner.de>
 <1514453177.7000.320.camel@linux.intel.com>
 <CACRpkdb=Wj9dEfu7YEfQCA94MdBNQmp5UwHOgRsTZX=bf5d-Hw@mail.gmail.com>
 <1514464858.7000.334.camel@linux.intel.com>
 <CACRpkdYRojbfCC_b9vO0MquvLeenru0rrYNv7WzMg3d3b=iF+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACRpkdYRojbfCC_b9vO0MquvLeenru0rrYNv7WzMg3d3b=iF+g@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Dec 28, 2017 at 01:45:34PM +0100, Linus Walleij wrote:
> On Thu, Dec 28, 2017 at 1:40 PM, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, 2017-12-28 at 13:29 +0100, Linus Walleij wrote:
> >> On Thu, Dec 28, 2017 at 10:26 AM, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >> > On Thu, 2017-12-28 at 10:18 +0100, Lukas Wunner wrote:
> >> > > On Thu, Dec 28, 2017 at 10:41:17AM +0200, Andy Shevchenko wrote:
> >> > > > On Tue, 2017-12-26 at 17:07 +0200, Lukas Wunner wrote:
> >> > > Hm okay, Documentation/gpio/consumer.txt says:
> >> > >
> >> > >     Guidelines for GPIOs consumers
> >> > >     ==============================
> >> > >
> >> > >     Drivers that can't work without standard GPIO calls should have
> >> > >     Kconfig entries that depend on GPIOLIB.
> >> > >
> >> > > So a "depends on GPIOLIB" would be more appropriate, right?
> >> >
> >> > Yes, but still wrong for this certain driver. It *can* work w/o
> >> > GPIOLIB.
> >> > Now you have done unnecessary dependency for that case.
> >>
> >> No I think it should use depends on GPIOLIB.
> >>
> >> The reason is that the driver uses unconditional devm_gpiod_get(),
> >> not devm_gpiod_get_optional().
> >
> > How come?
> > I just checked the code, all three use _optional() variant.
> >
> > I checked in bcm_get_resources().

Even though hci_bcm.c uses devm_gpiod_get_optional() for the device
wakeup and shutdown pins, it calls gpiod_set_value() on both pins
without checking if the're NULL in bcm_gpio_set_power().

It also calls gpiod_to_irq() on the host wakeup pin without checking
if it's NULL in bcm_get_resources(), which results in a WARN splat
if GPIOLIB is not enabled.

So this is clearly wrong.  The problem is, I don't have this hardware
to test myself, I don't have a spec for the chip and I don't know
what the driver author's intention was.  Perhaps these are just glitches
that snuck in when power management was retrofitted into the driver
and we can fix them with a few NULL pointer checks.  But I'm not sure
if these pins are really optional.  What if there are boards where
the chip is off by default and must be powered on by the driver?
In that case the pins aren't optional and enabling GPIOLIB is required.

I guess this driver was never really tested without these pins present
as users would immediately get a NULL pointer deref on probe.


> And BT_HCIUART_NOKIA compiles drivers/bluetooth/hci_nokia.c
> which does depend on GPIOLIB.

Sorry, you weren't cc'ed on the original patch, I stated in the commit
message:

    The same issue is present in hci_intel.c and hci_nokia.c, fix those up
    as well.

These two use devm_gpiod_get(), so we agree that they need to depend
on GPIOLIB, right?

By the way, what is the rationale for this rule that consumers shall
depend on rather than select GPIOLIB?  So that users are forced to
enable at least one GPIO driver?  If that is the motivation, it's
not bullet-proof as users can still select GPIOLIB without selecting
a driver, or select an input-only GPIO driver even though the GPIOs
are used as outputs by hci_*.c.

Thanks,

Lukas
