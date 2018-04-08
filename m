Return-Path: <netdev-owner@vger.kernel.org>
Date: Sun, 8 Apr 2018 20:47:02 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: davem@davemloft.net
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: pull request: bluetooth 2018-04-08
Message-ID: <20180408174702.GA11420@x1c.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dave,

Here's one important Bluetooth fix for the 4.17-rc series that's needed
to pass several Bluetooth qualification test cases.

Let me know if there are any issues pulling. Thanks.

Johan

---
The following changes since commit b5dbc28762fd3fd40ba76303be0c7f707826f982:

  Merge tag 'kbuild-fixes-v4.16-3' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild (2018-03-30 18:53:57 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git for-upstream

for you to fetch changes up to 082f2300cfa1a3d9d5221c38c5eba85d4ab98bd8:

  Bluetooth: Fix connection if directed advertising and privacy is used (2018-04-03 16:12:56 +0200)

----------------------------------------------------------------
Szymon Janc (1):
      Bluetooth: Fix connection if directed advertising and privacy is used

 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/hci_conn.c         | 29 +++++++++++++++++++++--------
 net/bluetooth/hci_event.c        | 15 +++++++++++----
 net/bluetooth/l2cap_core.c       |  2 +-
 4 files changed, 34 insertions(+), 14 deletions(-)

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJaylWWAAoJECQj9vv5qNQSEyoP/jW/DhCgrmJX6hCI5lESqbkq
lForCLUurc5cI3JLuy8y3yPzHJ2ifxDPkRV38c9ZLrvtelPlspMxMLLbMKak4nwt
lLjaLL21aWCqOHKIpUmz9AVeSTAzCUseVHyrov4ALVCbyeg5LKh7FiafKtJYuHVK
Hy6o/qoQ2fkGv7L2tK8VpjEbWE/6H9idL9zAvavoMmOS3hxcGaNMqUI1bI0wB9kb
/s8AOXj77OCeIDfbNuWkI8SB5XAHqLYiPBSj/P+lIRSeO0P5oxpCRWj2hupUrte4
C29XWBqWhmjpMclZ4bAiviR9nMlmlQlhba429nU6F8h/NPSXTeM9pkHTYb9hTAI2
DdRoCFeZhM9Uu2Tekq2+7z1FNrFddzYQ1SkuwHn9lrPY1zXI8z1gsOO4J25pi/IV
+hS3s04oE+9j+wr+uBPfrV2AobLp2oQMMAJxeeG2vGqQXV+lAxdcD2vhYGTtAh7Y
/8PKx0ZOoQXbz5oY685jEefY74sVaWFhntj7871WrrO1+oPg13iXFhHiH4oyvCTc
yupJO8dH6psCwFjp5uKpA8sUV9Y6TJdQwVZs++/ZA2vmER51C3LeS07ZtgJCF+Th
E7ySmEMa/KvFOBsL8SoCBMCCVynge0OAairaCLFGI9Rr5E70Tk+2Ps7qM1vWDTDI
dAQV3XFGiaVQXGCJsLQk
=S+wp
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
