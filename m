Return-Path: <netdev-owner@vger.kernel.org>
Date: Fri, 10 Aug 2018 22:57:07 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: davem@davemloft.net
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: pull request: bluetooth-next 2018-08-10
Message-ID: <20180810195707.GA6542@x1c.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dave,

Here's one more (most likely last) bluetooth-next pull request for the
4.19 kernel.

 - Added support for MediaTek serial Bluetooth devices
 - Initial skeleton for controller-side address resolution support
 - Fix BT_HCIUART_RTL related Kconfig dependencies
 - A few other minor fixes/cleanups

Please let me know if there are any issues pulling. Thanks.

Johan

---
The following changes since commit 981467033a37d916649647fa3afe1fe99bba1817:

  tc-testing: remove duplicate spaces in skbedit match patterns (2018-08-05 17:39:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git for-upstream

for you to fetch changes up to aa12af77aae05008b3e637b85944dcd512f75eba:

  Bluetooth: Add definitions for LE set address resolution (2018-08-10 16:57:57 +0200)

----------------------------------------------------------------
Ankit Navik (1):
      Bluetooth: Add definitions for LE set address resolution

Marcel Holtmann (2):
      Bluetooth: btqca: Introduce HCI_EV_VENDOR and use it
      Bluetooth: Introduce BT_HCIUART_RTL configuration option

Sean Wang (3):
      dt-bindings: net: bluetooth: Add mediatek-bluetooth
      Bluetooth: mediatek: Add protocol support for MediaTek serial devices
      MAINTAINERS: add an entry for MediaTek Bluetooth driver

YueHaibing (1):
      Bluetooth: remove redundant variables 'adv_set' and 'cp'

 .../devicetree/bindings/net/mediatek-bluetooth.txt |  35 ++
 MAINTAINERS                                        |   8 +
 drivers/bluetooth/Kconfig                          |  24 +
 drivers/bluetooth/Makefile                         |   1 +
 drivers/bluetooth/btmtkuart.c                      | 629 +++++++++++++++++++++
 drivers/bluetooth/btqca.c                          |   6 +-
 drivers/bluetooth/hci_h5.c                         |   4 +
 include/net/bluetooth/hci.h                        |   5 +
 net/bluetooth/hci_event.c                          |  31 +-
 net/bluetooth/mgmt.c                               |   3 -
 10 files changed, 737 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
 create mode 100644 drivers/bluetooth/btmtkuart.c

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbbe4TAAoJECQj9vv5qNQSHaUP+QF2lWV8tP8/kEWblIXnrmyP
0NXsigSIyTkjYsqHPKaq5sWxZ/WMmEeboQnbtrzESj6RjZBofVqurdHcE5i8E7he
WmUZDw3NaTYuagFbc+Ly711r9ik5aVmgUJEoTVZo0F0FIlM9j6QTB5TdnhXyp1AG
QdvNqhJnKXFDOu/qHFIJ2cB5UfQH6EFUnZD0bfz32sH4kQXtU6HLXeHU5WDzv3lZ
C71AzxEPOJ6qyFDQ7zyPvxLzVP3NIMtJDemd3peI47lZmdGhCGlKS0QKSo/mLLKV
IAYkBIMk3RFrHhmtKE25J3tdsEAFPeobEcY55jE5TLd/PZ9B5IXr2Ap6sX9lIb0c
jlSmNj6qYgBLCgautIvLJsV5UYnou8GW3lKD8jzChy0p3UPioOCRdAJJYTxtvReA
FviO9/Pvhw+fODugK//ffl13GVCO4Y/1i8xf9vLTUZbWDzrxDKiq/hjKhHcVrRmv
7sIc3XAAmnGlWym2YKL+7HbSua2/9F4Tpzcbf2ZIXSC9W73A6zP/Zuorz4sJ+jD9
04ExlR4JM/t+omWHdm/DY0i/dK3lck6MDchZyH7fm4Cf5tKhQdRuZ4W/j5qUTzrY
6tX2ZM2JZYilxOzQrnTs7zC5bj0Ya+veIW4imIDLAw3uzMvBbQuq3SVwc+U/0Yrc
R5zlnatr7QicPvsM5cO1
=GaTw
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
