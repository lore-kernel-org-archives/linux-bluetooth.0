Return-Path: <cyrus@holtmann.org>
Message-ID: <53DB6528.2040704@pengutronix.de>
Date: Fri, 01 Aug 2014 12:00:08 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
To: Alexander Aring <alex.aring@gmail.com>,
 Martin Townsend <martin.townsend@xsilon.com>
CC: linux-zigbee-devel@lists.sourceforge.net,
 linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
 Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH bluetooth-next] 6lowpan: Remove ununsed dev parameter
 from skb_delivery_cb callback.
References: <53DB5A53.5000004@xsilon.com> <20140801094144.GA11159@omega>
In-Reply-To: <20140801094144.GA11159@omega>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="sW21PaPpMMLflXEDaMP64sLo59OVB3Fg0"
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sW21PaPpMMLflXEDaMP64sLo59OVB3Fg0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/01/2014 11:41 AM, Alexander Aring wrote:
> Hi Martin,
>=20
> On Fri, Aug 01, 2014 at 10:13:55AM +0100, Martin Townsend wrote:
>> This parameter is never used by any function implementing this callbac=
k.
>> ---
>>  include/net/6lowpan.h         | 2 +-
>>  net/6lowpan/iphc.c            | 2 +-
>>  net/bluetooth/6lowpan.c       | 4 ++--
>>  net/ieee802154/6lowpan_rtnl.c | 5 ++---
>>  4 files changed, 6 insertions(+), 7 deletions(-)
>>
>=20
> I don't test it yet, but you need to add a Signed-off-by: ...
>=20
> You can create this with -s parameter while git format-patch.

Usually the Sob is added during the commit with the -s parameter, i.e:

    git commit -s

You can modify your commit and add the Sob with:

    git commit --amend -s

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--sW21PaPpMMLflXEDaMP64sLo59OVB3Fg0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlPbZSgACgkQjTAFq1RaXHNFngCfQgc/NATlNwqQbMR7zqhJL9/F
qVQAn04ZRIiF1ySpgi7OhRe51GqFBZ+E
=7BWt
-----END PGP SIGNATURE-----

--sW21PaPpMMLflXEDaMP64sLo59OVB3Fg0--
