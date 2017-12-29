Return-Path: <foo00@h08.hostsharing.net>
Date: Fri, 29 Dec 2017 16:28:49 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Loic Poulain <loic.poulain@linaro.org>
Cc: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>, Max Shavrick <mxms@me.com>,
	Leif Liddy <leif.liddy@gmail.com>,
	Daniel Roschka <danielroschka@phoenitydawn.de>,
	Ronald Tschalaer <ronald@innovation.ch>,
	"Peter Y. Chuang" <peteryuchuang@gmail.com>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 3/3] Bluetooth: Avoid WARN splat due to missing GPIOLIB
Message-ID: <20171229152849.GB8078@wunner.de>
References: <9ef8be4ef80c38b693e5755c738a88de9c907944.1514143015.git.lukas@wunner.de>
 <1514450477.7000.302.camel@linux.intel.com>
 <20171228091805.GA1559@wunner.de>
 <1514453177.7000.320.camel@linux.intel.com>
 <CACRpkdb=Wj9dEfu7YEfQCA94MdBNQmp5UwHOgRsTZX=bf5d-Hw@mail.gmail.com>
 <1514464858.7000.334.camel@linux.intel.com>
 <CACRpkdYRojbfCC_b9vO0MquvLeenru0rrYNv7WzMg3d3b=iF+g@mail.gmail.com>
 <20171229095135.GA25623@wunner.de>
 <CAMZdPi-r3UZUNn-2n+nX1G7YekPhCG6-wuLTBYFxDuET=p-SZA@mail.gmail.com>
 <20171229151241.GA8078@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20171229151241.GA8078@wunner.de>
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Dec 29, 2017 at 04:12:41PM +0100, Lukas Wunner wrote:
> On Fri, Dec 29, 2017 at 03:18:44PM +0100, Loic Poulain wrote:
> > On 29 December 2017 at 10:51, Lukas Wunner <lukas@wunner.de> wrote:
> > > On Thu, Dec 28, 2017 at 01:45:34PM +0100, Linus Walleij wrote:
> > >> On Thu, Dec 28, 2017 at 1:40 PM, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > >> > On Thu, 2017-12-28 at 13:29 +0100, Linus Walleij wrote:
> > >> >> On Thu, Dec 28, 2017 at 10:26 AM, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > >> >> > On Thu, 2017-12-28 at 10:18 +0100, Lukas Wunner wrote:
> > >> >> > > On Thu, Dec 28, 2017 at 10:41:17AM +0200, Andy Shevchenko wrote:
> > >> >> > > > On Tue, 2017-12-26 at 17:07 +0200, Lukas Wunner wrote:
> > >> >> > > Hm okay, Documentation/gpio/consumer.txt says:
> > >> >> > >
> > >> >> > >     Guidelines for GPIOs consumers
> > >> >> > >     ==============================
> > >> >> > >
> > >> >> > >     Drivers that can't work without standard GPIO calls should have
> > >> >> > >     Kconfig entries that depend on GPIOLIB.
> > >> >> > >
> > >> >> > > So a "depends on GPIOLIB" would be more appropriate, right?
> > >> >> >
> > >> >> > Yes, but still wrong for this certain driver. It *can* work w/o
> > >> >> > GPIOLIB.
> > >> >> > Now you have done unnecessary dependency for that case.
> > >> >>
> > >> >> No I think it should use depends on GPIOLIB.
> > >> >>
> > >> >> The reason is that the driver uses unconditional devm_gpiod_get(),
> > >> >> not devm_gpiod_get_optional().
> > >> >
> > >> > How come?
> > >> > I just checked the code, all three use _optional() variant.
> > >> >
> > >> > I checked in bcm_get_resources().
> > >
> > > Even though hci_bcm.c uses devm_gpiod_get_optional() for the device
> > > wakeup and shutdown pins, it calls gpiod_set_value() on both pins
> > > without checking if the're NULL in bcm_gpio_set_power().
> > >
> > > It also calls gpiod_to_irq() on the host wakeup pin without checking
> > > if it's NULL in bcm_get_resources(), which results in a WARN splat
> > > if GPIOLIB is not enabled.
> > >
> > > So this is clearly wrong.  The problem is, I don't have this hardware
> > > to test myself, I don't have a spec for the chip and I don't know
> > > what the driver author's intention was.  Perhaps these are just glitches
> > > that snuck in when power management was retrofitted into the driver
> > > and we can fix them with a few NULL pointer checks.  But I'm not sure
> > > if these pins are really optional.
> > 
> > I think this is due to the adaptation to serdev bus support, originally a
> > platform device was only added to describe power control resources
> > (via ACPI/DT), there was no associated pdev for non 'gpio-controllable'
> > devices and so no gpio action. Now that serdev is supported I agree
> > that some pointer checks should be added.
> 
> You're correct that GPIO use was originally mandatory in this driver,
> but serdev has nothing to do with it becoming optional.
> 
> Rather, commit 62aaefa7d038 ("Bluetooth: hci_bcm: improve use of gpios
> API") added the _optional "to simplify error handling".
> 
> So the _optional is a red herring and GPIO use is not optional at all
> in this driver.  Adding Uwe Kleine-König to cc.

Oh I guess you mean this part:

	/* Make sure at-least one of the GPIO is defined and that
	 * a name is specified for this instance
	 */
	if ((!dev->device_wakeup && !dev->shutdown) || !dev->name) {
		dev_err(dev->dev, "invalid platform data\n");
		return -EINVAL;
	}

Indeed this was removed by Hans with 8a92056837fd ("Bluetooth: hci_bcm:
Add (runtime)pm support to the serdev driver").

Hans, was this intentional?

BTW why was only one of the two pins required to be non-NULL?  Since
*both* pins are unconditionally accessed in bcm_gpio_set_power(),
which is called from the ->probe hook, we'd still get a NULL pointer
deref.  And this has been present ever since power management was
introduced with 0395ffc1ee05 ("Bluetooth: hci_bcm: Add PM for BCM
devices").

Adding Uwe to cc for real now, sorry.

Thanks,

Lukas
