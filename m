Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Problem With the Inquiry and RFCOMM conexions
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <00f101c646a8$b02e9250$0300a8c0@akira>
References: <006b01c64683$e75b2c90$0300a8c0@akira>
	 <1142256728.4622.1.camel@aeonflux.holtmann.net>
	 <00f101c646a8$b02e9250$0300a8c0@akira>
Content-Type: text/plain; charset=utf-8
Message-Id: <1142600284.4392.25.camel@localhost>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 17 Mar 2006 13:58:04 +0100

Hi,

> "limitation of the hardware"..?   I use modules BT 2.0 for this ....
>=20
> Info of hciconfig hci0 version:
>=20
> hci0:   Type: UART
>         BD Address: 00:07:80:XX:XX:XX ACL MTU: 384:8 SCO MTU: 64:8
>         HCI Ver: 2.0 (0x3) HCI Rev: 0xa42 LMP Ver: 2.0 (0x3) LMP Subver=
:=20
> 0xa42
>         Manufacturer: Cambridge Silicon Radio (10)
>=20
>=20
> The inquiry and the RFCOMM in blueZ have diferent handles. I understand=
 the=20
> calls hci to module don=C2=B4t mixed ....

it is still the same hardware. The number of handles doesn't matter.

> Why if I send data over RFCOMM channels the inquiry don=C2=B4t find any=
 device?
> I don=C2=B4t send any data, mantaint the conexion, the inquiry works wi=
th any=20
> problem.... =C2=BF=C2=BF???

I can't answer this. You might get lucky and get an answer for the CSR
experts.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
