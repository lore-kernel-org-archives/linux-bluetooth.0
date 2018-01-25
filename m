Return-Path: <netdev-owner@vger.kernel.org>
Date: Thu, 25 Jan 2018 12:55:40 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: davem@davemloft.net
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: pull request: bluetooth-next 2018-01-25
Message-ID: <20180125105540.GA28588@x1c.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave,

Here's one last bluetooth-next pull request for the 4.16 kernel:

 - Improved support for Intel controllers
 - New set_parity method to serdev (agreed with maintainers to be taken
   through bluetooth-next)
 - Fix error path in hci_bcm (missing call to serdev close)
 - New ID for BCM4343A0 UART controller

Please let me know if there are any issues pulling. Thanks.

Johan

---
The following changes since commit 4f7d58517f461aa6e7b7509668f04021e089323d:

  Merge tag 'linux-can-next-for-4.16-20180116' of ssh://gitolite.kernel.org=
/pub/scm/linux/kernel/git/mkl/linux-can-next (2018-01-17 16:08:25 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t for-upstream

for you to fetch changes up to fbbe83c52bc0d52398de72d7df1857cc9b36244e:

  Bluetooth: btintel: Create common function for firmware download (2018-01=
-25 09:28:40 +0100)

----------------------------------------------------------------
Hans de Goede (1):
      Bluetooth: hci_bcm: For serdev case close serdev on failure to set po=
wer

J=F6rg Krause (1):
      Bluetooth: btbcm: Add entry for BCM4343A0 UART bluetooth

Tedd Ho-Jeong An (5):
      Bluetooth: hci_intel: Update firmware filename for Intel 9x60 and lat=
er
      Bluetooth: btintel: Create common function for Intel Reset
      Bluetooth: btintel: Use boot parameter from firmware file
      Bluetooth: btintel: Create common Intel Read Boot Params function
      Bluetooth: btintel: Create common function for firmware download

Ulrich Hecht (1):
      serdev: add method to set parity

 drivers/bluetooth/btbcm.c           |   1 +
 drivers/bluetooth/btintel.c         | 155 ++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h         |  33 ++++++-
 drivers/bluetooth/btusb.c           | 133 +++++---------------------
 drivers/bluetooth/hci_bcm.c         |   5 +-
 drivers/bluetooth/hci_intel.c       | 186 +++++++++++++-------------------=
----
 drivers/tty/serdev/core.c           |  12 +++
 drivers/tty/serdev/serdev-ttyport.c |  24 +++++
 include/linux/serdev.h              |  10 ++
 9 files changed, 328 insertions(+), 231 deletions(-)

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJaabesAAoJECQj9vv5qNQS6lAQAIvkKYUvpVHY0OfSUOFEHpdf
j4lnuX6E9GRxDqutteD3WLf3B0MNeUA0kCve3Oif6nRjZgR0oFULfpZwbboyNLyC
6QqeoeEW1hwf/dy0e6m28eWUszcCUN7L5pAgGVZkKi76GSL1alaUL9sgPUS5E7pI
N9xp2qVXCYlqdjBPvHRzmDRg2ekfAB2kbb0XCDfIsvoyT2HY0flcJh8gUtsw237r
WK8YfsCJIyU3flMoDzEhGilQNn/wfElYML5eO+uoTY+RLlVTTz5vgIo1ImjyleJe
6aSgMJiawrv5g3umd/2QLAfX6UzGcCPg/LWWDBIvCW86ISbgHYjYDOVgj+2WzL9L
4zON4EWRGG0vcu5E8iRJMfZGDPiANn4MzfQ0/BeTu+HwmEfQFCHYME1Eua7rS5ik
p3qwmsrtUtHJbpJlv9nq3q4l7klA1y29MoPsmFV31lQTBFE6KXu+ZmEjDnIW0Gw0
kFkpGKXDWeXs+BFGkwL0665BlE4Mm/SUc0p97rMfAL7zK6vDDbjJX08uxvyOLrDN
dA2dKV+RYbSHs3m508A0SxrLn8cKvuAn+FQffBOZlPkwjUZxtNyDek2oFcwiUXy0
Dx1BSWxLBWea7dbWMnJCaCcbPGuLkXgU32U8Ojlh6Bj1PX5Gvrhc/by0+M2GzNgj
sr94vNfXdyBXPJ6QIq4P
=YUV8
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
