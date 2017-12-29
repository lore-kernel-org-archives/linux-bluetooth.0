Return-Path: <loic.poulain@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20171229095135.GA25623@wunner.de>
References: <5e3106d673c3c41bf92c91f1f43bf30682511366.1514143015.git.lukas@wunner.de>
 <9ef8be4ef80c38b693e5755c738a88de9c907944.1514143015.git.lukas@wunner.de>
 <1514450477.7000.302.camel@linux.intel.com> <20171228091805.GA1559@wunner.de>
 <1514453177.7000.320.camel@linux.intel.com> <CACRpkdb=Wj9dEfu7YEfQCA94MdBNQmp5UwHOgRsTZX=bf5d-Hw@mail.gmail.com>
 <1514464858.7000.334.camel@linux.intel.com> <CACRpkdYRojbfCC_b9vO0MquvLeenru0rrYNv7WzMg3d3b=iF+g@mail.gmail.com>
 <20171229095135.GA25623@wunner.de>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Fri, 29 Dec 2017 15:18:44 +0100
Message-ID: <CAMZdPi-r3UZUNn-2n+nX1G7YekPhCG6-wuLTBYFxDuET=p-SZA@mail.gmail.com>
Subject: Re: [PATCH 3/3] Bluetooth: Avoid WARN splat due to missing GPIOLIB
To: Lukas Wunner <lukas@wunner.de>, =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis.oss@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>, Max Shavrick <mxms@me.com>, Leif Liddy <leif.liddy@gmail.com>,
	Daniel Roschka <danielroschka@phoenitydawn.de>, Ronald Tschalaer <ronald@innovation.ch>,
	"Peter Y. Chuang" <peteryuchuang@gmail.com>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On 29 December 2017 at 10:51, Lukas Wunner <lukas@wunner.de> wrote:
> On Thu, Dec 28, 2017 at 01:45:34PM +0100, Linus Walleij wrote:
>> On Thu, Dec 28, 2017 at 1:40 PM, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>> > On Thu, 2017-12-28 at 13:29 +0100, Linus Walleij wrote:
>> >> On Thu, Dec 28, 2017 at 10:26 AM, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>> >> > On Thu, 2017-12-28 at 10:18 +0100, Lukas Wunner wrote:
>> >> > > On Thu, Dec 28, 2017 at 10:41:17AM +0200, Andy Shevchenko wrote:
>> >> > > > On Tue, 2017-12-26 at 17:07 +0200, Lukas Wunner wrote:
>> >> > > Hm okay, Documentation/gpio/consumer.txt says:
>> >> > >
>> >> > >     Guidelines for GPIOs consumers
>> >> > >     ==============================
>> >> > >
>> >> > >     Drivers that can't work without standard GPIO calls should have
>> >> > >     Kconfig entries that depend on GPIOLIB.
>> >> > >
>> >> > > So a "depends on GPIOLIB" would be more appropriate, right?
>> >> >
>> >> > Yes, but still wrong for this certain driver. It *can* work w/o
>> >> > GPIOLIB.
>> >> > Now you have done unnecessary dependency for that case.
>> >>
>> >> No I think it should use depends on GPIOLIB.
>> >>
>> >> The reason is that the driver uses unconditional devm_gpiod_get(),
>> >> not devm_gpiod_get_optional().
>> >
>> > How come?
>> > I just checked the code, all three use _optional() variant.
>> >
>> > I checked in bcm_get_resources().
>
> Even though hci_bcm.c uses devm_gpiod_get_optional() for the device
> wakeup and shutdown pins, it calls gpiod_set_value() on both pins
> without checking if the're NULL in bcm_gpio_set_power().
>
> It also calls gpiod_to_irq() on the host wakeup pin without checking
> if it's NULL in bcm_get_resources(), which results in a WARN splat
> if GPIOLIB is not enabled.
>
> So this is clearly wrong.  The problem is, I don't have this hardware
> to test myself, I don't have a spec for the chip and I don't know
> what the driver author's intention was.  Perhaps these are just glitches
> that snuck in when power management was retrofitted into the driver
> and we can fix them with a few NULL pointer checks.  But I'm not sure
> if these pins are really optional.

I think this is due to the adaptation to serdev bus support, originally a
platform device was only added to describe power control resources
(via ACPI/DT), there was no associated pdev for non 'gpio-controllable'
devices and so no gpio action. Now that serdev is supported I agree
that some pointer checks should be added.

Regards,
Loic
