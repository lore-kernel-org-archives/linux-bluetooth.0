Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 May 2012 12:56:17 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Mat Martineau <mathewm@codeaurora.org>,
	linux-bluetooth@vger.kernel.org, pkrystad@codeaurora.org
Subject: Re: [PATCHv2 2/2] Bluetooth: Lock the L2CAP channel when sending
Message-ID: <20120516155617.GD1414@joana>
References: <1336166431-4926-1-git-send-email-mathewm@codeaurora.org>
 <1336166431-4926-3-git-send-email-mathewm@codeaurora.org>
 <20120505000104.GB23728@joana>
 <20120508074223.GA29352@aemeltch-MOBL1>
 <20120508074451.GA19057@joana>
 <20120516145037.GC10880@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
In-Reply-To: <20120516145037.GC10880@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrei,

* Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com> [2012-05-16 17:50:=
39 +0300]:

> Hi Gustavo,
>=20
> On Tue, May 08, 2012 at 04:44:51AM -0300, Gustavo Padovan wrote:
> > > > Patch has been applied to the bluetooth tree. Thanks.
> > >=20
> > > What about applying the first patch? I actually pulled that patch from
> > > bluetooth-next and modified locking in my code but now that patch see=
ms to
> > > be lost.
> >=20
> > I applied it to bluetooth.git. Now you have to wait we merge bluetooth.=
git
> > into bluetooth-next.git, that will happen shortly after John pull the p=
ull
> > request I sent.
>=20
> What about the patch in question? Since it was in repository before I have
> modified my code and changed locking logic but then patch disappeared.
>=20
> Not that I think the patch is very important but I do not work to modify =
code too
> often...

The patches that were in bluetooth.git tree are in bluetooth-next.git. There
were reject in the pull request and I had to move them out.

	Gustavo

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPs84gAAoJEPs3PUX4s20ozxQQAJcyk9CAmKoB/jQoa4PW3ixP
dWmNvo4llvF1VQ2WLAm0YvQclLbKtPuoZojfMQSkqx3EnWR45RnzIYcoeoglw1KM
Txy+r1QrNM9DaL3eJYbjxBl03xftMvWoARVWpF7Z3apGrfoqtnnSEKTDCltGmicT
5/O3pSdunvSM5M+M4YFJfjgYX0H07EipGyAZKa15DoJTvy6yDRxlTxQA1rRxeyoR
Wco3dKJJRuXR7yT2E0ZfaWL7GDhlT9J9tBudwTDeQeGeRCljd8tTPiTwrGET7MZC
j0RnF5iK9SwO7MHC6b4WhyliA6HZgC8iajw1v+SG4upgXn4lUJMGmZm08r4pwcm4
sOF9pb850TvXTIdwT+HtxN84t7UAga2KcyQtpHLAV8WCzq6lIShtyTJSsmvXM1tF
s9d0UL28oe+BTWZfp3DbhR0Ib+sn4M297tErYkaE+mFUL+ymqadDKSLLAhwLJFUr
R6Lz9iVaIlW1wu3hiCsk+hqN1yg4mlYbQwD6hunAwf2JxGTkI4Akf/eR0GsGyBp+
dQBWUzCQrfZYTEf8do3trbJADy0G2olpCmuWHJqnwGZOWLZ1WM9YbRYVVnvD5Al2
O6DJc8o6mjTRDl6DK8QV7T0ZgaqxQUuhbzECxI2lPINocVej5Elr3HMjQumyUX4l
c2/GmgGvzMDR6Vsbf6N2
=Dy01
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--
