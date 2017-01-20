Return-Path: <msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 20 Jan 2017 02:36:12 +0100
From: msuchanek <msuchanek@suse.de>
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann
 <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel
 <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus
 Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Alan Cox
 <gnomes@lxorguk.ukuu.org.uk>, Loic Poulain <loic.poulain@intel.com>, Pavel
 Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>, Linus Walleij
 <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial-owner@vger.kernel.org
Subject: Re: [PATCH v2 0/9] Serial slave device bus
In-Reply-To: <20170116225436.17505-1-robh@kernel.org>
References: <20170116225436.17505-1-robh@kernel.org>
Message-ID: <7d6a8a629f8b618cdb09c9112d1e5986@suse.de>
List-ID: <linux-bluetooth.vger.kernel.org>

On 2017-01-16 23:54, Rob Herring wrote:
> Here's a new version of the serdev bus support with all the review
> feedback so far incorporated. I've left it named serdev for now pending
> any further votes one way or the other, but I did rename the sysfs 
> visible
> portions to "serial".
> 
> There's still some discussion about what to do with devices that pass 
> thru
> data to userspace unmodified like GPS and could still use tty device 
> for
> the data path. IMO, we should treat this as a separate problem 
> following
> this series. Drivers we want to convert to serdev and already in the
> kernel don't need this functionality.

The whole point of the serial bus is to simplify and clean up support 
for
serial devices.
If tty users cannot use the kernel support for automagic kill
switches/resets/whatever with kernel GPIO or whatever framework and must
continue supporting userspace GPIO and hacks for writing IO space from
userland for their devices there is just no point.

I mean it's fine to add support for your single pet device but if you 
are
to support non-trivial number of devices they don't get all perfect 
kernel
driver overnight. And if you need userspace GPIO for half of your 
devices
you can just continue using it for all to *simplify* your userspace 
code.

It has already happened for SPI devices and the implementation of the
userspace access to SPI is dragging for years.

Thanks

Michal
