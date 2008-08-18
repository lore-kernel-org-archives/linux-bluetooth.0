Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [rfc]btusb with SCO support
Date: Mon, 18 Aug 2008 14:57:27 +0200
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
References: <200807311452.24166.oliver@neukum.org> <200808122253.45829.oliver@neukum.org> <1219054429.7591.32.camel@violet.holtmann.net>
In-Reply-To: <1219054429.7591.32.camel@violet.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200808181457.27919.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Montag 18 August 2008 12:13:49 schrieb Marcel Holtmann:
> Hi Oliver,
> 
> > > > here's my current version of btusb with SCO support. This is preliminary.
> > > > I am still looking at a way to delay using the higher altsettings until SCO
> > > > is actually used, but the timeouts seem to be too long to do the obvious.
> > > 
> > > the module parameter and blacklist/quirks stuff has been merged upstream
> > > with Linus now. Feel free to update your SCO support patch and then lets
> > > get this merged.
> > 
> > Still testing. I am new to bluetooth so getting a sound testing environment
> > up takes a bit of time. I am getting iso urbs to complete now.
> 
> I hacked up a version that does work fine for me and has been tested on
> my Quad G5. The attached applies on top of 2.6.27-rc3.
> 
> The alternate settings are still fixed to selecting #2, however the
> change to always select the appropriate one would be simple. We only
> need to calculate the right value. The killing and re-submitting URB
> code is already present.

This approach has a principal race condition. You have no idea when
the work queue will be run. Thus you can lose the first SCO packages.

Secondly, what happens when this next event comes so quickly that
the work is still scheduled or running? it seems to me that the work handler
can read stale conn_hash values.

Thirdly, close() needs to be able to deal with the work still scheduled.
You need to flush workqueues there.

	Regards
		Oliver
