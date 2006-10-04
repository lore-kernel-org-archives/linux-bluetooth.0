Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 4 Oct 2006 12:38:21 +0200 (CEST)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <9cc82a4d0610040220ldf5218bo608969a33cffd7da@mail.gmail.com>
Message-ID: <Pine.LNX.4.63.0610041224450.8219@redbean.intranet.gw-instruments.de>
References: <9cc82a4d0610030746r7039990eie8397add3559ca80@mail.gmail.com>
	<Pine.LNX.4.63.0610031651360.5319@redbean.intranet.gw-instruments.de>
	<9cc82a4d0610040220ldf5218bo608969a33cffd7da@mail.gmail.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1463794332-1684853101-1159958301=:8219"
Subject: Re: [Bluez-devel] High speed serial connection (Was: Bluez article
 on OReillyNet)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463794332-1684853101-1159958301=:8219
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable


Hi Guylhem,=20

On Wed, 4 Oct 2006, Guylhem Aznar wrote:

> Not on the C860: /dev/ttyS0, and neither on the 6000 : /dev/ttyS2
>=20
> But sharp gives weird names to their serial ports that do not reflect
> the uart connection - I will check the addresses directly in the
> sourcecode and guess the correct uart=E9
Ok, the driver assumes that the BTUART is used because this one shares th=
e=20
Pins with the HWUART. If the connection is different (HWUART pins can be=20
used on other pins as well) it may be possible to change the driver, but=20
in this case the schematics are needed.=20
=20
> I'll try to tweak it and let you know my results. Can I put a kernel
> sourcetree somewhere for you to see?
Just send me the /arch/arm/mach-pxa/ folder. This should contain=20
everything needed.=20
=20
> BTW I notice it comes from the ROAD S101. Any news on the device ?
> I am eager to see it reaching the market to review it. Last seen on
> press releases in Auguest.
I can't tell you. I'm only doing development for this device and even if =
I=20
would have some more detailed marketing information I would not be allowe=
d=20
to talk about ;-). =20

Ciao,=20

Peter=20


|       Peter Wippich                   Voice: +49 30 46776411          |
|       G&W Instruments GmbH            fax:   +49 30 46776419          |
|       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
|       D-13355 Berlin  / Germany                                       |

---1463794332-1684853101-1159958301=:8219
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
---1463794332-1684853101-1159958301=:8219
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

---1463794332-1684853101-1159958301=:8219--
