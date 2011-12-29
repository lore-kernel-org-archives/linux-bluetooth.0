Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	padovan@profusion.mobi,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 0/5] Fix driver core registration
Date: Thu, 29 Dec 2011 16:40:37 +0100
Message-Id: <1325173242-12264-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset correctly integrates the "struct device" in a hci_dev. It removes
the refcnt field and instead relies on the internal refcount of device objects.
It also removes the "destruct" callback as it is really not needed. The bus is
responsible of freeing devices after a driver unregistered itself.

This also fixes several bugs in the current implementation. Each patch should be
pretty straightforward. It all works well on my machine.

Regards
David

David Herrmann (5):
  Bluetooth: Remove obsolete hci-destruct callback
  Bluetooth: Correctly acquire module reference
  Bluetooth: Remove HCI-owner field
  Bluetooth: Correctly take hci_dev->dev refcount
  Bluetooth: Remove __hci_dev_put/hold

 drivers/bluetooth/bfusb.c        |   13 +------------
 drivers/bluetooth/bluecard_cs.c  |    8 --------
 drivers/bluetooth/bpa10x.c       |   17 +++--------------
 drivers/bluetooth/bt3c_cs.c      |    8 --------
 drivers/bluetooth/btmrvl_main.c  |    6 ------
 drivers/bluetooth/btsdio.c       |   13 +------------
 drivers/bluetooth/btuart_cs.c    |    8 --------
 drivers/bluetooth/btusb.c        |   17 +++--------------
 drivers/bluetooth/btwilink.c     |   10 ----------
 drivers/bluetooth/dtl1_cs.c      |    8 --------
 drivers/bluetooth/hci_ldisc.c    |   13 +------------
 drivers/bluetooth/hci_vhci.c     |    9 +--------
 include/net/bluetooth/hci_core.h |   30 +++++-------------------------
 net/bluetooth/hci_core.c         |   15 +++++++++------
 net/bluetooth/hci_sysfs.c        |    8 +++++++-
 15 files changed, 31 insertions(+), 152 deletions(-)

-- 
1.7.8.1
