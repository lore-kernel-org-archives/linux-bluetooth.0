Return-Path: <cyrus@holtmann.org>
Date: Fri, 12 Oct 2012 19:01:42 +0800
From: Gustavo Padovan <gustavo@padovan.org>
To: linville@tuxdriver.com
Cc: linux-wireless@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: pull request: bluetooth 2012-10-12
Message-ID: <20121012110142.GF10739@joana>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi John,

Johan found a critical issue while at Bluetooth UnPlug Fest this week.=20
The patch fixes a failure to pair with devices that support the LE Secure
Connections feature. This is also marked for stable.

Please pull! Thanks!

	Gustavo
---

The following changes since commit a7be50b7e30f9d77cb059a7ffdb781bb0fb92eba:

  iwlwifi: don't double free the interrupt in failure path (2012-09-18 20:4=
3:23 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth master

for you to fetch changes up to 065a13e2cc665f6547dc7e8a9d6b6565badf940a:

  Bluetooth: SMP: Fix setting unknown auth_req bits (2012-10-12 17:55:20 +0=
800)

----------------------------------------------------------------
Johan Hedberg (1):
      Bluetooth: SMP: Fix setting unknown auth_req bits

 net/bluetooth/smp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)


--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQd/iWAAoJEPs3PUX4s20owMYP/3cZK2BGs6XvcBLHWnjpUv9L
Cml/CPjDXv+EtZic4H1Hv0TPk8naV9Dbr6IweJyKWmUpEZRGUSTthFsDkNpm8qMG
HO8QTAQ0aZcZU/tQ282mxIXsirKSwCN5MkaMW0O9rD+E+lBxqrjiYGAO/qZ8zfdf
OkWtpIeMzob7blJFyzi3DdODbThyQO75AKWbxaj8rGIl8qytiwh+s+PBb1zrk2K8
FyvXqah9mYQg9ePJC8ygA1ICx/btFmdpntAOzcdIitD7jBk97jlzCe3YVduV3hVT
AgdQ0hjNRa5uc1rSg3nu7XxqFtTk2dU4Oo/NewMlp7jm5qsMvMciPx2yY6h9metu
BWSrSTCt9TEGYIHg1uO2+6qpTBJBpxAgZa2JbUhoMDw50X/CwO1ABV97z8wmGuVf
e026j8osFKAuVyMkkxM30RqwG/Q5wRKvy0T7PfBK71opVao0O16qn4b7OWnKq0YT
d1mic96DhhShN9dH59zPkxSK/NMWN/NiKcPnTCPbMLT33ssun04II3GIe/DiTC8q
TpQSyXjLBDkYpCB46jn0XZKt+UKPFNaif8JyY/eDqlIOFw0f55G73kphmwc2xJc/
qxThYnSGN+xTfdLCNkSG3IbnrsDPoq1CqmIFNp+sTH5hyskhNZvV+GxIlKiwBf2U
FzsO1rPebsTAD7neFuRB
=wOZZ
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
