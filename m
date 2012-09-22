Return-Path: <cyrus@holtmann.org>
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>, marcel@holtmann.org
Cc: johan.hedberg@intel.com, albert.o.ho@intel.com, tedd.hj.an@gmail.com
Subject: [RFC 0/2] Bluetooth: Add support for BT USB mini driver for vendeor specific init
Date: Fri, 21 Sep 2012 18:59:48 -0700
Message-ID: <2779254.RSEHOMBi2B@tedd-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

These RFC patches allow vendors to add their own BT USB mini driver to
configure the device before the BT stack sends common device
initialization.

Tedd Ho-Jeong An (2):
  Bluetooth: Add driver extension for vendor specific init
  Bluetooth: Add BT USB mini driver template

 drivers/bluetooth/Makefile         |    1 +
 drivers/bluetooth/btusb.c          |  194 ++++++++++++++++++++++++------------
 drivers/bluetooth/btusb.h          |   53 ++++++++++
 drivers/bluetooth/btusb_template.c |   78 +++++++++++++++
 include/net/bluetooth/hci_core.h   |   10 ++
 net/bluetooth/hci_core.c           |   15 ++-
 6 files changed, 286 insertions(+), 65 deletions(-)
 create mode 100644 drivers/bluetooth/btusb.h
 create mode 100644 drivers/bluetooth/btusb_template.c

-- 
1.7.9.5
