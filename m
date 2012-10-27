Return-Path: <cyrus@holtmann.org>
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>, marcel@holtmann.org
Cc: albert.o.ho@intel.com, tedd.hj.an@gmail.com, tedd.an@intel.com, johan.hedberg@intel.com
Subject: [RFC v2 0/2] Add driver extension for vendor device setup
Date: Fri, 26 Oct 2012 18:23:09 -0700
Message-ID: <1634868.4dWAuDVddg@tedd-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

These RFC patches adds drvier extension which allows vendors to execute
vendor specific device initialization (i.e. ROM patching) via vendor
supplied mini-driver.

It also includes a sample mini-driver.

Tedd Ho-Jeong An (2):
  Bluetooth: Add driver extension for vendor device setup
  Bluetooth: Add sample BT USB mini-driver

 drivers/bluetooth/btusb.c        |  197 +++++++++++++++++++++++++-------------
 drivers/bluetooth/btusb.h        |   53 ++++++++++
 drivers/bluetooth/btusb_sample.c |  189 ++++++++++++++++++++++++++++++++++++
 include/net/bluetooth/hci.h      |    2 +
 include/net/bluetooth/hci_core.h |    8 ++
 net/bluetooth/hci_core.c         |   28 +++++-
 6 files changed, 412 insertions(+), 65 deletions(-)
 create mode 100644 drivers/bluetooth/btusb.h
 create mode 100644 drivers/bluetooth/btusb_sample.c

-- 
1.7.9.5
