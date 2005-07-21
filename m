Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42DF39A9.1010304@soft.uni-linz.ac.at>
From: Simon Vogl <vogl@soft.uni-linz.ac.at>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] setserial /dev/bluetooth/rfcomm/1 ????
References: <Pine.GSO.4.58.0507201807410.9879@myrtle.ukc.ac.uk>
In-Reply-To: <Pine.GSO.4.58.0507201807410.9879@myrtle.ukc.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Thu, 21 Jul 2005 07:59:05 +0200

Hi Philipp,
I think you need to extend the search pattern for comm ports so rxtx
recognizes your port in the first place. With the rxtx version I use,
I can set this in the global properties file like this:
In vogl@wall4:/data/oss$ cat /usr/lib/j2se/1.4/jre/lib/ext/gnu.io.rxtx.pr=
operties
gnu.io.rxtx.SerialPorts=3D/dev/ttyS0:/dev/ttyS1:/dev/rfcomm20:/dev/rfcomm=
21:
gnu.io.rxtx.ParallelPorts=3D/dev/lp0:
..or you can pass it on the command line, of course.

As this is slightly OT, we can discuss this by mail, if further problems =
arise.
Simon

Philipp H. Mohr wrote:
> Hello,
>=20
> I like to use rxtx - a java/linux serial port library. But it doesn't
> recognise my bluetooth serial ports on my ipaq. In order to activate th=
em
> I would like to use the tool setserial - if that's the right tool to us=
e
> !?. I would like to activate my bluetooth serial port, but I am not sur=
e
> which parameters to pass to it.
>=20
> setserial /dev/bluetooth/rfcomm/1 ??????
>=20
> My port is working, as I can get data from it by doing cat, but for the
> library to recognise it I need to make it active or some thing...
>=20
>=20
> Thank you,
> Phil
>=20
>=20
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dcl=
ick
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
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
