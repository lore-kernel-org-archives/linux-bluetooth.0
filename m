Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: -rc6: something (probably active usb bluetooth) blocks suspend
Date: Mon, 16 Nov 2009 14:47:51 +0100
Cc: Alan Stern <stern@rowland.harvard.edu>,
 USB list <linux-usb@vger.kernel.org>,
 kernel list <linux-kernel@vger.kernel.org>,
 marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org,
 "Rafael J. Wysocki" <rjw@sisk.pl>
References: <20091116112254.GB12315@elf.ucw.cz> <200911161248.29924.oliver@neukum.org> <20091114111021.GA1378@ucw.cz>
In-Reply-To: <20091114111021.GA1378@ucw.cz>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200911161447.51651.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Samstag, 14. November 2009 12:10:21 schrieb Pavel Machek:
> On Mon 2009-11-16 12:48:29, Oliver Neukum wrote:
> > Am Montag, 16. November 2009 12:22:54 schrieb Pavel Machek:
> >
> > Hi Pavle,
> >
> :-)
> :
> > first the obvious question. Does it work if you down the interface?
> > (not by killswitch)
> 
> Well, I'm not sure how repeatable it is. It happens once in two tries
> today.

Ok, so it looks like a race.

> > > usb 5-1: usb suspend
> > > usb 5-1: usb auto-resume
> > > uhci_hcd 0000:00:1d.3: port 1 portsc 0095,01
> > > usb 5-1: finish resume
> > > uhci_hcd 0000:00:1d.3: reserve dev 2 ep81-INT, period 1, phase 0, 23
> > > us
> >
> > Why is the device autoresumed here? Are you using autosuspend?
> > This is odd, as the freezer should block the send path and remote
> > wakeups should be deferred.
> 
> I believe I have it enabled in kconfig but not during runtime.

Please check.
 
> (Another problem is that I need to turn the kill switch on/off to get
> my bt usb after resume. That used not be the case long time ago.)

That is possibly another problem.

	Regards
		Oliver
