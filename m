Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Development of a Bluetooth-LAN-Accesspoint
From: Marcel Holtmann <marcel@holtmann.org>
To: Boris =?ISO-8859-1?Q?W=FCst?= <Boris.Wuest@HdM-Stuttgart.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <00a101c4c029$2c66e730$2301a8c0@boris>
References: <00a101c4c029$2c66e730$2301a8c0@boris>
Content-Type: text/plain
Message-Id: <1099325174.16247.144.camel@pegasus>
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
Date: Mon, 01 Nov 2004 17:06:14 +0100

Hi Boris,

> still i have more a logical than a technical problem. i hope someone
> can help:
> 
> we (my projectteam) want to develop an bluetooth-lan-accesspoint based
> on the BlueTarget-Controller from SND (perhaps someone knows the
> controller) for our university. i have thought about to use the
> rfcomm-layer to handle the connections and the low level data
> transfer. on top of the rfcomm-connections i want to set up an normal
> ppp-connection. speaks something against this concept? have anyone a
> better solution?

yes, because "LAN access using PPP" is a deprecated profile. Use the PAN
profile instead.

> now to the problem(s):
> 
> (1) we want to design an accesspoint that connects automatically to
> all bt-devices that are located in its range, so that a lan-access
> supported immediately and it's guaranteed that the bt-accesspoint is
> the master at all communications? how can we implement an automatic
> connection establishment on the rfcomm-layer and how we can make sure
> that the bt-accesspoint is always master that parks and activates the
> devices automatically depended on the data transfer(so that can be
> more devices than 7 connected to the lan)? what do we have to consider
> with the authentication? can we avoid it or switch it off at both
> sides of connection? when the connections established how we can
> manage them and the different channels to the connections?

The master point does not count, because you can switch the roles at any
time. What I don't understand is why the access point should initiate
the connection. What kind of clients do you wanna support?

> (2) when we use a ppp-connection from bt-devices to the accesspoint,
> every device needs an ip and the accesspoint as gateway. how can we
> realize the assignment of the ip-adresses an the gateway to the
> bt-devices controlled by the accesspoint? the major problem at this
> concept is that the BlueTarget-Controller is a pure microcontroller an
> provides a own bt-stack. so on it can't be run services how pppd or
> pand. but the controller as an lan-interface and must therefor
> understand tcp/ip. how we can emulate a ppp-connection with a
> bt-stack(bluez) avoiding high expense of development? are there some
> documentations and/or program examples about this topic?? have anyone
> implemented something compareable??

I don't understand that. Explain what the BlueTarget controller is and
what it is doing actually.

> (3)the last problem is the connection speed. we have set up an test
> environment composed of a PDA and a linuxsystem with the bluez-stack
> and a bt-usb-donlge. we have only achieved max. 16KB/s at the best
> bt-connection qualtity, only one bt-connection and ACL. why can't we
> achieve approximately the max. speed (95KB/s) of the connection? how
> does it look with serveral connections? share all connections these
> 16KB/s? how we can advance the connection-speed? is one possibility to
> use more than one rfcomm-connection (more than one channel) for a
> ppp-connection? have anyone a solution?

The Bluetooth bandwith is shared within the complete piconet and so more
RFCOMM channels won't help. However the 16 KB/s must be a problem of
your PDA, because you will get around 60-70 KB/s depending on your
payload of the data.

> i hope you guys can help me with these problems. perhaps also by
> documentations of previous projects or links to the web. when someone
> of you have a lot of experience in the development in this direction,
> i would be grateful when you lend yourself as permanent contact
> person. thanks to everyone who helps ;D

Feel free to ask on the mailing list, but lending a developer costs
money ;)

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
