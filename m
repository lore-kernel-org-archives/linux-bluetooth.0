Return-Path: <netdev-owner@vger.kernel.org>
Date: Thu, 15 Feb 2018 10:33:59 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: davem@davemloft.net
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: pull request: bluetooth-next 2018-02-15
Message-ID: <20180215083359.GA593@x1c.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave,

Here's the first bluetooth-next pull request targetting the 4.17 kernel
release.

 - Fixes & cleanups to Atheros and Marvell drivers
 - Support for two new Realtek controllers
 - Support for new Intel Bluetooth controller
 - Fix for supporting multiple slave-role Bluetooth LE connections

Please let me know if there are any issues pulling. Thanks.

Johan

---
The following changes since commit 617aebe6a97efa539cc4b8a52adccd89596e6be0:

  Merge tag 'usercopy-v4.16-rc1' of git://git.kernel.org/pub/scm/linux/kern=
el/git/kees/linux (2018-02-03 16:25:42 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t for-upstream

for you to fetch changes up to 907f84990924bf3a8d248c040dabeb5127ae6938:

  Bluetooth: btrtl: Add RTL8723D and RTL8821C devices (2018-02-11 21:50:35 =
+0100)

----------------------------------------------------------------
Alex Lu (1):
      Bluetooth: btrtl: Add RTL8723D and RTL8821C devices

Jia-Ju Bai (3):
      Bluetooth: hci_ath: Replace mdelay with msleep in ath_wakeup_ar3k
      Bluetooth: btmrvl_main: Replace GFP_ATOMIC with GFP_KERNEL in btmrvl_=
send_sync_cmd
      Bluetooth: hci_ll: Replace mdelay with msleep in download_firmware

Larry Finger (1):
      Bluetooth: btusb: Add device ID for RTL8822BE

Maxim Zhukov (5):
      Bluetooth: ath3k: replace hardcode numbers with define
      Bluetooth: ath3k: do not init variables
      Bluetooth: ath3k: remove blank line after if
      Bluetooth: ath3k: Fix warning: quoted string split across lines
      Bluetooth: ath3k: fix checkpatch warning

Tedd Ho-Jeong An (1):
      Bluetooth: btusb: Add support for Intel Bluetooth device 22560 [8087:=
0026]

=C5=81ukasz Rymanowski (1):
      Bluetooth: Fix incorrect bits for LE states

 drivers/bluetooth/ath3k.c       |  28 ++++++----
 drivers/bluetooth/btmrvl_main.c |   2 +-
 drivers/bluetooth/btrtl.c       | 119 ++++++++++++++++++++++++++++--------=
----
 drivers/bluetooth/btusb.c       |  10 ++++
 drivers/bluetooth/hci_ath.c     |   4 +-
 drivers/bluetooth/hci_ll.c      |   2 +-
 net/bluetooth/hci_request.c     |   6 +-
 7 files changed, 118 insertions(+), 53 deletions(-)

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJahUX3AAoJECQj9vv5qNQSkX4P/A0iPJL9cXO0ipIJd3NLGDO1
YXVnqOJefnP9KYxKK0An12SM7uYMH+qWySgnEzzw6ZTyJ6XZNLXbfxhInotEMEKv
Zt55RX+eNct9hoK8Hm8jFEa4X1U/DhYdSbSUf21HGzKVgM1prbhdpavmBPPEEeuw
vHcjW9U5r9p/pAtKQfnq/W9o8swnTyzgG6zADyWjcoih+33aAid9FZAU6ii8bi1i
5H5D+sPm+8wFuMVTQjKVK9KzmiyGeMYBenf1AmhGa20Sw/BooXojeyqQFmW6B+VS
NZsPuNgPfTcd4Yrdp0NFGROdA0+ZDrcHKwx13EfJwchE3+Whv1rZDCoo0MuDWpXB
U2rKcSRrV50esoKE6iLNrEQYp5zO3la74AO8NLjfy5zv8x/i7+3yCQ2OeiW7l1O4
Jmf4dhhwm60msRcY8wyNJKGwKd2gwyYFtT/hyt13lbsSe+bR1lcWIcH5eQyokxmk
+ZlZIgAQ0nai5tMhiV4typ1XahzM8X3l4VFFvvX4fTl5mmUY76k4ycAiGhnED2NA
bb4GxGAgKTloHV/o4igyNLHo0Ptyv1Fm3KD+rVfqoC+N13+EMDqACVlnSWUZc/4J
nHj2xX6QZ0vfIg1C+m8tCWLRjIEGPOuHdDiONXhS75HzM/llxmxzb8pWNQTcchFB
bK/5edchfFHVFIgH0Uy2
=ay3F
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
