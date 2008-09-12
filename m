Return-Path: <cyrus@holtmann.org>
Subject: Re: Packaging question
From: Marcel Holtmann <marcel@holtmann.org>
To: Stefan Seyfried <seife@suse.de>
Cc: linux-bluetooth@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <48C8D96A.6060900@suse.de>
References: <48C685F1.9040905@suse.de>
	 <1221084945.13336.31.camel@californication>  <48C8D96A.6060900@suse.de>
Content-Type: text/plain
Date: Fri, 12 Sep 2008 18:34:48 +0200
Message-Id: <1221237288.6695.19.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stefan,

> > Personally I like to see the bluez-utils package vanish and we are just
> > using bluez as main package name. Adding a virtual package bluetooth
> > that install all BlueZ packages would be nice to have, too.
> > 
> > This would result in the following package names:
> > 
> > 	bluez
> > 	bluez-libs
> > 	bluez-libs-devel
> > 	bluez-cups
> > 	bluez-alsa
> > 	bluez-gstreamer
> 
> I like that too. I'd probably call it just "bluez-devel", since I won't have a
> bluez-libs (and libbluetooth3-devel is bad).
> 
> What's important for me is that it is somehow consistent across distributions
> (which might also make it easier for you, in case the usual "cannot compile
> $foo" complaint is on the list, just tell them "install bluez-devel or
> bluez-libs-devel", no need to check which distribution the reporter is
> actually using).
> 
> So for now I'll go for the above list of packages, with libbluetooth3 instead
> of bluez-libs.

the Fedora packaging guidelines are kinda clear about how to name
library packages. Same as for Debian. I don't know about SuSE.

This is basically about the build dependencies and changing the devel
package name means that you would need to adjust all sources relying on
it.

Regards

Marcel


