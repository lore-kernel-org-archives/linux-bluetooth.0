Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <404CAE36.4030301@lnt.uni-saarland.de>
From: Eric Chapman <eric@lnt.uni-saarland.de>
MIME-Version: 1.0
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Bluez on Axis DevBoard 82
References: <DGELJAKAPGMFDACACGBEKEJECCAA.webmaster@baxter-net.de> <1078765296.10671.14.camel@pegasus>
In-Reply-To: <1078765296.10671.14.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 08 Mar 2004 18:32:38 +0100

This only relates to the kernel sources within the axis devboard=20
developer environment. It seems to me, that this is wanted, because Axis=20
  are aware of it, since one of their developers pointed me there.

Tobias' description of the solution is also what I had to do. Speaking=20
of which: Tobias, how did you find the solution?

On an different note, Tobias pointed me to another person who is trying=20
to get a similar hardware config to work. His config freezes up upon=20
doing a hcitool scan (inq works fine). I am using a USB and a serial=20
Bluetooth interface. USB freezes on scan, the serial one doesn't. They=20
are both CSR HCI 16.4

Any Ideas?


Marcel Holtmann wrote:

> Hi Tobias,
>=20
>=20
>>with "kernel part of bluez" I really mean this part of bluez,
>>which could be configured in the linux kernel.
>>After installing the Axis-DevBoard-Software, there isn't a submenu for
>>Bluetooth anymore
>>when running "make xconfig" ...
>=20
>=20
> this must be a bug. What kernel do you use? Maybe it is some Axis OpenB=
T
> specific cruft of the Cris architecture. If so, it must be removed and
> patches are welcome.
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20

--=20
Eric Chapman

-----------------
Lehrstuhl f=FCr Nachrichtentechnik
Universit=E4t des Saarlandes
Postfach 15 11 50
D-66041 Saarbr=FCcken
Tel: +49 681 302 3975
Fax: +49 681 302 3972
Web: www.lnt.uni-saarland.de



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
