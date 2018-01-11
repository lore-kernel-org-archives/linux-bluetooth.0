Return-Path: <netdev-owner@vger.kernel.org>
Date: Thu, 11 Jan 2018 10:24:34 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: davem@davemloft.net
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: pull request: bluetooth-next 2018-01-11
Message-ID: <20180111082434.GA12753@x1c.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave,

Here's likely the last bluetooth-next pull request for the 4.16 kernel.

 - Added support for Bluetooth on 2015+ MacBook (Pro)
 - Fix to QCA Rome suspend/resume handling
 - Two new QCA_ROME USB IDs in btusb
 - A few other minor fixes

Please let me know if there are any issues pulling. Thanks.

Johan

---
The following changes since commit 18feb87105c3c16dc01e6981a6aafb175679b997:

  enic: add wq clean up budget (2017-12-26 13:10:07 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t for-upstream

for you to fetch changes up to ff8759609d021c0e85945fcc4a148a0e55ace70f:

  Bluetooth: btbcm: Fix sleep mode struct ordering (2018-01-10 19:00:14 +01=
00)

----------------------------------------------------------------
AceLan Kao (1):
      Bluetooth: btusb: Add support for 0cf3:e010

Arnd Bergmann (1):
      Bluetooth: hciuart: add nvmem dependency

Colin Ian King (2):
      Bluetooth: bpa10x: make array 'req' static, shrinks object size
      Bluetooth: btintel: make array 'param' static, shrinks object size

Hans de Goede (1):
      Bluetooth: btusb: Restore QCA Rome suspend/resume fix with a "rewritt=
en" version

Ioan Moldovan (1):
      Bluetooth: Add a new 04ca:3015 QCA_ROME device

Kai-Heng Feng (1):
      Revert "Bluetooth: btusb: fix QCA Rome suspend/resume"

Lukas Wunner (15):
      Bluetooth: Avoid WARN splat due to missing GPIOLIB
      Bluetooth: hci_bcm: Streamline runtime PM code
      Bluetooth: Depend on rather than select GPIOLIB
      Bluetooth: hci_bcm: Mandate presence of shutdown and device wake GPIO
      Bluetooth: hci_bcm: Clean up unnecessary #ifdef
      Bluetooth: hci_bcm: Fix race on close
      Bluetooth: hci_bcm: Fix unbalanced pm_runtime_disable()
      Bluetooth: hci_bcm: Invalidate IRQ on request failure
      Bluetooth: hci_bcm: Document struct bcm_device
      Bluetooth: hci_bcm: Add callbacks to toggle GPIOs
      Bluetooth: hci_bcm: Handle errors properly
      Bluetooth: hci_bcm: Support Apple GPIO handling
      Bluetooth: hci_bcm: Silence IRQ printk
      Bluetooth: hci_bcm: Sleep instead of spinning
      Bluetooth: btbcm: Fix sleep mode struct ordering

Ronald Tschal=E4r (1):
      Bluetooth: hci_bcm: Validate IRQ before using it

 drivers/bluetooth/Kconfig   |   4 +
 drivers/bluetooth/bpa10x.c  |   2 +-
 drivers/bluetooth/btbcm.h   |   2 +-
 drivers/bluetooth/btintel.c |   2 +-
 drivers/bluetooth/btusb.c   |  22 ++--
 drivers/bluetooth/hci_bcm.c | 239 +++++++++++++++++++++++++++++++++++-----=
----
 6 files changed, 207 insertions(+), 64 deletions(-)

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJaVx9CAAoJECQj9vv5qNQSfJ4P/1k4z/tEH7eaOl6XPd5hmNjr
Dwqvam0cW1TKjGt0P2CD79/JIpBgP21yoP03hwlCkBdgNxrKiU5wkfVcy59AhfYy
0ZlN/dTe8ZuAs1Hv/aEg3m38fBUcXBDva8l26xzx7NI8fbwhvYmV2WgDEOL3xUBJ
qjtit/5dhXtl37afpSqGZwCMcYYoT74/2ml5CSkf0s6oDU+UOiK/lpUhl4b2LGwr
Gzu+YVB4InOYqD4N7QMLMIlxxHch5sG44tnZgq+Y23IDbEIH6gpeC4xCU9RAiV6H
Jl4+/ng0KJxUqR9kXoW6j3HtlvNK9IbuSNlo1SrWhK1cBi9vwE6gdQXtldoQHYP+
8GK/Jmfb0AXr7EESa6A164mhAKjfyytb0c0IgklEs+58NvqFJOMQBug7wSntXqSP
acy99MfBaRi0gHlqG/XRIlyeXKhDyrEGuih78NTTLodsnIJOR4EATvKUBVZbjFvp
9KGJ14t26gta2lLHC5hwx+lKQGuKudjp7Mx+PBDeCLlRwnbwHP2oZyH3z5/n680H
huEONzcsmy8KjE8uraOx1w4v5jGab+tbnkuU4Fy39toWoPGZsfIevAO59rvPJA03
lRsZnJDoLtcex5mq78Ax/D5NRcfjr6KmIsBpzRJlWDxW7dvcJmB+FbhJAjlCQxVD
0qxQWwBg84vrYgFutpeA
=gCDV
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
