Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: # =?ISO-8859-1?Q?Bj=F6rn?= Specht # <bspecht@gmx.net>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btohs,btohl, ...
Message-ID: <20050209143858.1e0350c3@CleverSophie>
In-Reply-To: <1107955171.13863.26.camel@pegasus>
References: <20050209140701.2cf50710@CleverSophie>
	<1107955171.13863.26.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Wed, 9 Feb 2005 14:38:58 +0100

Hi Marcel,

sorry for my signing. I read that sometimes a different order is used withi=
n a byte as well and not only between bytes.=20
Okay that makes it easier.
But if this is not the case:
When I send a 32bit integer for example, do I have to worry about the order=
 of the bytes when I send or receive them?=20

Bj=F6rn


On Wed, 09 Feb 2005 14:19:31 +0100
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Bjoern,
>=20
> if you sign emails that go to a mailing list. Make sure that your key is
> available on a public keyserver. Yours is not.
>=20
> > I implemented a client server over bluetooth and I was wondering if I n=
eed the Little Endian, Big Endien conversion functions btohs,btohl,htobs,ht=
obl?
>=20
> if both sides are of the same endianess then not, but it is a good
> programming style to always use them.
>=20
> > Do I need to convert every single byte? which is received or sent over =
my sock_stream socket?
> > If yes, should it look like this for the receiving case: btohs(buf[0]).=
... an so on for every byte?
>=20
> For what do you wanna swap a byte and with what? There is nothing to
> swap. Think about it ;)
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>=20


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
