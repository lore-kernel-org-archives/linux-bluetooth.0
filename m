Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4237820F.2000006@debiancolombia.org>
From: "Fredy P." <digitalfredy@debiancolombia.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] problems establishing connection to Cellular
	phone
References: <1110766661.9456.4.camel@tux>
In-Reply-To: <1110766661.9456.4.camel@tux>
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed
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
Date: Tue, 15 Mar 2005 19:47:11 -0500

Tamer Higazi escribi=F3:
> Hi people!=20
> How do I make a stable connection to my cellular phone via bluetooth
> without that the connection is dying.=20
>=20
>=20
> I make:=20
> hcitool cc MAC-ADDRESS=20
> hcitool auth MAC-ADDRESS=20
>=20
> then I enter the pin on the mobile phone and I receive the answer:=20
>=20
> HCI authentication request failed: Input/output error
>=20
>=20
> Can somebody help me?=20
>=20
> However I get this bluez-pin installed. In which relation does it belon=
g
> to my problem? And if yes, how do I use it?=20
>=20
>=20
> For any help, thank you
>=20
>=20
> Tamer
>=20
>=20
compare your /etc/bluetooth/hci.conf whit it:

options {
         autoinit yes;

         security auto;

         pairing multi;

         pin_helper /usr/bin/bluez-pin;

}

device {
         name "%h-%d";

         class 0x100;


         iscan enable;
         pscan enable;

         lm accept;    #################for can add pc in movil from movi=
l

         lp rswitch,hold,sniff,park;
         # Authentication and Encryption
         #auth enable;
         #encrypt enable;           ######################disable encrypt=
ion


}

>=20
>=20
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users=
.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>=20


--=20
Suerte and F.S.Fv.

ATT: Fredy P.
___________________________________________________
F.S.Fv. es acr=F3nimo de Free Software Forever
http://www.fsf.org/philosophy/free-sw.es.html

Normas b=E1sicas de comportamiento en el ciberespacio
http://www.netiqueta.org/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
