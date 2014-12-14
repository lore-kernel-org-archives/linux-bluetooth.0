Return-Path: <cyrus@holtmann.org>
Date: Sun, 14 Dec 2014 22:52:43 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de,
	kernel list <linux-kernel@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org,
	aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: Re: bluetooth: Add hci_h4p driver
Message-ID: <20141214215243.GA22749@amd>
References: <20141213223727.GA13894@amd>
 <570BAC61-3137-42E5-B4F8-A61AEED380DE@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <570BAC61-3137-42E5-B4F8-A61AEED380DE@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!

> > Firmware load was converted to hci_cmd_sync(). Unfortunately, the
> > firmware is needed after every open/close, so the setup mechanism does
> > not quite fit. (But code is now way cleaner).
> 
> What is the reason for that? Does it mean that the device will always loose all its settings when powering it down. Do we know why that is that way and can we maybe change it?
>

Well, on hci_close(), original code asserts reset GPIO. I guess that
clears everything... I got it working with that removed, and it means
I can set the address the normal way. What are implications for power
consumption... I'm not sure at this point. Lets worry about that
later.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
