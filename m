Return-Path: <cyrus@holtmann.org>
Message-ID: <4880ED2C.1020203@aster.pl>
Date: Fri, 18 Jul 2008 21:21:16 +0200
From: Pawel Witas <nased0@aster.pl>
MIME-Version: 1.0
To: public-linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@hugh.gmane.org
Subject: Re: Bluez-utils-3.36 hidd daemon does not compile on Suse 11 x64
Content-Type: text/plain; charset=ISO-8859-2
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



nased0 wrote:
> > Suse 11 64-bit distribution does not have a hidd daemon file included,
> > therefore its Bluetooth configurators only pretend to work.

I'd be interested in what you think is "only pretending to work". I
don't want
to rule out a packaging flaw on my side, but at least for me it is working
fine with HID devices and rfcomm/dialup.

> > I think that Suse 11 x64 distro developers were not able to
> > compile is also.

I strongly object to that suspicion  ;-)
It's not included on purpose, since it is obsoleted by input-service, as
Marcel already stated.

http://en.opensuse.org/Bluetooth might contain useful information to
help you
set up your devices.

Have fun,

	Stefan

I'm using Gnome, not KDE and Gnome configurator could not start my MS
Wireless Laser Mouse 8000.
I have a Compal JFL-92 laptop with integrated BT and Suse 11 x64.
I tried to configure my mouse manually according to some howto's found
on the web, but the final step was starting the hidd daemon.
When I compiled hidd (old version 2.25) and typed command:
 hidd --connect 00:17:FA:8A:BD:0B
and pressed a button at the bottom of my mouse
the mouse started to move my cursor.

I don't need anything more from BT, I can connect my Nokia phone by USB
cable with much less effort, but I hate wired mouses and USB radio mouse
 plugs, which I'd have to remove before transporting my laptop in my bag.

Just try to test Suse 11 x64 with Gnome on configuration similar to mine.
I propose to include hidd daemon in Suse 11, to allow to configure BT
manually (even if it is not needed by your configurators).

Regards

Pawel

