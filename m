Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: RE: [Bluez-users] Can you spoof/forge Bluetooth Devices/Address?
From: Marcel Holtmann <marcel@holtmann.org>
To: EXT-Somil.Asthana@nokia.com
Cc: d.mackie@ru.ac.za, BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <E320A8529CF07E4C967ECC2F380B0CF901403829@bsebe001.americas.nokia.com>
References: 
	 <E320A8529CF07E4C967ECC2F380B0CF901403829@bsebe001.americas.nokia.com>
Content-Type: text/plain
Message-Id: <1086566140.9204.4.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 07 Jun 2004 01:55:40 +0200

Hi Somil,

>   Why not use PAN profile instead of RFCOMM. We create an IP infrastructure (using Ethernet Bridging) route (or broadcast) packets between devices. If some BTH devices donot support PAN profile we can make devices attached to them as proxies. The adv of using PAN profile is that it can easily attached to IP back bone and this proj requires that (although it can result in some addressing issues). I am not sure if this is what David wants but you are correct there is no need to spoof addresses  or try getting the raw BTH packets etc.

I haven't read his documents in detail, but as I understand it he want's
to connect from a PC in one piconet to a mobile phone in another
piconet. These piconets are connected through an IP backbone and not via
a scatternet. So he must make the SPD records of the phone visible in
both piconets and if needed route a L2CAP or RFCOMM connection between
them. However it is his master thesis and not mine.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
