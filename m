Return-Path: <netdev-owner@vger.kernel.org>
Date: Mon, 18 Dec 2017 11:27:21 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: davem@davemloft.net
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: pull request: bluetooth-next 2017-12-18
Message-ID: <20171218102721.GA17768@x1c>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave,

Here's the first bluetooth-next pull request for the 4.16 kernel.

 - hci_ll: multiple cleanups & fixes
 - Remove Gustavo Padovan from the MAINTAINERS file
 - Support BLE Adversing while connected (if the controller can do it)
 - DT updates for TI chips
 - Various other smaller cleanups & fixes

Please let me know if there are any issues pulling. Thanks.

Johan

---
The following changes since commit 48d79b49e16831e613b67dccd4c7886081161656:

  Merge branch 'tcp-better-receiver-autotuning' (2017-12-12 10:53:04 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t for-upstream

for you to fetch changes up to 22b371cbb949e1c8ee4accfead5ee9f3e7f0c114:

  Bluetooth: introduce DEFINE_SHOW_ATTRIBUTE() macro (2017-12-13 20:20:34 +=
0100)

----------------------------------------------------------------
Andy Shevchenko (2):
      Bluetooth: Utilize %*ph specifier
      Bluetooth: introduce DEFINE_SHOW_ATTRIBUTE() macro

David Lechner (9):
      Bluetooth: hci_ll: remove \n from kernel messages
      Bluetooth: serdev: hci_ll: Wait for CTS instead of using msleep
      Bluetooth: hci_ll: add constant for vendor-specific command
      Bluetooth: hci_ll: Add endianness conversion when setting baudrate
      Bluetooth: hci_ll: add support for setting public address
      dt-bindings: Add optional nvmem BD address bindings to ti,wlink-st
      Bluetooth: hci_ll: Add optional nvmem BD address source
      dt-bindings: net: add TI CC2560 Bluetooth chip
      Bluetooth: hci_ll: add "ti,cc2560" compatible string

Gustavo Padovan (1):
      Bluetooth: Remove myself from the MAINTAINERS file

Hans de Goede (4):
      Bluetooth: btusb: Add a Kconfig option to enable USB autosuspend by d=
efault
      Bluetooth: btusb: Fix BT_HCIBTUSB_AUTOSUSPEND Kconfig option name
      Bluetooth: hci_bcm: Add support for BCM2E72
      Bluetooth: btsdio: Do not bind to non-removable BCM43341

Jaganath Kanakkassery (1):
      Bluetooth: Remove redundant disable_advertising()

Jia-Ju Bai (1):
      Bluetooth: Fix a possible sleep-in-atomic bug in bluecard_write_wakeup

Loic Poulain (2):
      Bluetooth: hci_qca: Avoid setup failure on missing rampatch
      Bluetooth: btqcomsmd: Fix skb double free corruption

Lukas Wunner (1):
      Bluetooth: hci_serdev: Init hci_uart proto_lock to avoid oops

Markus Elfring (1):
      Bluetooth: Use common error handling code in bt_init()

=C5=81ukasz Rymanowski (1):
      Bluetooth: Add support to advertise when connected

 .../net/{ti,wilink-st.txt =3D> ti-bluetooth.txt}     |  18 +-
 MAINTAINERS                                        |   2 -
 drivers/bluetooth/Kconfig                          |  10 +
 drivers/bluetooth/bluecard_cs.c                    |   8 +-
 drivers/bluetooth/btqcomsmd.c                      |   3 +-
 drivers/bluetooth/btsdio.c                         |   9 +
 drivers/bluetooth/btusb.c                          |   7 +
 drivers/bluetooth/hci_bcm.c                        |   1 +
 drivers/bluetooth/hci_ll.c                         | 107 ++++++++++-
 drivers/bluetooth/hci_qca.c                        |   3 +
 drivers/bluetooth/hci_serdev.c                     |   1 +
 net/bluetooth/af_bluetooth.c                       |  38 ++--
 net/bluetooth/hci_debugfs.c                        | 201 +++--------------=
----
 net/bluetooth/hci_request.c                        |  64 +++++--
 14 files changed, 237 insertions(+), 235 deletions(-)
 rename Documentation/devicetree/bindings/net/{ti,wilink-st.txt =3D> ti-blu=
etooth.txt} (64%)

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJaN5gJAAoJECQj9vv5qNQSyFkP/2tlZlOISENO+5AHJELwXS/H
7K/A1E1reCzsAXUrBhCvY2mfoIlOjv+ELU6AVGkeDFJeUP4NMnIM482r+hccj9SW
Nzk4f8CG+a//rZTYAck9zvpm5Cra4q79AgVA7urJmKVkFHUulkVQfwzBpbB/ptqj
7x7DE7z9TeWIVe5ajxMU8wudLqLWVXutFWFbrif2U5z0xVe01EUb4lVhxMbzEUFJ
UBOF1gu5ZIsRtj05mOA7HSa97L38//TpZQoyYqTOdvcetbpnLBsGBK6K8mcB3rfR
gFqFCjyxEy3bfyhHdoDX1jClJ4zwxmRa7I7sU6I583Dn7wNdwQtKXUf4rcb7fBst
jWT9fPRgBAn1VjFIvYW8Su4a1VALDClXm3xoTdGwgUujVr3JnZLgQs+KnABBlKRj
+IMN/e+MFO7g2cSJhSMbmYsBhGzJ0PYD8dRgif+M/8Ny/qLAPZPH1Sg4aF+A4ISA
D/zbAWcIPvfScdPB2zuHHBF2UIir4t4tHGOmXFL3X/4QOcVrU8yFtVnunD1RnwN/
RW37MVnKqG1/JuRuX3doDqUZxwVpTZXauNPYzQJ7U2a3XoRuWMfBCKyUXa+miWnH
DuNI8slBZ9LVs17l7pHK+57hrT3jCoMczcCg0EGBjGQG44xjHvHVpebZiCXwo12D
41Rfv9En3jnbdOfDRHhK
=9Hr6
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
