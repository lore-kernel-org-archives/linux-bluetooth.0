Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: # =?ISO-8859-1?Q?Bj=F6rn?= Specht # <bspecht@gmx.net>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btohs,btohl, ...
Message-ID: <20050209150056.1b055893@CleverSophie>
In-Reply-To: <1107957430.13863.34.camel@pegasus>
References: <20050209140701.2cf50710@CleverSophie>
	<1107955171.13863.26.camel@pegasus>
	<20050209143858.1e0350c3@CleverSophie>
	<1107957430.13863.34.camel@pegasus>
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
Date: Wed, 9 Feb 2005 15:00:56 +0100

Thanks Marcel,

You're the man!

Bj=F6rn

On Wed, 09 Feb 2005 14:57:10 +0100
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Bjoern,
>=20
> > sorry for my signing. I read that sometimes a different order is used w=
ithin a byte as well and not only between bytes.=20
>=20
> I don't know of any architecture that stores the bits of its bytes in a
> different order and where this is visible to for the user. However such
> a platform might exists.
>=20
> > Okay that makes it easier.
>=20
> You mean big endian communicates with little endian or vice versa?
>=20
> > But if this is not the case:
> > When I send a 32bit integer for example, do I have to worry about the o=
rder of the bytes when I send or receive them?=20
>=20
> If you have a byte stream (a character array) then you don't need to
> worry, because they are stored in a endianless format (bytewise). If you
> use datatypes like uint16_t and uint32_t and send them to the stream or
> copy them into an array then you should convert them to the same endian
> encoding.
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
