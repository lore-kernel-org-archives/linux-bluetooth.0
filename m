Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42D2637A.7030503@ibdcon.org.br>
From: Paulo Wollny <paulo.wollny@ibdcon.org.br>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] unable to open /dev/rfcomm0: No such device.
References: <BAY7-F138540399B59B859EA98DDD4DC0@phx.gbl>
In-Reply-To: <BAY7-F138540399B59B859EA98DDD4DC0@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Mon, 11 Jul 2005 09:18:02 -0300

mknod /dev/rfcomm0 c  216 0

I hope this helps.

Paulo Wollny

Fahad Khowaja wrote:
> Hello list members!
>=20
> I am using Bluez on an Axis Developer Board 82+ running kernel 2.4. I=20
> have everything running fine except when I try to issue "rfcomm bind" o=
r=20
> cat /dev/rfcomm0 or echo "foo" > /dev/rfcomm0 I get a "No such device"=20
> error. A cat of my /proc/devices produces:
>=20
> Character devices:
>  1 mem
>  2 pty
>  3 ttyp
>  4 ttyS
>  5 cua
> 10 misc
> 90 mtd
> 108 ppp
> 120 etrax gpio
> 121 ds1302
> 128 ptm
> 136 pts
> 162 raw
> 180 usb
>=20
> Block devices:
>  1 ramdisk
> 31 mtdblock
>=20
> It seems that the character device with major version 216 is not=20
> recognized by the kernel. Which driver is used for these devices? Which=
=20
> options should I enable in the kernel for it to be included in the=20
> kernel (I don't have module support on the axis board)? It will be an=20
> immense help if someone can give me some pointers!
>=20
> Gratefully yours,
> Fahad.
>=20
> _________________________________________________________________
> Take advantage of powerful junk e-mail filters built on patented=20
> Microsoft=AE SmartScreen Technology.=20
> http://join.msn.com/?pgmarket=3Den-ca&page=3Dbyoa/prem&xAPID=3D1994&DI=3D=
1034&SU=3Dhttp://hotmail.com/enca&HL=3DMarket_MSNIS_Taglines=20
>  Start enjoying all the benefits of MSN=AE Premium right now and get th=
e=20
> first two months FREE*.
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by the 'Do More With Dual!' webinar=20
> happening
> July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dua=
l
> core and dual graphics technology at this free one hour event hosted by=
=20
> HP, AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebina=
r
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>=20
>=20


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
