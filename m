Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bluez-users] bluetooth sniff mode
Message-ID: <A1F0D47583A2D711919F00600819B3A46B78C1@goofy.vitronics.com>
From: "Cruz, Maria" <maria.cruz@VITRONICS.com>
To: <bluez-users@lists.sourceforge.net>
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
Date: Wed, 1 Dec 2004 16:42:45 -0500

Thanks Marcel.  I found out that after a "sniff mode" command the HCI
Event : Mode Change occurs.  I found reference to this in both specs.
This event shows a "current_mode" field.  If it is set to "0x02" then in
sniff mode.

Running hcidump -x captures this event.

Thanks
maria

-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org]=20
Sent: Wednesday, December 01, 2004 2:37 PM
To: BlueZ Mailing List
Subject: Re: [Bluez-users] bluetooth sniff mode

Hi Maria,

> Here is the output from my command:
>=20
> # hcitool cmd 0x02 0x0003 0x01 0x00 0x00 0x05 0x00 0x01 0x06 0x00 0x10
> 0x00
>=20
> < HCI Command: ogf 0x02, ocf 0x0003, plen 10
>=20
>   01 00 00 05 00 01 06 00 10 00
>=20
> > HCI Event: 0x0f plen 4
>=20
>   00 01 03 08

run "hcidump -X" as root at the same time and see what it produces.

> Not sure if this indicates a success (or just pending not sure yet of
> success).  Additionally, I am using bluez-libs&bluez-utils2.10.
> Should I reference the "BLUETOOTH SPECIFICATION Version 2.0 + EDR"
> instead?  I found version 2.0 at "Bluetooth.org" web site.  AND the
> version 2.0 spec is slightly different.  For example the error codes
> listed in 2.0 are different. =20

The BlueZ versions have nothing to do with the version of the Bluetooth
specification.

> Maybe it is only semantics... either way I do not understand what
either
> really mean.  For the sniff mode I have setup a bnep connection.  I
> can ping "host", I have static IPs setup.  And=20
>=20
> hcitool con
>=20
> Connections:
>=20
>         < ACL 00:02:72:41:2E:1D handle 1 state 1 lm MASTER
>=20
> =20
>=20
> Should this indicate "SLAVE"?  Somes times hcitool con will show SLAVE
> instead.  Your advice on what spec to use and how to decipher hictool
> output is appreciated.

The device that initiates the connection is the master until it switches
its role.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.=20
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
