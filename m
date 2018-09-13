Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Thu, 13 Sep 2018 12:45:51 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: davem@davemloft.net
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: pull request: bluetooth 2018-09-13
Message-ID: <20180913094551.GA14832@x1c.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dave,

A few Bluetooth fixes for the 4.19-rc series:

 - Fixed rw_semaphore leak in hci_ldisc
 - Fixed local Out-of-Band pairing data handling

Let me know if there are any issues pulling. Thanks.

Johan

---
The following changes since commit 7c5cca3588545e7f255171e28e0dd6e384ebb91d:

  qmi_wwan: Support dynamic config on Quectel EP06 (2018-09-10 10:48:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git for-upstream

for you to fetch changes up to e6a57d22f787e73635ce0d29eef0abb77928b3e9:

  Bluetooth: hci_ldisc: Free rw_semaphore on close (2018-09-11 13:33:57 +0200)

----------------------------------------------------------------
Hermes Zhang (1):
      Bluetooth: hci_ldisc: Free rw_semaphore on close

Johan Hedberg (1):
      Bluetooth: SMP: Fix trying to use non-existent local OOB data

Matias Karhumaa (1):
      Bluetooth: Use correct tfm to generate OOB data

 drivers/bluetooth/hci_ldisc.c |  2 ++
 net/bluetooth/smp.c           | 16 +++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbmjHPAAoJECQj9vv5qNQSEaQP/2U7rHZlzvK3Y6mo+LR/hEq6
IqWdMPQE+idb2nWFjzRbeGyaz292n0b/k5frDkU4dlLg4pt7jcRB8aWh0Y42Urgy
amKzRzXge51yHscVc1DxHmMR66efklos42XsggRza2w+GB2X1LbgZ1dD09uqg6mE
/duj32aMO0GYeaa2mRgNDweJ+VWrmiiJtG/5wCzqKpo6a/P3bqA78Z5izaK6wK78
Rj1bvC4XlyyRdSS5/c/Rw89hkx27C82i67U8ynJnRwcxFI7HZE4zYoPSW4yfaZAM
leVoieMz0ZYgVGJU2/+NiVhWo0YbQKjDkxyqBVL1ms9TIcbOW6vuP8Sn7094EHzg
WcK3Ylzl+DNjSSt0IKjMDJUT3un+XiqkPnGVFeP4UAprwIqhYjLG9kBwBCcVrxii
GLzNH/3hyFUnhAQHQoDwCJsSsijN+j/OVHiLxhMyf2FypAUl+TartVMiDnMA+VMi
ybpDMR/izBf/xkXpcJa+Bt+5c6UsEI7Ov6uw4lkjVi6LRxxuiiEN7CuAHReSw4hO
lZ3jpAa4aNySLdQDMqeWJT1bbNbZzsduwedcY7fosiXJCyaUr4uPYlhhXy6NqL2+
XsgHPzzgjawnu0A7xCQAXtEPj7v/GMFwost4mEXW10Z5hlL4GYj4mKj1TTMJ76uR
HafWUmkTxfNgPERv/3JB
=3GaB
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
