Return-Path: <netdev-owner@vger.kernel.org>
Date: Fri, 18 May 2018 22:51:05 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: davem@davemloft.net
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: pull request: bluetooth-next 2018-05-18
Message-ID: <20180518195105.GA15231@x1c.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave,

Here's the first bluetooth-next pull request for the 4.18 kernel:

 - Refactoring of the btbcm driver
 - New USB IDs for QCA_ROME and LiteOn controllers
 - Buffer overflow fix if the controller sends invalid advertising data len=
gth
 - Various cleanups & fixes for Qualcomm controllers

Please let me know if there are any issues pulling. Thanks.

Johan

---
The following changes since commit 538e2de104cfb4ef1acb35af42427bff42adbe4d:

  Merge branch 'net-Allow-more-drivers-with-COMPILE_TEST' (2018-05-17 17:11=
:07 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t for-upstream

for you to fetch changes up to df2445bf77833674ebf790d2e6fcfd1d389b8a7b:

  Bluetooth: Add a new 13d3:3496 QCA_ROME device (2018-05-18 06:37:52 +0200)

----------------------------------------------------------------
Amit Pundir (1):
      Bluetooth: hci_qca: Avoid missing rampatch failure with userspace fw =
loader

Chriz Chow (1):
      Bluetooth: Prevent buffer overflow for large advertisement data

Fabio Estevam (1):
      Bluetooth: hci_ldisc: Provide a 'default' switch case

Hans de Goede (8):
      Bluetooth: hci_bcm: Add broken-irq dmi blacklist and add Meegopad T08=
 to it
      Bluetooth: hci_bcm: Remove irq-active-low DMI quirk for the Thinkpad 8
      Bluetooth: btbcm: Stop using upper nibble of rev to chose between uar=
t/USB paths
      Bluetooth: btbcm: Factor out common code to determine subversion
      Bluetooth: btbcm: Make btbcm_initialize() also work for USB connected=
 devices
      Bluetooth: btbcm: Allow using btbcm_initialize() for reinit
      Bluetooth: btbcm: Remove duplicate code from btbcm_setup_patchram()
      Bluetooth: btbcm: btbcm_initialize(): Initialize hw_name to "BCM"

John Keeping (1):
      Bluetooth: use wait_event API instead of open-coding it

Jo=E3o Paulo Rechi Vita (1):
      Bluetooth: Add a new 13d3:3496 QCA_ROME device

Loic Poulain (3):
      Bluetooth: btqcomsmd: Fix rx/tx stats
      Bluetooth: Add __hci_cmd_send function
      Bluetooth: btqca: Add AR3002 rampatch support

Srinivas Kandagatla (1):
      arm64: dts: apq8096-db820c: Enable wlan and bt en pins

Thierry Escande (3):
      arm64: dts: apq8096-db820c: enable bluetooth node
      dt-bindings: net: bluetooth: Add qualcomm-bluetooth
      Bluetooth: hci_qca: Add serdev support

Vic Wei (1):
      Bluetooth: btusb: add ID for LiteOn 04ca:301a

 .../devicetree/bindings/net/qualcomm-bluetooth.txt |  30 +++
 arch/arm64/boot/dts/qcom/apq8096-db820c-pins.dtsi  |  26 +++
 .../boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi    |  32 ++++
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi       |  61 +++++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |  10 +
 drivers/bluetooth/Kconfig                          |   1 +
 drivers/bluetooth/btbcm.c                          | 201 +++++++----------=
----
 drivers/bluetooth/btbcm.h                          |   5 +-
 drivers/bluetooth/btqca.c                          | 104 +++++------
 drivers/bluetooth/btqca.h                          |  11 +-
 drivers/bluetooth/btqcomsmd.c                      |  10 +
 drivers/bluetooth/btusb.c                          |   2 +
 drivers/bluetooth/hci_bcm.c                        |  35 ++--
 drivers/bluetooth/hci_ldisc.c                      |   2 +
 drivers/bluetooth/hci_qca.c                        | 116 +++++++++++-
 include/net/bluetooth/hci_core.h                   |   2 +
 net/bluetooth/hci_core.c                           |  31 ++++
 net/bluetooth/hci_event.c                          |  12 +-
 net/bluetooth/hci_request.c                        |  30 +--
 19 files changed, 480 insertions(+), 241 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/qualcomm-bluetoot=
h.txt

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJa/y6pAAoJECQj9vv5qNQSXUkP/iPOfCq4S5/XYarK+Qquw6Ov
+K6pQq+VBcOQa2EdUBYxDr3WfNQfjldWW+N0S1OOrAYZUACHh4KOqQtXxSb+lioP
Pqs16QIN210Qb19UQp9CUBNmDoSh02FTGDv3FDJxD3KrQTKq+1Qe4h6RcOobAms7
ocA46tBS9bhi6a2opujMEgkZFs81L6z/wKQl+pDLh7/X4q16VPRTEEKfM+JDMgub
y1GdDWVLW4nqv1FjMk2//TLt/csm4cAE/kjWjM13G+F137wD9K/n7CW3KTTanr2v
rvw9+fOYj//XimIVZXOHZ/0efmxwYfX79bysA+WBhsMCXkBCSLH96ecE7MIuCng6
BNHkqIxHmLCFhXHcay23sYt/Hc71DLTxvuhlauBE7tdLPeFJAiJ6i/jLzXzAqfp4
38QoG0evdsjIq1DBOpn+sjhxZc/a7LHn0CJo7wVkZSbFTTWjYhtaCk9mpBtkMReN
K+Yfko4uZbO2o+ZDgBrYOWpGgJk02nEb+BTRB7XB4VqP0CURXffHmEDTbxLcU6lp
5+YZX+2/YcvaFd/E0DdodNpaoofX+6NQZ+aN/zuUIxFJeZkWbPAunPK7bfn5IkEN
lVXAS+/UFVRaRBEHU+HfaOs8py76wkwAuxTiD91sF3kJskIQoNZZp6xpdD6mP+nX
zCbf+JC4zMuZEPFUHzhe
=O5N2
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
