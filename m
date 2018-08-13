Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 13 Aug 2018 18:00:19 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: davem@davemloft.net
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: pull request: bluetooth-next 2018-08-13
Message-ID: <20180813150019.GA2305@x1c.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dave,

There was one pretty bad bug that slipped into the MediaTek HCI driver
in the last bluetooth-next pull request. Would it be possible to get
this one-liner fix pulled to net-next before you make your first 4.19
pull request for Linus? Thanks.

Johan

---
The following changes since commit a487711aac3b720b4a3a63d737604f47cd8dc36c:

  Merge branch 'r8169-smaller-improvements' (2018-08-10 14:32:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git for-upstream

for you to fetch changes up to 330ad75f6a79d46f11f7bf8937852ebb4673b1d5:

  Bluetooth: mediatek: pass correct size to h4_recv_buf() (2018-08-13 15:59:39 +0200)

----------------------------------------------------------------
Dan Carpenter (1):
      Bluetooth: mediatek: pass correct size to h4_recv_buf()

 drivers/bluetooth/btmtkuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbcZ0DAAoJECQj9vv5qNQStGsQALuMXlcXtUGm+YWpM91zfAMR
Dt6HgTy2ck/kez4sWt7fsQtFkogI+yzJzoloDNQ4kSu/PbqHYtbNnbO6ofop9DBT
HaKwozD/wJjjKYtZt2Na3hzW95NZHXos3xWErHgB3dKsW4ukamTghlZwwnkqLhFh
u9tMyyxDkz8b4DbmorLAkXB1n5XEDjC/cKw0xyE2cKVQmnre30CdVRj6p2k4NdAw
hErQCRCVzGsECr0oJUDC00lNMjhNE7WmXySAqRx5fQojc8xfMEdjt6yLusCom6IA
XXbQ9z1WZgA6d5eNd4VOjSvmOMdZCWYgSOe9123d5OY9bLgJx7GLE+GpWBRLuWru
wSJ/QC25h/zncgvZYVt5oym9BN7nSKq+qc0pNHmn5p/3nUG7ay7tXJfV8H11rrYI
TpbZOYZKUNVKg71sCYT2EdFfnN+3z6o529GFW3qamh25Ajp3ef4xu+1snG1cy9t+
Tb2in9b1Gua80Epl829iGlZ0UF+NDBrbsZMN76Gen4xarUPpCmExadZQEnVo1cBV
MPom3lahNTbNgwMKCzvSapoyhPYn2KYBo6PaPX7Bsv0m/2SDTYbuPyHJWY9BVcd2
rQIAgwk4fOGreFl3rnot0KcOt3oyxXaSR42fGllecLhgM+i59dw22+FzrqfhBlre
0U1ZlX8htXBmMdSjf2R3
=5htf
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
