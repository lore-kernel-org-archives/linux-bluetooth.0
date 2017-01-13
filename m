Return-Path: <andriy.shevchenko@linux.intel.com>
Message-ID: <1484322907.2133.113.camel@linux.intel.com>
Subject: Re: [PATCH 8/9] serdev: add a tty port controller driver
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann
 <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel
 <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus
 Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>,
 Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Loic Poulain
 <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown
 <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>,  "open
 list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Fri, 13 Jan 2017 17:55:07 +0200
In-Reply-To: <CAL_JsqKjKz2=vWTBmzp9E3HrzJRszpq2hV4gsxcvnkTgRLH1QQ@mail.gmail.com>
References: <20170106162635.19677-1-robh@kernel.org>
	 <20170106162635.19677-9-robh@kernel.org>
	 <1483798314.26691.3.camel@linux.intel.com>
	 <CAL_JsqJtJaadieC2PSe6YV9pvvv8TXTM-hSDR5MZR+n-aRWo1g@mail.gmail.com>
	 <1484319863.2133.110.camel@linux.intel.com>
	 <CAL_JsqKjKz2=vWTBmzp9E3HrzJRszpq2hV4gsxcvnkTgRLH1QQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2017-01-13 at 09:28 -0600, Rob Herring wrote:
> On Fri, Jan 13, 2017 at 9:04 AM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, 2017-01-12 at 10:01 -0600, Rob Herring wrote:
> > > On Sat, Jan 7, 2017 at 8:11 AM, Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Fri, 2017-01-06 at 10:26 -0600, Rob Herring wrote:

> > > Yes, otherwise the bus can be built as a module and this driver
> > > can
> > > still be enabled breaking the build. I could drop supporting
> > > building
> > > the bus as a module because as long as this is the only controller
> > > driver, it all has to be built-in.
> > 
> > Would
> > 
> > if SERIAL_DEV_BUS=y
> > 
> > work for you?
> 
> Yes, until we add a driver that doesn't have to be built-in. What
> about "depends on SERIAL_DEV_BUS != m"? That would be a bit more clear
> what the reason is.

Ah, good point.

Yes, it would also work. My concern was here is not add confusing 
'depend on MENU_OPTION'.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
