Return-Path: <cyrus@holtmann.org>
Subject: Re: bluez-gnome: how to turn adapter off?
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: Stefan Seyfried <seife@suse.de>, linux-bluetooth@vger.kernel.org
In-Reply-To: <1222769841.3311.127.camel@cookie.hadess.net>
References: <48E0FB63.4000601@suse.de>
	 <1222704357.3311.87.camel@cookie.hadess.net>  <48E1004F.20605@suse.de>
	 <1222720796.3311.101.camel@cookie.hadess.net>
	 <1222744734.1825.36.camel@violet.holtmann.net>
	 <1222769841.3311.127.camel@cookie.hadess.net>
Content-Type: text/plain
Date: Tue, 30 Sep 2008 12:29:21 +0200
Message-Id: <1222770561.1825.59.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> > > > Ok, so I remembered wrong ;-) How about adding a "disable this adapter"
> > > > option? Would a patch that implements this be welcome?
> > > 
> > > I'd like a patch implementing HAL killswitching. DannyK can explain to
> > > you how that's supposed to work.
> > > 
> > > I saw this as a single toggle menu item in the right-click, allowing you
> > > to enable/disable the main Bluetooth adapter on laptops. If there's a
> > > killswitch present, and there's 0 or 1 adapter (and the adapter matches
> > > the expected device) then the Bluetooth icon would shown grayed out.
> > 
> > so I added killswitch support to bluetooth-properties. Works pretty good
> > enough for me.
> > 
> > I like having a grayed out icon, but for that to work, we first need to
> > have some who actually draws it in all resolutions for us.
> 
> GTK+ doesn't use separate pixbufs for those type of icons, but generates
> them on the fly with gdk_pixbuf_saturate_and_pixelate().
> 
> new_pixbuf = gdk_pixbuf_copy (original);
> gdk_pixbuf_saturate_and_pixelate(original, new_pixbuf, 0.8, TRUE);
> 
> And then set "new_pixbuf" as the image for the status icon. This will be
> a bit convoluted in the actual code as you're using icon names, and we'd
> need to 1) know whether we have a killswitch, and whether it's enabled
> and 2) modify the status icon to use the pixbuf.

as long as we have to poll the killswitch from HAL, this is never going
to get merged into bluez-gnome. I want async notifications.

Regards

Marcel


