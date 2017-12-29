Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1514560721.7000.542.camel@linux.intel.com>
Subject: Re: [PATCH 3/3] Bluetooth: Avoid WARN splat due to missing GPIOLIB
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>,
        Loic Poulain <loic.poulain@linaro.org>
Cc: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Danis
        <frederic.danis.oss@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Max Shavrick <mxms@me.com>, Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        Ronald Tschalaer <ronald@innovation.ch>,
        "Peter Y. Chuang" <peteryuchuang@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>
Date: Fri, 29 Dec 2017 17:18:41 +0200
In-Reply-To: <20171229151241.GA8078@wunner.de>
References: <5e3106d673c3c41bf92c91f1f43bf30682511366.1514143015.git.lukas@wunner.de>
         <9ef8be4ef80c38b693e5755c738a88de9c907944.1514143015.git.lukas@wunner.de>
         <1514450477.7000.302.camel@linux.intel.com>
         <20171228091805.GA1559@wunner.de>
         <1514453177.7000.320.camel@linux.intel.com>
         <CACRpkdb=Wj9dEfu7YEfQCA94MdBNQmp5UwHOgRsTZX=bf5d-Hw@mail.gmail.com>
         <1514464858.7000.334.camel@linux.intel.com>
         <CACRpkdYRojbfCC_b9vO0MquvLeenru0rrYNv7WzMg3d3b=iF+g@mail.gmail.com>
         <20171229095135.GA25623@wunner.de>
         <CAMZdPi-r3UZUNn-2n+nX1G7YekPhCG6-wuLTBYFxDuET=p-SZA@mail.gmail.com>
         <20171229151241.GA8078@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2017-12-29 at 16:12 +0100, Lukas Wunner wrote:
> On Fri, Dec 29, 2017 at 03:18:44PM +0100, Loic Poulain wrote:
> > On 29 December 2017 at 10:51, Lukas Wunner <lukas@wunner.de> wrote:

> > I think this is due to the adaptation to serdev bus support,
> > originally a
> > platform device was only added to describe power control resources
> > (via ACPI/DT), there was no associated pdev for non 'gpio-
> > controllable'
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

I was about to propose to get rid of _optional there and thus depends on
GPIOLIB should work fine for !GPIOLIB case, right?

Otherwise GPIO library should be fixed to be transparent for !GPIOLIB
cases.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
