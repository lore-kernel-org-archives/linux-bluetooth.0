Return-Path: <robh@kernel.org>
MIME-Version: 1.0
In-Reply-To: <3363597.IVJfReRkL0@wuerfel>
References: <20170106162635.19677-1-robh@kernel.org> <20170106162635.19677-7-robh@kernel.org>
 <3363597.IVJfReRkL0@wuerfel>
From: Rob Herring <robh@kernel.org>
Date: Fri, 6 Jan 2017 14:41:42 -0600
Message-ID: <CAL_JsqLxRmSkuDUgTY04C1JUKVz+A8djHTfB5ZoSM3FfUowbMw@mail.gmail.com>
Subject: Re: [PATCH 6/9] dt/bindings: Add a serial/UART attached device binding
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>,
	Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>,
	"Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>,
	Linus Walleij <linus.walleij@linaro.org>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jan 6, 2017 at 1:21 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday, January 6, 2017 10:26:32 AM CET Rob Herring wrote:
>> +Optional Properties:
>> +
>> +- reg          : A single cell representing the port/line number of the
>> +                 host UART. Only used if the host UART is a single node
>> +                 with multiple ports.
>> +
>
> If there is a 'reg' property in the child, I guess we should also
> document a #address-cells/#size-cells value for the parent.
>
> Can you give an example of a multi-port serial device we support?

A 16550 DUART chip. Not sure if we have any bindings for one though.
Maybe the chip would be the parent node containing 2 child ns16550
nodes.

> I was expecting that we already need a device node per port anyway,
> to make the console work.

Yes, good point. I think I'll just drop it for now.

Rob
