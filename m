Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] can't compile bluez-utils-2.6
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200404020850.11459.cijoml@volny.cz>
References: <200404020850.11459.cijoml@volny.cz>
Content-Type: text/plain; charset=iso-8859-2
Message-Id: <1080894207.2774.47.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 02 Apr 2004 10:23:28 +0200

Hi Michal,

> make uninstall in bluez-sdp-1.5 and then make in bluez utils-2.6 causes=
=20
> errors:
>=20
> gcc -DPACKAGE_NAME=3D\"\" -DPACKAGE_TARNAME=3D\"\" -DPACKAGE_VERSION=3D=
\"\"=20
> -DPACKAGE_STRING=3D\"\" -DPACKAGE_BUGREPORT=3D\"\" -DPACKAGE=3D\"bluez-=
utils\"=20
> -DVERSION=3D\"2.6\" -DYYTEXT_POINTER=3D1  -I. -I.    -I/usr/include  -W=
all -g -O2=20
> -c sdptool.c
> sdptool.c:36:27: bluetooth/sdp.h: nen=ED souborem ani adres=E1=F8em
> sdptool.c:37:31: bluetooth/sdp_lib.h: nen=ED souborem ani adres=E1=F8em
> sdptool.c:38:36: bluetooth/sdp_internal.h: nen=ED souborem ani adres=E1=
=F8em
> sdptool.c:45: error: parse error before "bdaddr_t"

you must install bluez-libs-2.6 first.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
