Return-Path: <cyrus@holtmann.org>
Message-ID: <48C8D96A.6060900@suse.de>
Date: Thu, 11 Sep 2008 10:40:10 +0200
From: Stefan Seyfried <seife@suse.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	David Woodhouse <dwmw2@infradead.org>
Subject: Re: Packaging question
References: <48C685F1.9040905@suse.de> <1221084945.13336.31.camel@californication>
In-Reply-To: <1221084945.13336.31.camel@californication>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Marcel Holtmann wrote:
> Hi Stefan,

> it seems that everybody is keeping the package names as they are. So
> mainly you have bluez-utils and bluez-libs (libbluetooth in case of
> Debian).

That's fine with me. I will also have to change the name to libbluetooth3 too
because of package naming conventions (library packages need to be named after
the librarys SONAME), but that should be fine.

> The bluez-audio is the wrong approach and I commented on it already
> multiple times. Check the Fedora packages. So actual audio plugin should
> be part of bluez-utils since it has no dependencies whatsoever. And yes,
> it makes sense to have it without the ALSA and GStreamer plugins.

Ok.

> Check http://people.redhat.com/bnocera/bluez/bluez.spec for details.

Cool. I searched for some example bluez-4 spec file but did not find it ;-)

> Personally I like to see the bluez-utils package vanish and we are just
> using bluez as main package name. Adding a virtual package bluetooth
> that install all BlueZ packages would be nice to have, too.
> 
> This would result in the following package names:
> 
> 	bluez
> 	bluez-libs
> 	bluez-libs-devel
> 	bluez-cups
> 	bluez-alsa
> 	bluez-gstreamer

I like that too. I'd probably call it just "bluez-devel", since I won't have a
bluez-libs (and libbluetooth3-devel is bad).

What's important for me is that it is somehow consistent across distributions
(which might also make it easier for you, in case the usual "cannot compile
$foo" complaint is on the list, just tell them "install bluez-devel or
bluez-libs-devel", no need to check which distribution the reporter is
actually using).

So for now I'll go for the above list of packages, with libbluetooth3 instead
of bluez-libs.

Thanks,

	Stefan
-- 
Stefan Seyfried
R&D Team Mobile Devices            |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg | "Well, surrounding them's out."

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG Nürnberg)
