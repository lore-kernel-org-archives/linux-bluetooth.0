Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] PC can't receive files from SE K750i
From: Fredy P <digitalfredy@debiancolombia.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <363732598@web.de>
References: <363732598@web.de>
Content-Type: text/plain;
	charset=iso-8859-1
Message-Id: <1127829535.3737.8.camel@localhost.localdomain>
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
Date: Tue, 27 Sep 2005 08:58:55 -0500

El lun, 26-09-2005 a las 10:18 +0200, dominic.werner@email.de escribi=F3:
> Hi there,
>=20
> i've got an ACER bluetooth-dongle and a Sony Ericsson K750i mobilephone.
> All things i write, i've tried with Debian.
>=20
> 1. I startet the dongle with "hciconfig hci up"
>=20
> 2. I search my phone with "hcitool search" --> I found it
>=20
> 3. I used "sdptool browse (MAC of the phone)" to get the OBEX push channe=
l. --> channel is 5
>=20
> 4. "sdptool add --channel=3D5 OPUSH"
>=20
> 5. I started "obexserver"
>=20
> now the PC is waiting for incoming files
>=20
> the first problem: my mobile phone doesn't find my PC
> problem fixed: I changed the line "0x100;" in "/etc/bluetooth/hci.conf" t=
o "0x100100;" i read in an Ubuntu-forum.=20
> no my phone finds the PC
>=20
> but the 2nd problem:
> when I try to send an image to my PC an error appears "connection refused=
"
>=20
> who can help?
for recibe files from my t610 I use opd [1], if you can made this whit
obexserver writeme howto pease.
more info about send and recibe files betwen movile sonyericsson and
debian in [2] (read the config files and comands) and info for bluez
config in [3]

the line is:
# opd  --mode OBEX --path /where/put --channel 10 --sdp

[1]http://oss.bdit.de/opd.html
[2]http://el-directorio.org/index.php/T610:Transferencia_de_Archivos#Recibi=
r_archivos_desde_el_telefono
[3]http://el-directorio.org/index.php/Bluetooth_en_debian

>=20
> thanks!
>=20
> greetings Dominic
>=20
> p.s.: sorry about my bad english
fine you are'n the unic
>=20
>=20
> -------------------------------------------------------
> SF.Net email is sponsored by:
> Tame your development challenges with Apache's Geronimo App Server.=20
> Download it for free - -and be entered to win a 42" plasma tv or your ver=
y
> own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
