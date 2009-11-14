Return-Path: <cyrus@holtmann.org>
Date: Sat, 14 Nov 2009 12:10:21 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Oliver Neukum <oliver@neukum.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	USB list <linux-usb@vger.kernel.org>,
	kernel list <linux-kernel@vger.kernel.org>, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: -rc6: something (probably active usb bluetooth) blocks suspend
Message-ID: <20091114111021.GA1378@ucw.cz>
References: <20091116112254.GB12315@elf.ucw.cz> <200911161248.29924.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200911161248.29924.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon 2009-11-16 12:48:29, Oliver Neukum wrote:
> Am Montag, 16. November 2009 12:22:54 schrieb Pavel Machek:
> 
> Hi Pavle,

:-)

> first the obvious question. Does it work if you down the interface?
> (not by killswitch)

Well, I'm not sure how repeatable it is. It happens once in two tries
today.

> > usb 5-1: usb suspend
> > usb 5-1: usb auto-resume
> > uhci_hcd 0000:00:1d.3: port 1 portsc 0095,01
> > usb 5-1: finish resume
> > uhci_hcd 0000:00:1d.3: reserve dev 2 ep81-INT, period 1, phase 0, 23
> > us
> 
> Why is the device autoresumed here? Are you using autosuspend?
> This is odd, as the freezer should block the send path and remote
> wakeups should be deferred.

I believe I have it enabled in kconfig but not during runtime.

(Another problem is that I need to turn the kill switch on/off to get
my bt usb after resume. That used not be the case long time ago.)
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
