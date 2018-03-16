Return-Path: <netdev-owner@vger.kernel.org>
Date: Fri, 16 Mar 2018 11:23:19 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: davem@davemloft.net
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: pull request: bluetooth 2018-03-16
Message-ID: <20180316182319.GA4401@x1c>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dave,

Here are a few more important Bluetooth driver fixes for the 4.16
kernel.

Please let me know if there are any issues pulling. Thanks.

Johan

---
The following changes since commit 3d502067599f0db12e74e6646aee8728efe3e5be:

  net/smc: simplify wait when closing listen socket (2018-03-15 09:49:13 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git for-upstream

for you to fetch changes up to e07c99b07ae85255d5c5bc2480fbd4c4e77f71bc:

  Bluetooth: hci_bcm: Set pulsed_host_wake flag in sleep parameters (2018-03-15 19:39:37 +0100)

----------------------------------------------------------------
Hans de Goede (2):
      Revert "Bluetooth: hci_bcm: Streamline runtime PM code"
      Bluetooth: hci_bcm: Set pulsed_host_wake flag in sleep parameters

Takashi Iwai (1):
      Bluetooth: btusb: Fix quirk for Atheros 1525/QCA6174

 drivers/bluetooth/btusb.c   |  2 +-
 drivers/bluetooth/hci_bcm.c | 13 +++++++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJarAuXAAoJECQj9vv5qNQS+VoQAKYbDFKbF634icA1fe6Xt1/j
5kbPuBOAgXWzASjcHjbvg72xQv59UF4e3yGO6U/pSyGDRQq5MkXUz01oUrtviN/O
18NGhWNcWEIdpzusggEeWJW6NO6+58AOw89J/q762yTpSjCp9y10YhvyvutTfvUg
RnMaaE0MhRRpx73PvzhUTwPNmLOoXYmVwJG/EZeSyrx4YflhT1cxq/cTeCGyMLoe
2Y8MfqlC/Goq2DEKjSqshRjkbykJoqyt4X/qQZ3pFjs1Cb3+sZTb8l/K/CgAdjvt
QuJhbu8EdOW1aryfu6TKAqYUp0O1FRWRU3DVV2s1g+qVi+zQz442GUcGVzmR9JYU
lK2xImxEfXo6OAdBPz+lOAyBPIXbYlDot5wDNlCzX82Vgeu/EFxWTqQGk3UABvBx
XOCQzsEsdXI/JQon3U2AXhloAcs+A7pU3598WLZ3QnRtwViKYCW9+U+F5U0+L3Mh
0DXExEx8t3A+7GAWtLBdKvf0ysKkzv01SbhkMkOR/cn5ObyCKgIqH1qIBZtH4nRr
VTk0lbD28q+SRt8eVHQib5twfPagm9SKY03dsTP8qKhJAIa6hJB10UEpvF1oFNZm
OaxvAPOpjiVe28WdVD2xtzrbxeFwwxMKtc94vSmUkUJCvxUAVTJNwMCZTbJKwjAG
yQrosIO4QhMztEJb+Dvf
=DkU1
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
