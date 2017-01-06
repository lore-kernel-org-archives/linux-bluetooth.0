Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] Serial slave device bus
Date: Fri, 06 Jan 2017 20:25:34 +0100
Message-ID: <1877696.ddOr49d5xy@wuerfel>
In-Reply-To: <20170106162635.19677-1-robh@kernel.org>
References: <20170106162635.19677-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday, January 6, 2017 10:26:26 AM CET Rob Herring wrote:
> Here goes another attempt at a serial device bus (aka uart slaves, tty
> slaves, etc.).
> 
> After some discussions with Dmitry at LPC, I decided to move away from
> extending serio and moved back to making a new bus type instead. He didn't
> think using serio was a good fit, and serio has a number of peculiarities
> in regards to sysfs and it's driver model. I don't think we want to inherit
> those for serial slave devices.

Using serio was originally my idea, but since you seem to have discussed
this in more detail than I ever had, the new version is certainly fine with
me too.

> This version sits on top of tty_port rather than uart_port as Alan
> requested. Once I created a struct tty rather than moving everything
> needed to tty_port, it became a lot easier and less invasive to the tty
> core code.
> 
> I have hacked up versions of the BT ldisc and TI ST drivers moved over to
> use the serdev bus. I have BT working on the HiKey board which has TI BT.
> With the serdev bus support, it eliminates the need for the TI userspace
> UIM daemon.
> 
> This series and the mentioned drivers can be found here[1].

I took a quick look at the series and have no immediate concerns,
just one detail about the DT binding that seems odd to me.

	Arnd
