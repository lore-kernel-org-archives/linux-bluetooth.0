Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v4 0/5] Bluetooth: Get Connection Information
Date: Wed, 14 May 2014 12:49:38 +0200
Message-ID: <1400064583-12623-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Changes in v4:
- include max_tx_power when declaring structs for 1st time, request will
  just reply with HCI_TX_POWER_INVALID without other patches for max_tx_power
- fixed debugfs to have basic validation


Andrzej Kaczmarek (5):
  Bluetooth: Add conn info lifetime parameters to debugfs
  Bluetooth: Add support to get connection information
  Bluetooth: Avoid polling TX power for LE links
  Bluetooth: Store max TX power level for connection
  Bluetooth: Add support for max_tx_power in Get Conn Info

 include/net/bluetooth/hci_core.h |   9 ++
 include/net/bluetooth/mgmt.h     |  14 +++
 net/bluetooth/hci_conn.c         |   1 +
 net/bluetooth/hci_core.c         |  63 ++++++++++++
 net/bluetooth/hci_event.c        |  12 ++-
 net/bluetooth/mgmt.c             | 213 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 311 insertions(+), 1 deletion(-)

-- 
1.9.3

