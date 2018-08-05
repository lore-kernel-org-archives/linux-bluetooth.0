Return-Path: <netdev-owner@vger.kernel.org>
Date: Sun, 5 Aug 2018 09:14:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: davem@davemloft.net
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: pull request: bluetooth-next 2018-08-05
Message-ID: <20180805061430.GA14496@x1c.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dave,

Here's the main bluetooth-next pull request for the 4.19 kernel.

 - Added support for Bluetooth Advertising Extensions
 - Added vendor driver support to hci_h5 HCI driver
 - Added serdev support to hci_h5 driver
 - Added support for Qualcomm wcn3990 controller
 - Added support for RTL8723BS and RTL8723DS controllers
 - btusb: Added new ID for Realtek 8723DE
 - Several other smaller fixes & cleanups

Please let me know if there are any issues pulling. Thanks.

Johan

---
The following changes since commit ab8565af68001ac5f9331daa311938ead3eb5636:

  Merge branch 'IP-listification-follow-ups' (2018-07-06 11:19:08 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git for-upstream

for you to fetch changes up to 6c3711ec64fd23a9abc8aaf59a9429569a6282df:

  Bluetooth: h5: Fix missing dependency on BT_HCIUART_SERDEV (2018-08-04 23:23:32 +0200)

----------------------------------------------------------------
Amit K Bag (1):
      Bluetooth: btusb: Release RF resource on BT shutdown

Ankit Navik (2):
      Bluetooth: Store Resolv list size
      Bluetooth: Add HCI command for clear Resolv list

Balakrishna Godavarthi (7):
      dt-bindings: net: bluetooth: Add device tree bindings for QTI chip wcn3990
      Bluetooth: btqca: Rename ROME specific functions to generic functions
      Bluetooth: btqca: Redefine qca_uart_setup() to generic function.
      Bluetooth: hci_qca: Add wrapper functions for setting UART speed
      Bluetooth: hci_qca: Enable 3.2 Mbps operating speed.
      Bluetooth: btqca: Add wcn3990 firmware download support.
      Bluetooth: hci_qca: Add support for Qualcomm Bluetooth chip wcn3990

Corentin Labbe (1):
      Bluetooth: remove unused bt-nokia-h4p.h header

Hans de Goede (4):
      Bluetooth: btrtl: Use rtl_dev_err and rtl_dev_info
      Bluetooth: btrtl: Add support for a config filename postfix
      Bluetooth: hci_h5: Add support for serdev enumerated devices
      Bluetooth: hci_h5: Add support for enable and device-wake GPIOs

Jaganath Kanakkassery (21):
      Bluetooth: Introduce helpers for LE set scan start and complete
      Bluetooth: Use extended scanning if controller supports
      Bluetooth: Process extended ADV report event
      Bluetooth: Introduce helpers for le conn status and complete
      Bluetooth: Use extended LE Connection if supported
      Bluetooth: Define PHY flags in hdev and set 1M as default
      Bluetooth: Add defines for BREDR pkt_type and LE PHYs
      Bluetooth: Implement Get PHY Configuration mgmt command
      Bluetooth: Implement Set PHY Confguration command
      Bluetooth: Implement PHY changed event
      Bluetooth: Set Scan PHYs based on selected PHYs by user
      Bluetooth: Handle extended ADV PDU types
      Bluetooth: Use selected PHYs in extended connect
      Bluetooth: Read no of adv sets during init
      Bluetooth: Impmlement extended adv enable
      Bluetooth: Use Set ext adv/scan rsp data if controller supports
      Bluetooth: Implement disable and removal of adv instance
      Bluetooth: Use ext adv for directed adv
      Bluetooth: Implement Set ADV set random address
      Bluetooth: Handle ADv set terminated event
      Bluetooth: Implement secondary advertising on different PHYs

Jeremy Cline (2):
      Bluetooth: hci_h5: Add vendor setup, open, and close callbacks
      Bluetooth: hci_h5: Add support for the RTL8723BS

Jia-Ju Bai (7):
      bluetooth: bfusb: Replace GFP_ATOMIC with GFP_KERNEL in bfusb_send_frame()
      bluetooth: bluecard_cs: Replace GFP_ATOMIC with GFP_KERNEL in bluecard_hci_set_baud_rate()
      bluetooth: bpa10x: Replace GFP_ATOMIC with GFP_KERNEL in bpa10x_send_frame()
      bluetooth: btmrvl_sdio: Replace GFP_ATOMIC with GFP_KERNEL in btmrvl_sdio_card_to_host()
      bluetooth: btusb: Replace GFP_ATOMIC with GFP_KERNEL in inject_cmd_complete()
      bluetooth: hci_intel: Replace GFP_ATOMIC with GFP_KERNEL in inject_cmd_complete()
      bluetooth: hci_qca: Replace GFP_ATOMIC with GFP_KERNEL

Jian-Hong Pan (1):
      Bluetooth: Add a new Realtek 8723DE ID 0bda:b009

Johan Hedberg (1):
      Bluetooth: h5: Fix missing dependency on BT_HCIUART_SERDEV

Marcel Holtmann (2):
      Bluetooth: hidp: Fix handling of strncpy for hid->name information
      Bluetooth: btusb: Use bt_dev_err for Intel firmware loading errors

Mark Salyzyn (1):
      Bluetooth: hidp: buffer overflow in hidp_process_report

Martin Blumenstingl (4):
      Bluetooth: btrtl: add MODULE_FIRMWARE declarations
      Bluetooth: btrtl: split the device initialization into smaller parts
      Bluetooth: btrtl: add support for retrieving the UART settings
      Bluetooth: btrtl: add support for the RTL8723BS and RTL8723DS chips

Michael Scott (1):
      6lowpan: iphc: reset mac_header after decompress to fix panic

Philipp Puschmann (1):
      Bluetooth: Use lock_sock_nested in bt_accept_enqueue

Sean Wang (1):
      Bluetooth: Add new quirk for non-persistent setup settings

Sebastian Andrzej Siewior (1):
      Bluetooth: btusb: use irqsave() in URB's complete callback

Sudip Mukherjee (1):
      Bluetooth: avoid killing an already killed socket

 .../devicetree/bindings/net/qualcomm-bluetooth.txt |  29 +-
 drivers/bluetooth/Kconfig                          |   1 +
 drivers/bluetooth/bfusb.c                          |   2 +-
 drivers/bluetooth/bluecard_cs.c                    |   2 +-
 drivers/bluetooth/bpa10x.c                         |   6 +-
 drivers/bluetooth/btmrvl_sdio.c                    |   2 +-
 drivers/bluetooth/btqca.c                          | 117 ++--
 drivers/bluetooth/btqca.h                          |  22 +-
 drivers/bluetooth/btrtl.c                          | 512 ++++++++++++-----
 drivers/bluetooth/btrtl.h                          |  53 ++
 drivers/bluetooth/btusb.c                          | 116 ++--
 drivers/bluetooth/hci_h5.c                         | 202 ++++++-
 drivers/bluetooth/hci_intel.c                      |   2 +-
 drivers/bluetooth/hci_qca.c                        | 490 ++++++++++++++--
 include/linux/platform_data/bt-nokia-h4p.h         |  38 --
 include/net/bluetooth/hci.h                        | 219 ++++++++
 include/net/bluetooth/hci_core.h                   |  34 ++
 include/net/bluetooth/mgmt.h                       |  55 ++
 net/6lowpan/iphc.c                                 |   1 +
 net/bluetooth/af_bluetooth.c                       |   2 +-
 net/bluetooth/hci_conn.c                           | 189 +++++--
 net/bluetooth/hci_core.c                           | 105 +++-
 net/bluetooth/hci_debugfs.c                        |  19 +
 net/bluetooth/hci_event.c                          | 554 +++++++++++++++---
 net/bluetooth/hci_request.c                        | 616 ++++++++++++++++++---
 net/bluetooth/hci_request.h                        |   8 +
 net/bluetooth/hidp/core.c                          |   6 +-
 net/bluetooth/mgmt.c                               | 405 +++++++++++++-
 net/bluetooth/sco.c                                |   3 +-
 29 files changed, 3236 insertions(+), 574 deletions(-)
 delete mode 100644 include/linux/platform_data/bt-nokia-h4p.h

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbZpXGAAoJECQj9vv5qNQST48QALu0jwGi5jnx/xJP9ZeWA9m1
rKpb/bVEeliLjA06rBAXueDRFTCukjUMvqikh1VD2eATJzTxL+GRH+T1BxN1IZHT
PRmmHJfNCUPn7YtQQGfBFmYOlaGTvk/DF/Gkf27+F3Rz+fCS7WFClJg4bC06b3Ry
J6PcyDH89+Nub4E376akT85MEJ9/Fw2a8n2heIpLYRjIeNl8KtRHn7CYLsmYbMoh
/yBGNOFtXWiuhlH62DQN1MxFOJFLVKzg1M9L65cav6ZzWRHxHyJ2fd0Nlw7kCDHY
25jFeu6y1yX8sW/aDiYM7NVZwd16vOUn8Uw8Kr5BoVo6LdWq2OQJm8E0Aqz9ij8G
kX0+/KS33PcmicXhx2wSnkLiKlmi+lpMselT4mZ4CWMAh6GrO2UwaRTUvt6eT5fe
VGDX6rsNf8bUujPKkmY1ktBIDt5FDmUa/NKVEewLnnYkli9GmhZppr3qszjegLYF
Hk7AsmACKA6AqAv3+k0XpFy+x/r19eHLI3oNyA/CTHqZ73XX4UrOdE7WDLsGgsuD
cQm3euMgYpLKYymkV5/1yv57Ua/2KgfoTMmGPAU00/3iPViWQU570eCUOLdW9bxr
mMXixR1EUchjTFXz/4NpxO1VbR09D23/bHxOnEUsj79UkN91c62foM1+oERg1bxZ
SmUl1YPIsX7t9D2lFPbw
=piRj
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
