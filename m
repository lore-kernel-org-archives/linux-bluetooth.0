Return-Path: <cyrus@holtmann.org>
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Cc: marcel <marcel@holtmann.org>, albert.o.ho@intel.com
Subject: [RFC 0/3] Support for Intel BT USB driver
Date: Mon, 10 Sep 2012 15:34:51 -0700
Message-ID: <1860916.qXTngGPbFd@tedd-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

These set of patches adds Intel BT USB support.  The patch adds an extension
to execute of vendor specific initialization at early stage (before normal
BT controller initialization & after the USB is initialized).

- During the USB probe time, if the VID/PID are matched, it executes a
  vendor specific initialization routine and uses a vendor specific HCI
  event handler.  When completed, the existing HCI event handler is restored. 

- When vendor specific initialization completes, normal BT controller
  initialization continues.

The rest of patches are Intel specific implementation.

Tedd Ho-Jeong An (3):
  Bluetooth: Add initial skeleton for Intel BT USB support
  Bluetooth: Implement Intel specific device initialization
  Bluetooth: Add timeout for Intel specific device initialization

 drivers/bluetooth/Makefile       |    2 +-
 drivers/bluetooth/btusb.c        |   29 +++
 drivers/bluetooth/btusb.h        |   31 +++
 drivers/bluetooth/btusb_intel.c  |  420 ++++++++++++++++++++++++++++++++++++++
 include/net/bluetooth/hci_core.h |    6 +
 net/bluetooth/hci_core.c         |   16 ++
 6 files changed, 503 insertions(+), 1 deletion(-)
 create mode 100644 drivers/bluetooth/btusb.h
 create mode 100644 drivers/bluetooth/btusb_intel.c

-- 
1.7.9.5
