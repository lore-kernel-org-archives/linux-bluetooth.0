Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Nov 2009 18:22:11 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Oliver Neukum <oliver@neukum.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	USB list <linux-usb@vger.kernel.org>,
	kernel list <linux-kernel@vger.kernel.org>, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: -rc6: something (probably active usb bluetooth) blocks suspend
Message-ID: <20091118172211.GC25150@elf.ucw.cz>
References: <20091116112254.GB12315@elf.ucw.cz>
 <200911161248.29924.oliver@neukum.org>
 <20091114111021.GA1378@ucw.cz>
 <200911161447.51651.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200911161447.51651.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!

> > > Why is the device autoresumed here? Are you using autosuspend?
> > > This is odd, as the freezer should block the send path and remote
> > > wakeups should be deferred.
> > 
> > I believe I have it enabled in kconfig but not during runtime.
> 
> Please check.

CONFIG_USB_SUSPEND=y

I'm not aware of  boot scripts enabling anything.

> > (Another problem is that I need to turn the kill switch on/off to get
> > my bt usb after resume. That used not be the case long time ago.)
> 
> That is possibly another problem.

Yes, I guess so. With those many USB experts around, I thought I'd
mention it :-).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
