Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: Re: Re: Re: Buetooth and SAMSUNG SGH-E340
From: Fredy Pulido =?ISO-8859-1?Q?L=F3pez?= <digitalfredy@debiancolombia.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20051109161839.GG21921@loulou-becane>
References: <20051020135234.GC28731@loulou-becane>
	<20051023123808.GA14322@elmicha.333200002251-0001.dialin.t-online.de>
	<20051023151215.GB31746@loulou-becane>
	<1130191981.9463.13.camel@localhost.localdomain>
	<20051025163115.GA29385@loulou-becane>
	<1130342970.8178.5.camel@localhost.localdomain>
	<20051026195956.GH7782@loulou-becane>
	<1131007931.2415.2.camel@yoda.digitalfredy.org>
	<20051109161839.GG21921@loulou-becane>
Content-Type: text/plain;
	charset=iso-8859-1
Message-Id: <1131668163.6367.15.camel@yoda.digitalfredy.org>
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
Date: Thu, 10 Nov 2005 19:16:03 -0500

El mi=E9, 09-11-2005 a las 17:18 +0100, Philippe Berini escribi=F3:
Try it:
1)see your movile services (use your phone MAC) - are chanel 7 OBEX File
Transfer?
$ sdptool  browse AA:0A:D9:78:ED:AA=20
2) remove the pc in your movil btdevices
3) restart bluez -if get error send my your init.d/bluez-utils file for
test it in my system
4) use obexftp

TIP: for use obexftp you not need /etc/bluetooth/rfcomm.conf

> * Fredy Pulido L=F3pez <digitalfredy@debiancolombia.org> [Thu, Nov 03, 20=
05 at 03:52:11AM -0500]:
>=20
> > if you can made l2ping to your movil try with the obexftp version from
> > testing or sarge
>=20
> Yes, I can l2ping my mobile; I tried the obexftp versions from both
> unstable and testing, but they fail miserably.
> Never mind, one day I'll get it work by some magic :-)=20
> Thanks.
>=20



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
