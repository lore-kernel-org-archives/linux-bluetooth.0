Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Esther Lopez" <esther.lopez@erzia.com>
To: <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] Re: BlueZ, Linux and Windows
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <loom.20050624T164608-144@post.gmane.org>
Message-Id: <20050627080102.85B8E1EA336@mrelay1.st2.lyceu.net>
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
Date: Mon, 27 Jun 2005 10:01:35 +0200

Hi Andreas

I have review all information in Bluez home page and the one provided by
you. Most of it is outdated... I haven't managed to get it into work. I
think I'm missing some basic step... Let me explain you what I have =
done...
- Install Fedora 4 (gnome-bluetooth, gnome-bluetooth-libs, =
bluez-hcidump,
bluez-pin, bluez-utils, bluez-libs included)
- hciconfig hci0 up
- hciconfig (shows the device up and running)
- hitool scan
- mknod /dev/rfcomm0 c 216 0
- sdptool browse <addr>
- modify /etc/Bluetooth/rfcomm.conf
	Rfcomm0 { 	bind yes;
			device <addr>;
			channel 1;
			comment "FC4-BT";
		  }
- Create file: /etc/bluetooth/mypin;
	#!bin /bash
	echo "PIN:1111"
- In /etc/Bluetooth/hcid.conf
	pin_helper /etc/Bluetooth/my-pin

- hcid -f /etc/Bluetooth/hcid.conf (to reload file)
- rfcomm connect /dev/rfcomm0 <addr> 1

At this point, my windows PC shows a message requesting the PIN, I type =
1111
but the FC4 box shows: "can't connect to RFCOMM message"

Thanks in advance for your help.

Regards

-----Mensaje original-----
De: bluez-users-admin@lists.sourceforge.net
[mailto:bluez-users-admin@lists.sourceforge.net] En nombre de andreas =
knuth
Enviado el: viernes, 24 de junio de 2005 17:03
Para: bluez-users@lists.sourceforge.net
Asunto: [Bluez-users] Re: BlueZ, Linux and Windows

Esther Lopez <esther.lopez <at> erzia.com> writes:

>=20
>=20
>=20
> Hello you all
>=20
> I=92m quite new at Linux and BlueZ, and I=92m having lots of
> problems to get it into work. I have a Linux PC (Fedora 4), a Windws =
XP
PC,=20
and
> a Ericsson T630 mobile phone.
>=20
> I have also, a TDK Bluetooth USB adapter, and a conceptronic one, both
> found in the BlueZ supported hardware.
>=20
> =A0
>=20
> Using the Fedora 4 PC, I have managed to discover the winPC and the
> mobile, but when I try to connect to them an error is displayed =
(cannot
attach
> specified device). I also tried to pair the phone with the Linux PC, =
but
an
> error is displayed in the mobile. When I start the pairing from the =
Win
PC,=20
the
> Linux one get=92s blocked.
>=20
> =A0
>=20
> An application called =93Bluetooth manager=94 seems also not to
> work. Nothing happens when I try to use it=85
>=20
> =A0
>=20
> I need some help, on basic issues. Perhaps some =93blueZ for
> dummies=94 manual ;)
>=20
> I hope somebody can help me.
>=20

As one source you could study the information provided by the following =
link


http://www.holtmann.org/linux/bluetooth/

special remark: the phones expect normally a running service on the =
other
side=20
depending from which menu point in the phone you try to connect to the =
other

side.







-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. =
http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclick
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
