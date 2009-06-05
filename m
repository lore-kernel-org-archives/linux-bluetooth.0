Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Add sixaxis cable-pairing plugin
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1244207191.23850.12.camel@localhost.localdomain>
References: <1244107722.30768.837.camel@cookie.hadess.net>
	 <1244139239.23850.1.camel@localhost.localdomain>
	 <1244198560.30768.2403.camel@cookie.hadess.net>
	 <1244207191.23850.12.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 05 Jun 2009 14:52:54 +0100
Message-Id: <1244209974.30768.2600.camel@cookie.hadess.net>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2009-06-05 at 15:06 +0200, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > > > Works for me, comments welcome.
> > > > 
> > > > It uses gudev. See http://blog.fubar.dk/?p=106
> > > 
> > > no way. Please use just plain libudev and spare use the GObject
> > > overhead. I have used libudev before and it is just fine. Not that I
> > > have actually looked at your patch at all.
> > 
> > GObject overhead? Did you intend on building sixaxis support into a 5
> > year old phone that it would actually matter?
> 
> as I said, I am not adding a dependency on a GObject based library to
> it. We wanna be able to replace GLib with eglib or similar if we have
> to. Doing this for GObject based libraries is a pain in the ass. It is
> just bloat.

Which is exactly why the cable pairing stuff is implemented as a plugin.
You don't have to care about what's in it, or what its dependencies are
if you don't ship the plugin.

> > Anyway, that'll go way down my list of things to do, along with porting
> > the rest of the apps to libusb1, which I guess will be a problem as
> > well.
> 
> My biggest problem with libusb1 is that not all distros have it right
> now. However that might change in 2 or 3 month. So it should become
> easier.

That's not what the mail archives or IRC will tell me. Your problem was
that this would make bluez depend on 2 different libusb versions, which
you didn't want. That hasn't changed.

> > gudev lives in udev-extras, and udev-extras will most likely be merged
> > into udev itself. And it saves me from reinventing the wheel, and doing
> > my own mainloop integration (etc.).
> 
> The whole point of udev and udev-extras is to keep the dependency chain
> small. So I don't think it gets merged.
> 
> The GLib mainloop integration for libudev is really simple. So that is
> not an excuse for being lazy and dragging GObject into the mix.

You can keep personal attacks out of that. I think I've shown enough
patience trying to get this functionality into bluez proper.

I won't be updating this patch, but Luiz showed interested. My patch
will show up in the Fedora packages shortly.

Cheers
