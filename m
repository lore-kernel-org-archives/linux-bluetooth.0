Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com,
	marcel@holtmann.org,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 0/4] Integrate better device support
Date: Fri, 27 Jan 2012 16:47:22 +0100
Message-Id: <1327679246-2667-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

"struct device" provides a drvdata-field that we should use properly to save
_driver-data_. This series makes the hci-core use pointer-arithmetic to avoid
using this field in the bus-core and instead converts the drivers to use the
drvdata field.
This also reduces the hci_dev structure by 4/8 bytes, yeah.

This behavior is very common and I tried to stick to naming-conventions. See the
usb-bus or input-bus for other examples.

Regards
David

David Herrmann (4):
  Bluetooth: Introduce to_hci_dev()
  Bluetooth: Remove hci_dev->driver_data
  Bluetooth: Introduce to_hci_conn
  Bluetooth: Use proper datatypes in release-callbacks

 drivers/bluetooth/bfusb.c          |   10 ++++----
 drivers/bluetooth/bluecard_cs.c    |   12 ++++----
 drivers/bluetooth/bpa10x.c         |   18 +++++++-------
 drivers/bluetooth/bt3c_cs.c        |    6 ++--
 drivers/bluetooth/btmrvl_debugfs.c |   26 +++++++++----------
 drivers/bluetooth/btmrvl_main.c    |   10 ++++----
 drivers/bluetooth/btsdio.c         |   10 ++++----
 drivers/bluetooth/btuart_cs.c      |    6 ++--
 drivers/bluetooth/btusb.c          |   28 ++++++++++----------
 drivers/bluetooth/btwilink.c       |    8 +++---
 drivers/bluetooth/dtl1_cs.c        |    6 ++--
 drivers/bluetooth/hci_ldisc.c      |    6 ++--
 drivers/bluetooth/hci_vhci.c       |    8 +++---
 include/net/bluetooth/hci_core.h   |   14 ++++++++++-
 net/bluetooth/hci_sysfs.c          |   47 ++++++++++++++++-------------------
 15 files changed, 111 insertions(+), 104 deletions(-)

-- 
1.7.8.4
