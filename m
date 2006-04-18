Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [Bluez-users] Testmode
Message-ID: <70DCB28C5BB04A4BBB1C8512589BAC65AF0BC1@mail006.mail.lan>
From: "Brand, Chris" <chris.brand@wideray.com>
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
Date: Tue, 18 Apr 2006 12:08:59 -0400

You can give the device an "Enter Device Under Test Mode" HCI command =
using bccmd. Something like "bccmd cmd 0x06 0x03" should do it.

Chris=20

> -----Original Message-----
> From: bluez-users-admin@lists.sourceforge.net=20
> [mailto:bluez-users-admin@lists.sourceforge.net] On Behalf Of=20
> Christian Kl=FCnder
> Sent: Monday, April 17, 2006 11:17 PM
> To: bluez-users@lists.sourceforge.net
> Subject: [Bluez-users] Testmode
>=20
> Hello Bluez-Group,
>=20
> as I am working on testing of Bluetooth devices, I am trying=20
> to activate the Test Mode of these devices described by the=20
> general specification of bluetooth. Does anyone have some=20
> experiences with this Test Mode and can give me some hints to=20
> activate it by using the bluez stack?
>=20
> Thanks in advance
>=20
> Christian
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking=20
> scripting language that extends applications into web and=20
> mobile media. Attend the live webcast and join the prime=20
> developer group breaking into this new coding territory!
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D110944&bid=3D241720&
> dat=3D121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>=20


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
