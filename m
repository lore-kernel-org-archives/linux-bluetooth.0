Return-Path: <john@metanate.com>
From: John Keeping <john@metanate.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	John Keeping <john@metanate.com>
Subject: [PATCH v2 0/3] Bluetooth: Fail gracefully if device doesn't support pairing
Date: Tue, 13 Jun 2017 17:28:56 +0100
Message-Id: <20170613162859.25769-1-john@metanate.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This has grown from the original RFC patch [1] after Marcel pointed out
that mgmt_auth_failed() should be taking a MGMT_STATUS_ value instead of
an HCI error code.

The aim of the series is to allow us to fail gracefully when we detect a
device does not support pairing.  Since it is impossible to tell whether
a device supports pairing or not without attempting to pair with it, we
must handle the "pairing not support" error specially and avoid dropping
the connection in this case.

Converting the other mgmt function that take a status code to map from
HCI to MGMT_STATUS_ in the caller is left for a future series.

A corresponding bluetoothd change is needed to allow clients to detect
that pairing has failed because it is not supported by the device; I
will send a patch for this once the kernel change is accepted.  Existing
versions of bluetoothd will return a generic "Authentication Failed"
error as they do now.

[1] https://www.spinics.net/lists/linux-bluetooth/msg70600.html

John Keeping (3):
  Bluetooth: make mgmt_status() public
  Bluetooth: pass MGMT_STATUS_* into mgmt_auth_failed()
  Bluetooth: SMP: Fail gracefully if device doesn't support pairing

 include/net/bluetooth/hci_core.h |  4 +++-
 net/bluetooth/hci_event.c        |  4 ++--
 net/bluetooth/mgmt.c             |  9 ++++-----
 net/bluetooth/smp.c              | 23 ++++++++++++++++++++---
 4 files changed, 29 insertions(+), 11 deletions(-)

-- 
2.12.2.648.g6730d8bc62.dirty
