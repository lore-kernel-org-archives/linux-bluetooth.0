Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-devel] hcid hotplug initialisation?
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076325635.6869.128.camel@pegasus>
References: <1076323204.5263.34.camel@kalkyl.roxen.com>
	 <1076323641.6869.98.camel@pegasus>
	 <1076324203.5263.47.camel@kalkyl.roxen.com>
	 <1076325635.6869.128.camel@pegasus>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1076330114.5263.85.camel@kalkyl.roxen.com>
Mime-Version: 1.0
Date: Mon, 09 Feb 2004 13:35:14 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

mån 2004-02-09 klockan 12.20 skrev Marcel Holtmann:
> but you expect that the user has installed the Bluetooth specific
> software? 

Yes, it could be installed by default. A few megs of harddisk space 
is hardly an issue compared with having a handful of strange daemons
(hcid, stpd etc.) always running no matter if any Bluetooth devices
are actually available or not, is it?

> If the software is installed we start all needed parts of the
> Bluetooth subsystem. If they don't want them they shouldn't install
> their software.

Starting these services on demand is more efficient and simpler for
the user. Perhaps 1 % of all users will try to use the Bluetooth stuff.

> To make everything work perfect on the first use of a Bluetooth dongle
> is not the job of the Bluetooth subsystem. If the USB or PCMCIA subsytem
> detects a Bluetooth device it has to install, start or run whatever
> other action is needed to make it work.

This would require that hcid is compatible with that approach. That's
the issue here. :)

> If hcid is not running, because no device is attached. How would you
> manage you pairings through D-Bus for example? For some stuff an
> attached device is not needed.

The hotplug may not be the only way to start hcid. Other services
may require it to start too, of course.

> If you think the long way then after hcid comes sdpd. This daemon must
> be started first, before any PAN service can be started.

This kind of dependency needs to be tracked too.

Fredrik
