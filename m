Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/15] Bluetooth: Update to latest mgmt API
Date: Wed, 18 Jan 2012 20:51:42 +0200
Message-Id: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

These patches update the device_found and device_connected mgmt events
to correspond to the latest API. The patches should work with latest
user space git. There are also some bugfixes like the persistent flags
one and some cosmetic changes like the flags variable renames. Also,
sorry about the slightly big patch 13/15. I tried to look into splitting
it but didn't find any simple way.

Johan Hedberg (15):
      Bluetooth: Fix clearing persistent flags
      Bluetooth: Rename mgmt connected events to match user space
      Bluetooth: Add eir_len parameter to mgmt_ev_device_found
      Bluetooth: Rename eir_has_complete_name to eir_has_data_type
      Bluetooth: Add missing EIR defines to hci.h
      Bluetooth: Move eir_has_data_field to hci_core.h
      Bluetooth: Merge device class into the EIR data in mgmt_ev_device_found
      Bluetooth: Rename conn->pend to conn->flags
      Bluetooth: Merge boolean members of struct hci_conn into flags
      Bluetooth: Add a convenience function to check for SSP enabled
      Bluetooth: Convert hdev->ssp_mode to a flag
      Bluetooth: Convert hdev->out to a bool type
      Bluetooth: Update device_connected and device_found events to latest API
      Bluetooth: Rename hdev->flags to hdev->compat_flags
      Bluetooth: Rename hdev->dev_flags to hdev-flags

 drivers/bluetooth/bfusb.c        |   12 +-
 drivers/bluetooth/bpa10x.c       |   12 +-
 drivers/bluetooth/btmrvl_main.c  |    9 +-
 drivers/bluetooth/btusb.c        |   20 ++--
 drivers/bluetooth/hci_ldisc.c    |    6 +-
 drivers/bluetooth/hci_vhci.c     |    6 +-
 include/net/bluetooth/hci.h      |   29 ++--
 include/net/bluetooth/hci_core.h |   77 +++++++++---
 include/net/bluetooth/mgmt.h     |   25 ++--
 net/bluetooth/hci_conn.c         |   50 ++++----
 net/bluetooth/hci_core.c         |  101 ++++++++-------
 net/bluetooth/hci_event.c        |  264 ++++++++++++++++++++------------------
 net/bluetooth/hci_sock.c         |    8 +-
 net/bluetooth/l2cap_core.c       |    2 +-
 net/bluetooth/mgmt.c             |  166 +++++++++++++++----------
 net/bluetooth/smp.c              |   21 ++--
 16 files changed, 455 insertions(+), 353 deletions(-)

