Return-Path: <pavel@ucw.cz>
Date: Thu, 18 Aug 2016 13:42:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Rob Herring <robh@kernel.org>, Jiri Slaby <jslaby@suse.com>,
	Sebastian Reichel <sre@kernel.org>,
	Peter Hurley <peter@hurleysoftware.com>,
	NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Message-ID: <20160818114254.GF7427@amd>
References: <20160818011445.22726-1-robh@kernel.org>
 <118926C8-F4D0-41F5-B6A8-690E0312F3FB@goldelico.com>
 <28DDAF2B-2341-403B-80D8-DA0A63F51FF1@holtmann.org>
 <20160818105521.GB7031@kroah.com>
 <6A3D5EFF-AC8B-4039-AFF8-652687EB8EDA@holtmann.org>
 <20160818112435.GA20876@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160818112435.GA20876@kroah.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!

> > > I would _love_ to see that happen, but what about the GPS line
> > > discipline that we have today?  How would that match up with a char
> > > device driver?
> > 
> > we have a GPS line discipline? What is that one doing? As far as I
> > know all GPS implementations are fully userspace.
> 
> Hm, for some reason I thought that was what n_gsm.c was being used for,
> but I could be wrong, I've never seen the hardware that uses that
> code...

n_gsm.c seems to be multiplexing support. Splits one serial link into
multiple "virtual" serial links. Nothing to do with GPS explicitely,
altrough it looks NMEA data is going to go over one of the channels
sometimes.

I guess we should care about that later...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
