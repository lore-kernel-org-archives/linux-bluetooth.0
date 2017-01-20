Return-Path: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jan 2017 14:44:27 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rob Herring <robh@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>,
	Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	"Dr . H . Nikolaus Schaller" <hns@goldelico.com>,
	Peter Hurley <peter@hurleysoftware.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>,
	NeilBrown <neil@brown.name>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/9] Serial slave device bus
Message-ID: <20170120134427.GA12059@kroah.com>
References: <20170116225436.17505-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170116225436.17505-1-robh@kernel.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jan 16, 2017 at 04:54:27PM -0600, Rob Herring wrote:
> Here's a new version of the serdev bus support with all the review
> feedback so far incorporated. I've left it named serdev for now pending
> any further votes one way or the other, but I did rename the sysfs visible
> portions to "serial".
> 
> There's still some discussion about what to do with devices that pass thru
> data to userspace unmodified like GPS and could still use tty device for
> the data path. IMO, we should treat this as a separate problem following
> this series. Drivers we want to convert to serdev and already in the
> kernel don't need this functionality.
> 
> I need a SoB from Alan on his patch 2 and would like review from Alan and/or
> Peter on the locking in patch 5.

I've applied the first 4 patches now, can you respin this and hopefully
Peter will review that patch, as I'd like him to before taking it.

thanks,

greg k-h
