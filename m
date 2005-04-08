Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] connect T610 to PC problem
From: Fredy P <digitalfredy@debiancolombia.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050323011147.34760.qmail@web60904.mail.yahoo.com>
References: <20050323011147.34760.qmail@web60904.mail.yahoo.com>
Content-Type: text/plain;
	charset=UTF-8
Message-Id: <1112962996.6524.21.camel@localhost.localdomain>
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
Date: Fri, 08 Apr 2005 07:23:16 -0500

El mi=C3=A9, 23-03-2005 a las 09:11 +0800, Ka Kin Cheung escribi=C3=B3:
> Hi Fredy!
Hi , sorry the dealy, y have some problems whit my mail
>=20
> >Ka Kin Cheung escribio':
> >> Hi all!
> >> I can connect T610 from PC successfully! The key
> >> point is: you have to set the same channel of SDP and
> >> rfcomm, and set the class in hciconfig as 0x200404
> >> i.e. headset. Then after typing "rfcomm listen 0
> >> ", the phone can connect to Pc successfully.
> >> But then, I face a new problem. When I put the socket
> >> programming part in my main program, after I
> >> successfully connect T610 to the PC, it showed
> >> "dev/rfcomm0: no such device". Why is that?
> >> Then I looked at rfcomm/main.c, and put the
> >> cmd_listen part in my main program, but after that,
> >> when I tried to connect T610 to PC, the T610 always
> >> showed "Bluetooth connection failed". Why is that?
> >It is becouse you have a lm master, i only have :
>=20
> >lm accept;
> But I checked /etc/bluetooth/hcid.conf, and I just f ound lm acept.
> Then I changed the line into lm accept, master, and then reboot PC,
> but the problem still exists.
>=20
> >and y can add the pc to movil from movil
> What do you mean about this sentence?
Sorry my bad english, i'm spanish speaker, a example for understand:
In the phone:
Connect -> bluethooth -> My Devices    //remove your pc
Connect -> bluethooth -> My Devices -> add your pc //if can't see **

if Bluetooth connection failed put only lm accept;=20

> =20
> Thank you very much.
> Michael
>=20
>=20
>=20
> ______________________________________________________________________
> Yahoo! =E5=B7=A5=E5=85=B7=E5=88=97 - =E5=85=A7=E7=BD=AE=E9=98=B2=E6=AD=A2=
=E5=BD=88=E5=87=BA=E8=A6=96=E7=AA=97=E5=B7=A5=E8=83=BD=EF=BC=81



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
