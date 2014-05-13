Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v3 0/5] Bluetooth: Get Connection Information
Date: Tue, 13 May 2014 11:52:26 +0200
Message-ID: <1399974751-7226-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Changes in v3:
- max TX power patches split as requested
- conn info age configurable by min/max values and actual value is randomized
- commands order changes to be RSSI, TX power and TX power max
- removed queueing of requests - we'll only have one pending request per
  connection and reply from cache for others
- request can only fail if reading RSSI failed, otherwise it's considered ok
  and HCI_TX_POWER_INVALID is returned as TX power values


Andrzej Kaczmarek (5):
  Bluetooth: Add conn info lifetime parameters to debugfs
  Bluetooth: Add support to get connection information
  Bluetooth: Avoid polling TX power for LE links
  Bluetooth: Store max TX power level for connection
  Bluetooth: Add support for max_tx_power in Get Conn Info

 include/net/bluetooth/hci_core.h |   9 ++
 include/net/bluetooth/mgmt.h     |  14 +++
 net/bluetooth/hci_conn.c         |   1 +
 net/bluetooth/hci_core.c         |   7 ++
 net/bluetooth/hci_event.c        |  12 ++-
 net/bluetooth/mgmt.c             | 213 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 255 insertions(+), 1 deletion(-)

-- 
1.9.3

