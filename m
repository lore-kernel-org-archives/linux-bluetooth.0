Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hcid hotplug initialisation?
From: Marcel Holtmann <marcel@holtmann.org>
To: Fredrik Noring <noring@nocrew.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076330114.5263.85.camel@kalkyl.roxen.com>
References: <1076323204.5263.34.camel@kalkyl.roxen.com>
	 <1076323641.6869.98.camel@pegasus>
	 <1076324203.5263.47.camel@kalkyl.roxen.com>
	 <1076325635.6869.128.camel@pegasus>
	 <1076330114.5263.85.camel@kalkyl.roxen.com>
Content-Type: text/plain
Message-Id: <1076331044.6869.152.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 09 Feb 2004 13:50:44 +0100

Hi Fredrik,

> > but you expect that the user has installed the Bluetooth specific
> > software? 
> 
> Yes, it could be installed by default. A few megs of harddisk space 
> is hardly an issue compared with having a handful of strange daemons
> (hcid, stpd etc.) always running no matter if any Bluetooth devices
> are actually available or not, is it?

the daemons are idle if no device is attached. So who cares? If they are
installed and should not be started, we can use /etc/default/bluetooth
for these kind of settings.

> > If the software is installed we start all needed parts of the
> > Bluetooth subsystem. If they don't want them they shouldn't install
> > their software.
> 
> Starting these services on demand is more efficient and simpler for
> the user. Perhaps 1 % of all users will try to use the Bluetooth stuff.

If they don't use Bluetooth, they don't even install it and so no
problem. However it is _not_ efficient to start a whole subsystem with
all its daemons from a hotplug script. Everyone who likes this approch
can do it of course, but I will never accept this as default.

> > To make everything work perfect on the first use of a Bluetooth dongle
> > is not the job of the Bluetooth subsystem. If the USB or PCMCIA subsytem
> > detects a Bluetooth device it has to install, start or run whatever
> > other action is needed to make it work.
> 
> This would require that hcid is compatible with that approach. That's
> the issue here. :)

No. This requires that the USB and PCMCIA subsystem knows what devices
are Bluetooth devices. If not installed they have to install the BlueZ
packages that are needed and then they have to run the init script.

> > If hcid is not running, because no device is attached. How would you
> > manage you pairings through D-Bus for example? For some stuff an
> > attached device is not needed.
> 
> The hotplug may not be the only way to start hcid. Other services
> may require it to start too, of course.

Two places where we have to start a daemon? Too complex. Start it at
init.

> > If you think the long way then after hcid comes sdpd. This daemon must
> > be started first, before any PAN service can be started.
> 
> This kind of dependency needs to be tracked too.

I don't wanna track this down. Start hcid and sdpd and then everything
else you want. Starting them from init is the best way.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
