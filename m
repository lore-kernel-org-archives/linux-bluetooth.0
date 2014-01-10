Return-Path: <cyrus@holtmann.org>
Date: Fri, 10 Jan 2014 01:32:31 +0100
From: Sebastian Reichel <sre@ring0.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        =?utf-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?= <freemangordon@abv.bg>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>,
        Ville Tervo <ville.tervo@nokia.com>
Subject: Re: [PATCH v4] Bluetooth: Add hci_h4p driver
Message-ID: <20140110003231.GA14141@earth.universe>
References: <1379703710-5757-1-git-send-email-pali.rohar@gmail.com>
 <1727897.LBX8128hIo@izba>
 <20140102161824.GA8204@amd.pavel.ucw.cz>
 <A5B72277-42D4-4A24-8A29-9BE18762E8C4@holtmann.org>
 <20140103001753.GA21023@amd.pavel.ucw.cz>
 <20140103013640.GB27678@earth.universe>
 <20140109233843.GB19974@amd.pavel.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
In-Reply-To: <20140109233843.GB19974@amd.pavel.ucw.cz>
List-ID: <linux-bluetooth.vger.kernel.org>


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On Fri, Jan 10, 2014 at 12:38:43AM +0100, Pavel Machek wrote:
> > Here are some cleanup suggestions for probe, removal & module
> > initialization functions.
>=20
> ...and here's the patch implementing those suggestions. Thanks!

That looks right, but you forgot to cleanup hci_h4p_remove. Also I
suggest to simply merge this as v5.

-- Sebastian

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSzz+eAAoJENju1/PIO/qa4FoP/Ayooh8mXhiIC/1ZmsEiw8qZ
o9UV40lamiJINCzIErKqdjzoStPHBNGTO424WMPkpsrLrPDcpq0SCcnPnYsSrMR9
YFgfjVI7REeRrOdJx8N/XX9xRhFnHuZ4RcfdhUa+oUXJ/QvBtC6ml6zuI1gOy8f4
DADhpAGB9mdubVNDBcfiCEiiS3J6NWbroSsZakcgdEC98u40Hu5OK5sCyr2FZwtb
LJeAIZe0jRQA3crP0E/2UKtfAKhfgvvaMhgSAKfM2TuH0dfKe79Fyo8KFBGQZxtz
aOVgKzzeZ6+dVg1Tt3unvISHEBJcN0iXne6v+t7baigS7blaa2xzX6MwGFpTaUew
Pvc/Z0iNVlH5WOQS8HMbW8T3y1iOz192eXDF6Gic3b7SW09Uac6ZgTO2JnmnAndf
nAkibtiYVOG2QPeKYmoBESDZXCLgufqImUuOCzWPES2oF2gQ2cnV0EU7VoueKdqo
ScD3Vq3i6wzDz73qnNtPKT2h/CvbqKdsOjaJHpljm6LekquC498wjwJTJLrAM9z6
p4Jc2MYZ3YMtCwTS2/+4Pc7A4HVt7k3v1LXEOUjaHPYQOUu9JCXp/RlV3iSU6Tb0
d5/03R507La5Q4x0ZApzVWLVi6BNHAIzpluA9s/zXPX8JTcBx1pTiuyPNX7nROb8
qj9ah+pghf2LNclT04bk
=8NWn
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
