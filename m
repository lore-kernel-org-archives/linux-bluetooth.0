Return-Path: <EXT-Somil.Asthana@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [Bluez-users] Can you spoof/forge Bluetooth Devices/Address?
Date: Sun, 6 Jun 2004 19:24:03 -0400
Message-ID: <E320A8529CF07E4C967ECC2F380B0CF901403829@bsebe001.americas.nokia.com>
From: <EXT-Somil.Asthana@nokia.com>
To: <marcel@holtmann.org>, <d.mackie@ru.ac.za>
Cc: <bluez-users@lists.sourceforge.net>
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,=20
  Why not use PAN profile instead of RFCOMM. We create an IP =
infrastructure (using Ethernet Bridging) route (or broadcast) packets =
between devices. If some BTH devices donot support PAN profile we can =
make devices attached to them as proxies. The adv of using PAN profile =
is that it can easily attached to IP back bone and this proj requires =
that (although it can result in some addressing issues). I am not sure =
if this is what David wants but you are correct there is no need to =
spoof addresses  or try getting the raw BTH packets etc.

regards
Somil
-----Original Message-----
From: bluez-users-admin@lists.sourceforge.net
[mailto:bluez-users-admin@lists.sourceforge.net]On Behalf Of ext Marcel
Holtmann
Sent: Sunday, June 06, 2004 5:11 PM
To: David Mackie
Cc: BlueZ Mailing List
Subject: Re: [Bluez-users] Can you spoof/forge Bluetooth
Devices/Address?


Hi David,

> Does anyone know if you are able to spoof or forge a Bluetooth Device
> Address? I am wanting to pick up Bluetooth comms at one point and =
forward it
> on to another device but I am wanting the repeating devices to act =
like the
> original sending devices. Eg. If I have a phone that wants to =
communicate
> with my PC, I can have 2 repeaters, one spoofed as the PC and one as =
the
> phone.
>=20
> phone <-BT-> Repeater(spoof PC) <-Not BT-> Repeater(spoof phone) =
<-BT-> PC
>=20
> More information on why I want to do this can be found at
> http://www.cs.ru.ac.za/research/students/g99m0302/masters/
>=20
> Any comment of suggestions will be greatly appreciated

I made a quick look through your documents. Spoofing of a BD_ADDR's is
not what you really want and of course it is also not possible. You
should think more of service forwarding. This means tunneling of the
complete L2CAP layer or dedicated SDP service records/RFCOMM channel
tunneling.

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
