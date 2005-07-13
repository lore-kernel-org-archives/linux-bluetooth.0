Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42D4FD45.2030006@soft.uni-linz.ac.at>
From: Simon Vogl <vogl@soft.uni-linz.ac.at>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] zeevo module on uart
References: <42D2505A.6070206@soft.uni-linz.ac.at> <1121102289.5934.1.camel@notepaq>
In-Reply-To: <1121102289.5934.1.camel@notepaq>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
Date: Wed, 13 Jul 2005 13:38:45 +0200


the module works now, after some experimenting, the following two
lines do the trick:

         setserial /dev/ttyS1 baud_base 921600 divisor 1 spd_cust
         hciattach ttyS1 any 921600
interestingly, hciattach alone did not manage to start communicating, als=
o
not with the -s option (the zeevo firmware is configured to communicate a=
t
921600 bps).

Now all I need to do is port a decent 2.6 kernel...
Simon

Marcel Holtmann wrote:
> Hi Simon,
>=20
>=20
>>I am trying to talk to a Zeevo BT module (tc2001p chip on it) which is
>>attached to an xscale processor via serial.
>>When I start hciattach, I get an error message (and I cannot talk to th=
e
>>device later on):
>>
>>root@tinypxa263:~# hciattach ttyS1 any
>>h4_recv: Unknown HCI packet type f1
>>
>>The current kernel is 2.4.19-rmk7-pxa2 +local patches, bluez* 2.18
>>Is this a kernel issue or is something else in my setup wrong?
>=20
>=20
> the support for the 2.4 kernel series is limited as you now. So I can't
> provide you any details. However if the Zeevo module capable of working
> with H:4 and doesn't need any special initialization, then this can onl=
y
> mean the the serial port or baud rate settings are wrong.
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by the 'Do More With Dual!' webinar happ=
ening
> July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dua=
l
> core and dual graphics technology at this free one hour event hosted by=
 HP,=20
> AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=20
_______________________________________________________________________
Dr. Simon Vogl
ARC Seibersdorf research GmbH
Research Studios Austria, Studio Pervasive Computing Applications
Altenberger Stra=DFe 69, A-4040 Linz, Austria

Tel: +43 732 2468-8517, Fax: +43 732 2468-8426
mailto: simon.vogl@researchstudio.at



-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
