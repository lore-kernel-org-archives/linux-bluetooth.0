Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetooth sniff mode
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <A1F0D47583A2D711919F00600819B3A48BA128@goofy.vitronics.com>
References: <A1F0D47583A2D711919F00600819B3A48BA128@goofy.vitronics.com>
Content-Type: text/plain; charset=windows-1251
Message-Id: <1101929819.15615.28.camel@pegasus>
Mime-Version: 1.0
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
Date: Wed, 01 Dec 2004 20:36:59 +0100

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
> Should I reference the =93BLUETOOTH SPECIFICATION Version 2.0 + EDR=94
> instead?  I found version 2.0 at =93Bluetooth.org=94 web site.  AND the
> version 2.0 spec is slightly different.  For example the error codes
> listed in 2.0 are different. =20

The BlueZ versions have nothing to do with the version of the Bluetooth
specification.

> Maybe it is only semantics=85 either way I do not understand what eithe=
r
> really mean.  For the sniff mode I have setup a bnep connection.  I
> can ping =93host=94, I have static IPs setup.  And=20
>=20
> hcitool con
>=20
> Connections:
>=20
>         < ACL 00:02:72:41:2E:1D handle 1 state 1 lm MASTER
>=20
> =20
>=20
> Should this indicate =93SLAVE=94?  Somes times hcitool con will show SL=
AVE
> instead.  Your advice on what spec to use and how to decipher hictool
> output is appreciated.

The device that initiates the connection is the master until it switches
its role.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
