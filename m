Return-Path: <russell@omocha.vort.org>
Date: Fri, 23 Apr 2004 15:47:49 -0400
From: Russell Neches <russell@ccs.neu.edu>
To: Marcel Holtmann <marcel@holtmann.org>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problem with kernel-2.6.5
Message-ID: <20040423194749.GA8699@omocha.vort.org>
References: <200404210427.29406.tim@birdsnest.maths.tcd.ie> <20040423071748.GC6531@heliopause.vort.org> <1082705375.23959.93.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1082705375.23959.93.camel@pegasus>
List-ID: <bluez-users.lists.sourceforge.net>

> actually I hope that the upcoming 2.6.6-rc3 will fix all of these
> problems. If not, then ask the USB guys for a patch.

Well, at least things are improving. When I started the previous thread
about this back in March (subject: crash on remove, I think), the
machine would completely lock, and I'd never see a panic or an oops.
Now, I get an oops, and the machine keeps running. So, I guess that's
progress!

In any event, that's my desktop (VIA chipset). The solution, for the
time being, is simply not to remove the Bluetooth key.  Everything has
always worked fine on my laptop (ALi chipset). You know the old joke:

	Patient:	Doctor! It hurts when I do this!
	
	* Patient does something
	
	Doctor:		Well, don't do that!

Russell
