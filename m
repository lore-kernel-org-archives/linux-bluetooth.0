Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <12a241ad050720061433fe85f8@mail.gmail.com>
From: Bruno Abinader <brunoabinader@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Permission problems, Bluetooth Headset
In-Reply-To: <42DE3EAA.30705@toughguy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <42DE3EAA.30705@toughguy.net>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 20 Jul 2005 09:14:58 -0400

Hi Benderius, try this:

Change the line in hcid.conf where it is:

> lm accept;

And change it to:

> lm accept,master;

2005/7/20, Ola Benderius <radaway@toughguy.net>:
> Hi,
> got a problem when trying to connect my Bluetooth headset (it's a
> Plantronics 2500) with Linux.
>=20
> I'm using Gentoo Linux so I followed the guide in this thread when
> pairing the device to the computer:
> http://forums.gentoo.org/viewtopic-t-194183.html
>=20
> I follow this guide and this is my hcid.conf:
>=20
> /    #
>     # HCI daemon configuration file.
>     #
>     # $Id: hcid.conf,v 1.7 2004/12/13 14:16:03 holtmann Exp $
>     #
>=20
>     # HCId options
>     options {
>             # Automatically initialize new devices
>             autoinit yes;
>=20
>             # Security Manager mode
>             #   none - Security manager disabled
>             #   auto - Use local PIN for incoming connections
>             #   user - Always ask user for a PIN
>             #
>             security auto;
>=20
>             # Pairing mode
>             #   none  - Pairing disabled
>             #   multi - Allow pairing with already paired devices
>             #   once  - Pair once and deny successive attempts
>             pairing multi;
>=20
>             # PIN helper
>             # pin_helper /usr/bin/bluepin;
>             pin_helper /etc/bluetooth/pin-helper;
>=20
>             # D-Bus PIN helper
>             #dbus_pin_helper;
>     }
>=20
>     # Default settings for HCI devices
>     device {
>             # Local device name
>             #   %d - device id
>             #   %h - host name
>             name "BlueZ at %h (%d)";
>=20
>             # Local device class
>             class 0x3e0100;
>=20
>             # Default packet type
>             #pkt_type DH1,DM1,HV1;
>=20
>             # Inquiry and Page scan
>             iscan enable; pscan enable;
>=20
>             # Default link mode
>             #   none   - no specific policy
>             #   accept - always accept incoming connections
>             #   master - become master on incoming connections,
>             #            deny role switch on outgoing connections
>             lm accept;
>=20
>             # Default link policy
>             #   none    - no specific policy
>             #   rswitch - allow role switch
>             #   hold    - allow hold mode
>             #   sniff   - allow sniff mode
>             #   park    - allow park mode
>             lp   rswitch,hold,sniff,park;
>=20
>             # Authentication and Encryption (Security Mode 3)
>             auth enable;
>             encrypt enable;
>     }/
>=20
> But the PIN is set to '0000' since that the PIN of the headset.
> (according to the manual)
>=20
> /    echo "0000" > /etc/bluetooth/pin/
>=20
> With 'hcitool scan' I get:
>=20
> /    Scanning ...
>         00:03:89:B7:E5:F7       M2500 by Plantronics/
>=20
>=20
> And with 'hcitool inq' I get:
>=20
> /    Inquiring ...
>         00:03:89:B7:E5:F7       clock offset: 0x623f    class: 0x200404/
>=20
>=20
> So far so good. But now I get problems.
>=20
> 'l2ping 00:03:89:B7:E5:F7' returns this:
>=20
>  /   Can't connect: Permission denied/
>=20
> 8O
>=20
>=20
> That ain't too good. I saved a hcidump for the l2ping and here it comes:
>=20
> /    < HCI Command: Create Connection (0x01|0x0005) plen 13
>     > HCI Event: Command Status (0x0f) plen 4
>     > HCI Event: Link Key Request (0x17) plen 6
>     < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
>     > HCI Event: Command Complete (0x0e) plen 10
>     > HCI Event: Connect Complete (0x03) plen 11/
>=20
>=20
> Another thing I noticed was this. In the guide the 'hciconfig -a'
> command returned the following output:
>=20
> /    hci0:   Type: USB
>             BD Address: 00:10:60:A3:CB:41 ACL MTU: 192:8 SCO MTU: 64:8
>             UP RUNNING PSCAN ISCAN AUTH ENCRYPT
>             RX bytes:125 acl:0 sco:0 events:17 errors:0
>             TX bytes:565 acl:0 sco:0 commands:17 errors:0
>             Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>             Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>             Link policy: RSWITCH HOLD SNIFF PARK
>             Link mode: SLAVE ACCEPT
>             Name: 'BlueZ at bluehat (0)'
>             Class: 0x3e0100
>             Service Classes: Networking, Rendering, Capturing, Object
> Transfer, Audio
>             Device Class: Computer, Uncategorized
>             HCI Ver: 1.1 (0x1) HCI Rev: 0x1e7 LMP Ver: 1.1 (0x1) LMP
> Subver: 0x1e7
>             Manufacturer: Cambridge Silicon Radio (10)/
>=20
>=20
> Mine returned this:
>=20
> /    hci0:   Type: USB
>             BD Address: 00:0A:3A:51:BF:D7 ACL MTU: 192:8 SCO MTU: 64:8
>             UP RUNNING AUTH ENCRYPT
>             RX bytes:9060 acl:271 sco:0 events:332 errors:0
>             TX bytes:5093 acl:235 sco:0 commands:51 errors:0
>             Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>             Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>             Link policy: RSWITCH HOLD SNIFF PARK
>             Link mode: SLAVE ACCEPT
>             Name: 'BlueZ at turtlepond (0)'
>             Class: 0x3e0100
>             Service Classes: Networking, Rendering, Capturing
>             Device Class: Computer, Uncategorized
>             HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP
> Subver: 0x20d
>             Manufacturer: Cambridge Silicon Radio (10)/
>=20
>=20
> There are some differences here. I'm thinking about PSCAN ISCAN and the
> service classes (mainly 'audio' since I got a headset). First I thought
> there was problems reading the hcid.conf file. But then I noticed that
> the 'Name' output was the one I set in that file. But still, might this
> be a problem?
>=20
>=20
> This problem is really annoying and I would be happy if I got some help!
> Not even google can save me here...
>=20
>=20
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclic=
k
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>=20


--=20
Bruno de Oliveira Abinader
10LE/INdT - GVoIP/UFAM


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
