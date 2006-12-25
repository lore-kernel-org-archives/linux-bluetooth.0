Return-Path: <bram@sara.nl>
Subject: Re: [Bluez-devel] [Pkg-bluetooth-maintainers] dbus dependency
	introduces unwanted X11 dependency
From: Bram Stolk <bram@sara.nl>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>,
        pkg-bluetooth-maintainers@lists.alioth.debian.org
In-Reply-To: <1167070266.11510.27.camel@violet>
References: <1167052771.5265.7.camel@suske>
	 <20061225165542.GA970@esaurito.net>  <1167066856.11510.22.camel@violet>
	 <1167069204.5265.35.camel@suske>  <1167070266.11510.27.camel@violet>
Content-Type: text/plain
Date: Mon, 25 Dec 2006 19:30:06 +0100
Message-Id: <1167071406.5265.54.camel@suske>
Mime-Version: 1.0
List-ID: <bluez-devel.lists.sourceforge.net>

On Mon, 2006-12-25 at 19:11 +0100, Marcel Holtmann wrote:
> Hi Bram,
> 
> > > the bluez-utils depends on a working D-Bus system bus. It has no
> > > dependency on X or anything else (besides the Bluetooth library). So if
> > > it pulls in X related stuff then this is a fault of D-Bus or its package
> > > and not a problem within the bluez-utils package.
> > 
> > I'll take this up with the dbus maintainer then.
> > 
> > I still think that there is no need for X11 client stuff if you
> > want to run a PAN daemon. Bluetooth communication has nothing to
> > do with graphics devices. The 2.x version of bluez-utils demonstrated
> > it can do without.
> 
> you still don't understand it. BlueZ is _not_ using any X functionality

With all due respect:

I think it is you who does not understand (or not read).
In my very first mail I wrote:
"And with dbus, X11 is introduced."

I was, and still am, perfectly aware that the x11 dep comes 
from dbus, not from bluez-utils directly. It is literally what
I wrote in my mail. Pleas re-read.

That is why I asked whether libdbus would be enough.

As it turned out that libdbus is not enough, I will take this up 
with the 'dbus' people. My guess is that dbus-launch could be
split from the rest of dbus, to avoid bringing in X11 if you want
to do PAN.

> in its daemons. We never have and we never will be. Period. However we
> use D-Bus as general communication method and that is a hard dependency
> now and it won't change in the future. So if you wanna use something
> that doesn't use D-Bus then stick to the 2.x releases. There was a
> reason why we changed the major version number.

Ok, fine.
It's just that when you compare dependencies between 2.x and 3.x, it 
is *not* that the communication method changed: libdbus was a dependency
for both versions. I do not think that you realized this.

Thank you for your input,

  Bram

> Regards
> 
> Marcel
> 
> 
