Return-Path: <netdev-owner@vger.kernel.org>
Date: Mon, 7 May 2018 18:05:33 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: davem@davemloft.net
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: pull request: bluetooth 2018-05-07
Message-ID: <20180507150533.GA2927@x1c.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dave,

Here are a few more Bluetooth fixes for the 4.17 kernel, all for the
btusb driver. Two relate to the needs_reset_resume table, and one is a
revert of a patch for Atheros 1525/QCA6174 which caused a regression for
some people.

Please let me know if there are any issues pulling. Thanks.

Johan

---
The following changes since commit 2cb5fb1454ef4990f44f3070226ee29201bd5c87:

  MAINTAINERS: add myself as SCTP co-maintainer (2018-04-29 22:49:45 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git for-upstream

for you to fetch changes up to 596b07a9a22656493726edf1739569102bd3e136:

  Bluetooth: btusb: Add Dell XPS 13 9360 to btusb_needs_reset_resume_table (2018-04-30 10:56:04 +0200)

----------------------------------------------------------------
Hans de Goede (3):
      Revert "Bluetooth: btusb: Fix quirk for Atheros 1525/QCA6174"
      Bluetooth: btusb: Only check needs_reset_resume DMI table for QCA rome chipsets
      Bluetooth: btusb: Add Dell XPS 13 9360 to btusb_needs_reset_resume_table

 drivers/bluetooth/btusb.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJa8Gs9AAoJECQj9vv5qNQS27oP/1CWaB2aZZ53uWqV7JTPgj+W
k8LGrl9Nwi+5CiERfjW2oyYuzLFJrfKSqvhkHiDD+1DBNz01yhmHQA8+LVqKh8RN
jmoh5I8MsFPOQIc8VJj01ZEVBshtlOa2j9Ab/hq7+zLP/GIfXKC34IDyYAsOfVWE
Gccv+p+TBAKoIMis2cp2BNTaRD1n5a52EemjIPzOgTC3j99XdstDRbX85wAIxSiF
ZPZoSo7eDN+e6YjTKly1jMfYg8hoMkDcHTwPfLpzwEf1uSIFuJqKyFdRKfEuQaCn
p8fEnQSeW2pySHeJGB5pHo+VL0xYVmNggFxNEE7ph6SzeLQMlnXjMcyobW5KQmxQ
I3NQcSrExEr1ooDFrftam7JWJkwTPvk+KApiY/CTQCAf2Yw4d65AZkPc3RGagPOR
O9EVI6tnshRGU4IiqMNchNj0imTcN81wy1aisO6Jk+OBfB35xptIPMhOk/bkjsZG
ho0XmJ6BvOL5i4zUK3IhDNiBdj49S5vG3Oonzjl1PH3xWICK+mGwxRdSVzV33j7i
NP+J5jOMMelRfCXpli1VXBNPWcfoIg+vRob52lDQzpF+rlxXiqALRnQ7nZu8X9nJ
BGq7ukITDn7iPS2frofw/Q3eUlrQE4NTbxUt0hHP4KUw0tdbVRZtplXUqfg/TywM
v7/T6cA+FfAYJtCqQxkf
=bTOE
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
