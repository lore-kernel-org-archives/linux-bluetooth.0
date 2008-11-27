Return-Path: <cyrus@holtmann.org>
Subject: Re: Sony BD Remote (help requested)
From: Bastien Nocera <hadess@hadess.net>
To: Jelle de Jong <jelledejong@powercraft.nl>
Cc: Simon Kenyon <simon@koala.ie>, linux-bluetooth@vger.kernel.org
In-Reply-To: <492E81B1.5020709@powercraft.nl>
References: <492E6E6A.80509@koala.ie>  <492E7D86.8030007@powercraft.nl>
	 <1227784243.27994.1770.camel@cookie.hadess.net>
	 <492E81B1.5020709@powercraft.nl>
Content-Type: text/plain
Date: Thu, 27 Nov 2008 11:30:10 +0000
Message-Id: <1227785410.27994.1792.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2008-11-27 at 12:17 +0100, Jelle de Jong wrote:
> Bastien Nocera wrote:
> > On Thu, 2008-11-27 at 11:59 +0100, Jelle de Jong wrote:
> > <snip>
> >> I talked to Marcel about the Sony BD Remote on the CELINUX event in the
> >> Netherlands. I took my Sony BD Remote with me to show some issues.
> >> Marcel did some on the fly coding to get the device connected, but there
> >> is missing an hid driver that maps the keys to an input event xorg can use.
> >>
> >> So the device is not working yet, until somebody creates a proper hid
> >> driver for the device to map the keys.
> > 
> > Should just work with a (very) recent distro:
> > https://bugs.freedesktop.org/show_bug.cgi?id=16519
> > 
> > This might be missing some keys in the X evdev keyboard map, although I
> > believe Peter already fixed this.
> > 
> > And it should also just work using LIRC (which is how I got it to work
> > in the first place). Use gnome-lirc-properties to set it up.
> > 
> > Cheers
> 
> So does it create an input event that I can use with evtest and
> xbindkeys --key to add commands to the keys.

That's what the point of the patch was.

>  I really really don't like
> all those gnome apps.... to get hardware working, hardware should be
> graphical destkop independent configured.

And that's what those apps do. If you want to configure the stuff by
hand, be my guest, but don't come complaining to me if you can't figure
out how to setup LIRC.

>  A month ago the device was not
> working yet.

It's working, it can talk to the computer and generates input layer
events. Everything on top is minor niggles, and integration. And that
doesn't just happen out of thin air.

