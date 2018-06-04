Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 4 Jun 2018 12:15:32 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: davem@davemloft.net
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: pull request: bluetooth-next 2018-06-04
Message-ID: <20180604101532.GA8919@x1c>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dave,

Here's one last bluetooth-next pull request for the 4.18 kernel:

 - New USB device IDs for Realtek 8822BE and 8723DE
 - reset/resume fix for Dell Inspiron 5565
 - Fix HCI_UART_INIT_PENDING flag behavior
 - Fix patching behavior for some ATH3012 models
 - A few other minor cleanups & fixes

Please let me know if there are any issues pulling. Thanks.

Johan

---
The following changes since commit 874fcf1de613ad7b3cecf8a9cfe806fe7c2e3c68:

  Merge tag 'mlx5e-updates-2018-05-25' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux (2018-05-29 09:45:13 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git for-upstream

for you to fetch changes up to 1cd2fabf4bdcf95eda6a1bcebc4a0a965509da36:

  Bluetooth: btusb: Add additional device ID for RTL8822BE (2018-05-30 15:45:01 +0200)

----------------------------------------------------------------
Andy Shevchenko (2):
      Bluetooth: Re-use kstrtobool_from_user()
      Bluetooth: btmrvl: Re-use kstrtol_from_user()

Arend van Spriel (1):
      Bluetooth: btmrvl: support sysfs initiated firmware coredump

Artiom Vaskov (1):
      Bluetooth: btusb: Add additional device ID for RTL8822BE

Hans de Goede (4):
      Bluetooth: btusb: Add Dell Inspiron 5565 to btusb_needs_reset_resume_table
      Bluetooth: hci_uart: Restore hci_dev->flush callback on open()
      Bluetooth: hci_serdev: Move serdev_device_close/open into common hci_serdev code
      Bluetooth: hci_serdev: Fix HCI_UART_INIT_PENDING not working

Jian-Hong Pan (1):
      Bluetooth: btusb: Add a new Realtek 8723DE ID 2ff8:b011

Takashi Iwai (1):
      Bluetooth: btusb: Apply QCA Rome patches for some ATH3012 models

Thierry Escande (1):
      Bluetooth: hci_qca: Fix "Sleep inside atomic section" warning

Vaibhav Murkute (1):
      Bluetooth: hci_serdev: Removed unnecessary curly braces

 drivers/bluetooth/btmrvl_debugfs.c | 55 +++-----------------------------------
 drivers/bluetooth/btmrvl_drv.h     |  2 --
 drivers/bluetooth/btmrvl_main.c    |  6 -----
 drivers/bluetooth/btmrvl_sdio.c    | 11 +++++---
 drivers/bluetooth/btusb.c          | 43 ++++++++++++++++++++++++-----
 drivers/bluetooth/hci_bcm.c        | 10 +------
 drivers/bluetooth/hci_ldisc.c      | 22 ++++++++-------
 drivers/bluetooth/hci_ll.c         |  3 ---
 drivers/bluetooth/hci_nokia.c      |  3 ---
 drivers/bluetooth/hci_qca.c        |  2 +-
 drivers/bluetooth/hci_serdev.c     | 32 ++++++++++++++--------
 drivers/bluetooth/hci_uart.h       |  1 +
 net/bluetooth/hci_core.c           | 23 +++++-----------
 net/bluetooth/hci_debugfs.c        | 24 ++++++-----------
 net/bluetooth/smp.c                | 12 +++------
 15 files changed, 102 insertions(+), 147 deletions(-)

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbFRFEAAoJECQj9vv5qNQSN1AQAI/7J8xsfAx6OQzth0Uqc1WT
R3PYFRijbU7wNFUk5/9mrdl2r+azpLZaIPgHwKlVlBtZz66H3s67isf04mS9i89G
JL4TLVBmJHWIKE3T2i5SAm5BfqZT8JuZJN+rI/P5C565j5A7OPLqyw8i7TcXwosj
cBhpAcezcj7BznSK6ZRoc/9MRbI6zNGibP5uh5ChJTf/BnWkEOR0tFZMqRFABCot
HuFd7jGHkPgPE7fU8xts7Tk8J43/1/XXFhZOJg/GjK328/v9xNrH7Lo4HlcpW9sB
9EB3LZkvy4oQ80scpzoqZ9jVI7ZO1FsnyvwKY//Dx0HnleCqyazWTtMattkn7mzR
v4tRBhk2NQH7kfU3/QlVn50VZ4q8KUFwM43isNXdD/exNczQgVVR55r6bbk25cRU
cuSbFVD8xFiRwYCuDiiynQsVe5QTzdpMEZeXdtFP6+gi1ggYokR5a4PpHJ2qCwOu
HgadeS2XrMqC/tkZm4OzCttoMT41qR8bpqFy/ccMrwmHY6bktUu4YULxNGuJ8vho
pGSiRqx9g6jOJ3R7wRM9r1ts+AvFb0CEZW6gIdds9RRxogvpsH1F75SKlgWxkgsj
NxWxx4U7X4u7Edkc3EALzwNMdzBuwumNr4QMP2Q35PnVHQzuwjSs52VCIgOHIEdM
E3S2w9mL5QVv9l0spYWZ
=qmOe
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
