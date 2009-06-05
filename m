Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Add sixaxis cable-pairing plugin
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1244209974.30768.2600.camel@cookie.hadess.net>
References: <1244107722.30768.837.camel@cookie.hadess.net>
	 <1244139239.23850.1.camel@localhost.localdomain>
	 <1244198560.30768.2403.camel@cookie.hadess.net>
	 <1244207191.23850.12.camel@localhost.localdomain>
	 <1244209974.30768.2600.camel@cookie.hadess.net>
Content-Type: text/plain
Date: Fri, 05 Jun 2009 16:15:33 +0200
Message-Id: <1244211333.23850.46.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> > > > > Works for me, comments welcome.
> > > > > 
> > > > > It uses gudev. See http://blog.fubar.dk/?p=106
> > > > 
> > > > no way. Please use just plain libudev and spare use the GObject
> > > > overhead. I have used libudev before and it is just fine. Not that I
> > > > have actually looked at your patch at all.
> > > 
> > > GObject overhead? Did you intend on building sixaxis support into a 5
> > > year old phone that it would actually matter?
> > 
> > as I said, I am not adding a dependency on a GObject based library to
> > it. We wanna be able to replace GLib with eglib or similar if we have
> > to. Doing this for GObject based libraries is a pain in the ass. It is
> > just bloat.
> 
> Which is exactly why the cable pairing stuff is implemented as a plugin.
> You don't have to care about what's in it, or what its dependencies are
> if you don't ship the plugin.

then make it an external plugin in its own repository, but I am not
merging code that depends on anything GObject if it is just pointless
dependency and bloat.

> > > Anyway, that'll go way down my list of things to do, along with porting
> > > the rest of the apps to libusb1, which I guess will be a problem as
> > > well.
> > 
> > My biggest problem with libusb1 is that not all distros have it right
> > now. However that might change in 2 or 3 month. So it should become
> > easier.
> 
> That's not what the mail archives or IRC will tell me. Your problem was
> that this would make bluez depend on 2 different libusb versions, which
> you didn't want. That hasn't changed.

My answer might be misleading here. My view on this one hasn't changed.
I want either libusb0 or libusb1. However libusb1 becomes only an option
when all major distros did a refresh and have it available. So meaning
BlueZ will be ported over to libusb1 completely at some point. The point
is closer now than 6 month ago.

> > > gudev lives in udev-extras, and udev-extras will most likely be merged
> > > into udev itself. And it saves me from reinventing the wheel, and doing
> > > my own mainloop integration (etc.).
> > 
> > The whole point of udev and udev-extras is to keep the dependency chain
> > small. So I don't think it gets merged.
> > 
> > The GLib mainloop integration for libudev is really simple. So that is
> > not an excuse for being lazy and dragging GObject into the mix.
> 
> You can keep personal attacks out of that. I think I've shown enough
> patience trying to get this functionality into bluez proper.

This is not personal. I am keeping a watch on the dependencies of BlueZ
and I don't see any need for adding GObject to the mix for the SixAxis
support. Feel free to convince me that GObject based gudev is really
necessary for this. Until then I declare this bloat.

Please remember that BlueZ will run on embedded devices with limited
memory and space requirements. You might argue that these devices don't
need SixAxis support, but I prefer to keep that option.

> I won't be updating this patch, but Luiz showed interested. My patch
> will show up in the Fedora packages shortly.

That is your choice. Personally I really dislike if distros just go
against upstream and start merging stuff, because it takes more effort
to get it into upstream first.

On that point, you haven't merged the Socket fix upstream and also the
Wacom and UTF-8 fix could be send upstream. I know you send some version
of these at least once or twice, but besides me also Johan could merge
these patches.

Regards

Marcel


