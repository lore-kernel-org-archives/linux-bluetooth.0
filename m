Return-Path: <pavel@ucw.cz>
Date: Fri, 26 Aug 2016 22:05:09 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>,
	Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	"Dr . H . Nikolaus Schaller" <hns@goldelico.com>,
	Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	Loic Poulain <loic.poulain@intel.com>,
	Peter Hurley <peter@hurleysoftware.com>,
	NeilBrown <neil@brown.name>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] UART slave devices using serio
Message-ID: <20160826200509.GA22583@amd>
References: <20160824232437.9446-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160824232437.9446-1-robh@kernel.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed 2016-08-24 18:24:30, Rob Herring wrote:
> This is a new approach to supporting UART slave devices using the
> existing serio bus. After Arnd's proding, I took another look at serio
> and decided extending it does make sense. Using serio primarily requires
> adding DT based device matching and supporting buffer based write and
> receive.

Strange, the series has _two_ 1/6 patches.

> Rob Herring (6):
>   serio: add DT driver binding

There's one saying "add OF driver binding" on the mailinglist, too...
Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
