Return-Path: <netdev-owner@vger.kernel.org>
Date: Mon, 26 Feb 2018 12:43:07 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: davem@davemloft.net
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: pull request: bluetooth 2018-02-26
Message-ID: <20180226114307.GA10612@x1c>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dave,

Here are a two Bluetooth driver fixes for the 4.16 kernel.

Please let me know if there are any issues pulling. Thanks.

Johan

---
The following changes since commit 9cb9c07d6b0c5fd97d83b8ab14d7e308ba4b612f:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-02-23 15:14:17 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git for-upstream

for you to fetch changes up to ab2f336cb7e629de74d8af06bcaf6b15e4230e19:

  Bluetooth: hci_bcm: Make shutdown and device wake GPIO optional (2018-02-25 21:08:28 +0100)

----------------------------------------------------------------
Hans de Goede (1):
      Bluetooth: btusb: Use DMI matching for QCA reset_resume quirking

Stefan Wahren (1):
      Bluetooth: hci_bcm: Make shutdown and device wake GPIO optional

 drivers/bluetooth/btusb.c   | 25 +++++++++++++++++++------
 drivers/bluetooth/hci_bcm.c |  7 ++++---
 2 files changed, 23 insertions(+), 9 deletions(-)

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJak/LLAAoJECQj9vv5qNQSpnYQAKfc8+UH6vgD59bJe4S/ZKXK
Fuo3GJPNev4si6fVZMiEY1I/X504JWNd5Zrk36U7jMcCBcwwixyGoFlTFrDa5rDF
x54eyI25GVbt/mmyEGU0Lb9J3DcjOtfeCs0M8lXvEjU1jeayF2rFa+2UoJEO+fN1
U5I+XoD0Ownrks/BEsmPrZMTF+1PJAhyEDD8F4qp4/Im7oCNzFDXF2EcNdfyH58W
ok73nuvgbuM5UT55bDglwMxPtk++pv+srf/NIpHykfF8GveTXbucdYI0QiH2rvPC
lG8S15h//MwRGw3Pbwh0CMN2tCwJ+v0SEkzXA8j34kaPYF8SJENHOev1TEcMpFTI
rZEgenCME56UZwLmWlFkhIo7sK4y7/44P+mrwdqlObPbXm5T+w546Utofb7WeXD/
lOUS4eVL/DXkCgabRnrx7RePtAO9C+mxo0XS881DTzkaxgeOAoyD7fL5vHC6leun
xfFUSP5nkOQkEzoMBpKEz37YVKLbiYVXwOelzq9tGdbJ6rhTCkjhdTQzkdaaR6iq
/w/XTRbMsJjL4GX1FIQtJRVf6UlB66dIO5HhAmLYIpX/3PbkrQSePeq149gOFUDN
Z4eUuXtyZ/YSSF0yQfp/pCU94ONxJatpou+h3pxIvbXcrfJmNDFdSaVrmm9B0aFv
IcVDwkkkT3Ree2nYT3+I
=utKz
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
