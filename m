Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hcid hotplug initialisation?
From: Marcel Holtmann <marcel@holtmann.org>
To: Fredrik Noring <noring@nocrew.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076324203.5263.47.camel@kalkyl.roxen.com>
References: <1076323204.5263.34.camel@kalkyl.roxen.com>
	 <1076323641.6869.98.camel@pegasus>
	 <1076324203.5263.47.camel@kalkyl.roxen.com>
Content-Type: text/plain
Message-Id: <1076325635.6869.128.camel@pegasus>
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
Date: Mon, 09 Feb 2004 12:20:35 +0100

Hi Fredrik,

> > no. The bluetooth.agent is only for device specific configuration and
> > not for starting a deamon. However hcid watches all interfaces and
> > bluetooth.agent would be called for every device. 
> 
> Having hcid actively running on a system that never will use a 
> Bluetooth device is waste of resources. But when a user inserts 
> a Bluetooth device, it would be excellent to have it all work
> automtically. What do you suggest then?

but you expect that the user has installed the Bluetooth specific
software? If the software is installed we start all needed parts of the
Bluetooth subsystem. If they don't want them they shouldn't install
their software.

To make everything work perfect on the first use of a Bluetooth dongle
is not the job of the Bluetooth subsystem. If the USB or PCMCIA subsytem
detects a Bluetooth device it has to install, start or run whatever
other action is needed to make it work.

> > Multiple running hcid's will mess up the security manager.
> 
> Yes, but only one hcid instance would run. The hotplug script and/or
> hcid can check this.

If hcid is not running, because no device is attached. How would you
manage you pairings through D-Bus for example? For some stuff an
attached device is not needed.

If you think the long way then after hcid comes sdpd. This daemon must
be started first, before any PAN service can be started. Starting all
daemons from bluetooth.agent is stupid, because none of them actually
are bound to a specific device. And people also reported that starting
daemons from bluetooth.agent causes troubles.

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
