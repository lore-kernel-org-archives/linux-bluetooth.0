Return-Path: <EXT-Somil.Asthana@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [Bluez-users] Can you spoof/forge Bluetooth Devices/Address?
Date: Sun, 6 Jun 2004 20:26:28 -0400
Message-ID: <E320A8529CF07E4C967ECC2F380B0CF90140382A@bsebe001.americas.nokia.com>
From: <EXT-Somil.Asthana@nokia.com>
To: <marcel@holtmann.org>
Cc: <d.mackie@ru.ac.za>, <bluez-users@lists.sourceforge.net>
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel=20
  This is getting interesting looks like I am completing my Masters =
thesis & you are mentoring (or vice versa).=20
 You don't need a scatterent to connect two piconet. Two piconets =
(basically piconet devices) can be connected via an ethernet wire or =
WLAN AP. I have done that its not magic. After connecting we can create =
an IP infrastructure make every device IP addressable (that is where I =
said there can be some IP addressing problem and I am trying to solve & =
publish it anyway its no concern here). Now the question comes sending =
SDP records - to know what kind of service each piconet device provides =
etc ?? If we have an IP infrastructure then why nt use UPnP protocol we =
don't need BTH SDP protocol (I guess UPnP protocol provides more =
flexibility than SDP (I am nt an expert in UPnP)). But if you still want =
BTH SDP then send SDP records in IP packets (not good). (Make IP =
connections between devices to transfer data etc no need to make RFCOMM =
connections run thousands of legacy IP applications without modifying a =
single line of code, I am nt able to understand why people are pushing =
for RFCOMM etc but nt what we are discussing here).=20

regards
Somil
-----Original Message-----
From: bluez-users-admin@lists.sourceforge.net
[mailto:bluez-users-admin@lists.sourceforge.net]On Behalf Of ext Marcel
Holtmann
Sent: Sunday, June 06, 2004 7:56 PM
To: Asthana Somil (EXT-Nokia-NRC/Boston)
Cc: d.mackie@ru.ac.za; BlueZ Mailing List
Subject: RE: [Bluez-users] Can you spoof/forge Bluetooth
Devices/Address?


Hi Somil,

>   Why not use PAN profile instead of RFCOMM. We create an IP =
infrastructure (using Ethernet Bridging) route (or broadcast) packets =
between devices. If some BTH devices donot support PAN profile we can =
make devices attached to them as proxies. The adv of using PAN profile =
is that it can easily attached to IP back bone and this proj requires =
that (although it can result in some addressing issues). I am not sure =
if this is what David wants but you are correct there is no need to =
spoof addresses  or try getting the raw BTH packets etc.

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
