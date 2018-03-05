Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 5 Mar 2018 14:29:12 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: davem@davemloft.net
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: pull request: bluetooth 2018-03-05
Message-ID: <20180305122912.GA12251@x1c.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dave,

Here are a few more Bluetooth fixes for the 4.16 kernel:

 - btusb: reset/resume fixes for Yoga 920 and Dell OptiPlex 3060
 - Fix for missing encryption refresh with the Security Manager protocol

Please let me know if there are any issues pulling. Thanks.

Johan

---
The following changes since commit 773daa3caf5d3f87fdb1ab43e9c1b367a38fa394:

  net: ipv4: avoid unused variable warning for sysctl (2018-03-01 13:38:22 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git for-upstream

for you to fetch changes up to 64e759f58f128730b97a3c3a26d283c075ad7c86:

  Bluetooth: Fix missing encryption refresh on Security Request (2018-03-01 19:55:56 +0100)

----------------------------------------------------------------
Hans de Goede (1):
      Bluetooth: btusb: Remove Yoga 920 from the btusb_needs_reset_resume_table

Kai-Heng Feng (1):
      Bluetooth: btusb: Add Dell OptiPlex 3060 to btusb_needs_reset_resume_table

Szymon Janc (1):
      Bluetooth: Fix missing encryption refresh on Security Request

 drivers/bluetooth/btusb.c | 6 +++---
 net/bluetooth/smp.c       | 8 +++++++-
 2 files changed, 10 insertions(+), 4 deletions(-)

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJanTgYAAoJECQj9vv5qNQS5XkQAIihxXF0xCg/qUqUkepXs0Da
jtbzZVTvl36Q/qiV0yFAzTofBmAo/NT+C02JyVWC5ya1XSpuTyNDv+rF24yiiQQC
8AmDbLpCPWZ6QVRO/GwYq7Lbi4gBSj1sSJvRACIGillvBu2v1t1Hv95zyaX8wxnl
kkolxIy9k6OxR1fxnAzQDKoMHBhBNyxs034YqTGF8TfawOa47D3U6gizklPADVCg
h8bF62iY3xf1gZZ1LcD4EMfBpDG6TrJWc/F+FjvUOIXHdxdE4JZCSmhAbiDxPRrt
cCjKR1niIGwPqJBh6owp0LnzoAmXWGFwdK4qvIOKJRwJD5PKEcoKEQN2ktWrwsSZ
y4uNzXB2fELdueNuiTrabxKnmWKM4TfP9zaL1muV/4fHenAJWRWXTMpCmTz1DTSz
PbnfXI6iWVd143NtWk+2EFWxWE5o+6k6T/YRYv+V/W72FdcEO1b7xtozy28nSNKQ
IHjdfNGiea7pCsRTfbyHLe06LjkRb6wtdlpoW4bMt0EQvAVW1W8q8WRkWqkDx4Va
uNFF6Nfin1i/irUY8gpxxBU4wZLg54TzWhSNpP0G0aVWkrvvjKr1Te9Yo3UvgkbM
D6H6tS0qzMhlDlI2gZDWIUK8agTa6ZdS9ipCjmxi9NfAAfNH/mAdubLuyNTfcZeu
q1YsDSVew5YR3NVa2fJB
=tZqI
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
