Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Thu, 23 Aug 2018 08:34:40 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: davem@davemloft.net
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: pull request: bluetooth 2018-08-23
Message-ID: <20180823053440.GA12312@x1c.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dave,

Here are two important Bluetooth fixes for the MediaTek and RealTek HCI
drivers.

Please let me know if there are any issues pulling, thanks.

Johan

---
The following changes since commit ab08dcd724543896303eae7de6288242bbaff458:

  rhashtable: remove duplicated include from rhashtable.c (2018-08-20 19:18:50 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git for-upstream

for you to fetch changes up to addb3ffbca66954fb1d1791d2db2153c403f81af:

  Bluetooth: mediatek: Fix memory leak (2018-08-21 16:56:20 +0200)

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      Bluetooth: mediatek: Fix memory leak

Hans de Goede (1):
      Bluetooth: Make BT_HCIUART_RTL configuration option depend on ACPI

 drivers/bluetooth/Kconfig     | 1 +
 drivers/bluetooth/btmtkuart.c | 8 +++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbfkdwAAoJECQj9vv5qNQSG2YQAK55gikW8lPaR7fKdiB4bfaJ
otQqYa8a+0y7OCIqYSOz5D/g1qX2rCaUuyIWey82VhCd8oe7BuywuAJ7U2ivZ2OC
By3ZWsss8A8v0F3CzyOFtpmmkbLLDfnhf1ssT5EARHfLQPMNuhceH7FtpaVvDfOw
v2gVlPDsuQBHk+cIUXxkWSO2PRiFCfVUHyrSZeni5zHIIg+Y/N/1IbffJhDqFBHV
rS+7KWb6vi4OoXwjm+w1iz6kq16ElH+Oj77oitNR184erqqGpT1lPNmas7/DJxTC
zh2uftyuC/sFGnwbd/jrR0ig2wGdZNLEePxuXdRxTYAm5pH4x/GYxBZmrUPyQGDT
erGl+f0cokqxUrBfnL2LT926knHltQCvx3D67kiS+tzI+Q/MWP1LiNeQ/X7QlPoE
jz6LGYOfxkjNkOfunuV2Alt8yqB+Tgxg0+Lwk26dZFNhA6pB2Yd3rA71fZsJw2Dt
DONRgRksCP5txKNLwhuXSSy8fDBpnk7A3jMlhcVEZADk/e2WoiEMq/4xlxJjvd+P
xHT+Mw27XfzUPa7neVWloT5qBVoPXBkX6w3cfyZF9HovreFLdsh9q/MxPxehb9a1
znqVH01eFqfdlkKMl1MJwtNTKylwgSOh6RSn/7IQKjGNmBgvACp8N0ThPbD8FFta
ZN5ctJmgBCzaKcVWRMRM
=K5ad
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
