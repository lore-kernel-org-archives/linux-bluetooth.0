Return-Path: <netdev-owner@vger.kernel.org>
Date: Sun, 1 Apr 2018 21:53:42 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: davem@davemloft.net
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: pull request: bluetooth-next 2018-04-01
Message-ID: <20180401185342.GA14384@x1c.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dave,

Here's (most likely) the last bluetooth-next pull request for the 4.17
kernel:

 - Remove unused btuart_cs driver (replaced by serial_cs + hci_uart)
 - New USB ID for Edimax EW-7611ULB controller
 - Cleanups & fixes to hci_bcm driver
 - Clenups to btmrvl driver

Please let me know if there are any issues pulling. Thanks.

Johan

---
The following changes since commit 06b19fe9a6df7aaa423cd8404ebe5ac9ec4b2960:

  Merge branch 'chelsio-inline-tls' (2018-03-31 23:37:33 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git for-upstream

for you to fetch changes up to 9ea471320e1302be0fac67c14a7ab7982609fea7:

  Bluetooth: Mark expected switch fall-throughs (2018-04-01 21:43:03 +0300)

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      Bluetooth: Mark expected switch fall-throughs

Hans de Goede (6):
      Bluetooth: hci_bcm: Add irq_polarity module option
      Bluetooth: hci_bcm: Treat Interrupt ACPI resources as always being active-low
      Bluetooth: hci_bcm: Add 6 new ACPI HIDs
      Bluetooth: hci_bcm: Remove duplication in gpio-mappings declaration
      Bluetooth: hci_bcm: Do not tie GPIO pin order to a specific ACPI HID
      Bluetooth: hci_bcm: Add ACPI HIDs found in Windows .inf files and DSTDs

Ian W MORRISON (1):
      Bluetooth: hci_bcm: Remove DMI quirk for the MINIX Z83-4

Jaganath Kanakkassery (1):
      Bluetooth: Fix data type of appearence

Loic Poulain (1):
      Bluetooth: hci_bcm: use gpiod cansleep version

Marcel Holtmann (5):
      Bluetooth: hci_bcm: Use default baud rate if missing shutdown GPIO
      Bluetooth: hci_ll: Use skb_put_u8 instead of struct hcill_cmd
      Bluetooth: hci_ll: Convert to use h4_recv_buf helper
      Bluetooth: bpa10x: Use separate h4_recv_buf helper
      Bluetooth: Remove unused btuart_cs driver

Markus Elfring (2):
      Bluetooth: btmrvl: Delete an unnecessary variable initialisation in btmrvl_sdio_register_dev()
      Bluetooth: btmrvl: Delete an unnecessary variable initialisation in btmrvl_sdio_card_to_host()

Vic Wei (1):
      Bluetooth: Set HCI_QUIRK_SIMULTANEOUS_DISCOVERY for BTUSB_QCA_ROME

Vicente Bergas (1):
      Bluetooth: btusb: Add USB ID 7392:a611 for Edimax EW-7611ULB

Wei Yongjun (1):
      Bluetooth: btrsi: remove unused including <linux/version.h>

 drivers/bluetooth/Kconfig       |  20 +-
 drivers/bluetooth/Makefile      |   1 -
 drivers/bluetooth/bpa10x.c      |   2 +-
 drivers/bluetooth/btmrvl_sdio.c |   4 +-
 drivers/bluetooth/btrsi.c       |   1 -
 drivers/bluetooth/btuart_cs.c   | 675 ----------------------------------------
 drivers/bluetooth/btusb.c       |   4 +
 drivers/bluetooth/h4_recv.h     | 160 ++++++++++
 drivers/bluetooth/hci_bcm.c     | 305 +++++++++++++-----
 drivers/bluetooth/hci_ll.c      | 222 +++++--------
 include/net/bluetooth/mgmt.h    |   2 +-
 net/bluetooth/mgmt.c            |   1 +
 net/bluetooth/rfcomm/sock.c     |   1 +
 13 files changed, 473 insertions(+), 925 deletions(-)
 delete mode 100644 drivers/bluetooth/btuart_cs.c
 create mode 100644 drivers/bluetooth/h4_recv.h

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJawSq2AAoJECQj9vv5qNQSsG4QAIg2fWZB/AqYZn/MT+nwaDOZ
OQK7SwHvm3aLvsyzxQnmT4ToNFde3yrjib0yCDZk6WBjRJhHcPvYOAzJAZN1WaxP
OU4RSnAHLzByfM3hr82yoQDGDNP4zQUirDO+ZRd385EO7fq/6P4lV11Hl5j3xCK2
InQ3w4d6SGMAkbz4fpF+IWvuO1KKKtadCz0O4flSz/jaMU9oIV7iljwFzu/QaduY
mn8+XoQeGhrLnQOJ+u/bqMKXISS/p2WaLC3f0zs/S5m+yzOMTHkH5Bw9t133/t9o
47CtJww7BE0Qx6cLtitFDEswFxQBFKXDKic4gKAVhcLzfVB4ArHpnjOdzpPT/6nz
fI5rNCNrwSxZTk5NoGQDygsZu6uPqyiVEzsVQpyA2IG7UBSFpDowDleKT7SKukEr
emMAEeinr44G8KZF7hf/vaPJWklaHguAytZ0aEK2NoEpAucVKaxJOawnib0CfPu2
MVe5nG6E2GkHTBntO52RCPINIcyc7xNFtti6rCeldDRxF0GDSdxgVyX8Y6TTeL25
yi116AWAlWHUcw860jqTqaYUCWfM0iuaL9LoIs+Jo/cCyaI7ngLuoBbrTpQlrlrN
f9PF3lUktBIMEhyxpldqlwrmCKzvxw170JHbqES3INGfj4QpEdIlSUu+adPg+Jdz
ix6bpnEgsLcQ/+IcgjSK
=ULUB
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
