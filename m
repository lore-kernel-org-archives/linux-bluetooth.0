Return-Path: <cyrus@holtmann.org>
Date: Thu, 22 Mar 2012 09:28:01 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Bluetooth: don't increment twice in eir_has_data_type()
Message-ID: <20120322062801.GA3232@mwanda>
References: <20120320150611.GA24873@elgon.mountain>
 <20120321220632.GA14964@x220.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
In-Reply-To: <20120321220632.GA14964@x220.amr.corp.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 21, 2012 at 07:06:32PM -0300, Johan Hedberg wrote:
> Looks like the original code is indeed buggy, no idea how I didn't
> notice something that obvious. Your patch does however seem to change
> the behavior a bit, a valid tag would be detected even though its length
> would be invalid (pointing outside of the supplied data). Not sure if
> that's so critical though since the important thing is to keep the code
> from doing anything nasty when supplied invalid data.
>=20

We should check the length.  It will just cause headaches if we
don't.

It would be simple enough for me to put back the check I removed
=66rom the middle of the loop.  But the thing is I wasn't sure how all
the + 1 and - 1 things fit together so I didn't feel good about
signing off on this.  Could you send a patch?  That way I get a
reported-by tag but if there are any problems you get blamed while I
deny knowing anything about it.  ;)

regards,
dan carpenter

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPasZxAAoJEOnZkXI/YHqRzVcP/RYS3hH5d+JP08sOX94N4mcK
mHoabop1nuLh4jYFqdbpLcRtpOzLjFK3AZQN611aSU17qsjm/MHMXn21quscJSUF
APJeOUW3fenr62MITQ3vENgsQxHcUyWDhncU5yX8YJBTpOkzrSOhik2x+Tm58ezr
eO5uCqTb7w7637U+PI1dhwB2KIIyqaBh8CWjavuENQ+4K2XCecDqJYYooNA4olAp
LsnKTXEsmL6ZNOm5eFziR+NA23kAOYOu9cyyoezsuWZEebfFp5XZCsYiuC/C89Wi
N4x7jMXIze96Q1TJbmN49GUSfLhLgNLvZtkMxCqLlNnhLNDFjGiFrESKJicuRYuV
ARadSGzm5vOqeAPMbH5jpofX9pnt4jtVtIZSyP97nCNm3joKsvGxDqAf6s2NPwg/
DUoEexIa5nRWMf5/eWUaFV/opSrXkcMOYyHB2GBA64nWJ264QUa68sAbp8U5Ab9H
Lo7llB5TZkLVLPLwibDv2ktEm17YNAZNu6Lv81a27AtT3QgbC3k1JKbD/JPgF/Vp
nfce4P4BZ/D6wf6xvLGTjwrr1Sc25dZMzBX5Nfy0brc6fR7UjpZqeunzZNKmrqkU
UAhf3+mnKzarM1NhVz2FiBvqZLbstlyzITi7eHh+yVuUShpsdgV/thPXUkoMfH82
O3JvE8llECKha6Z718JI
=GtPG
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
