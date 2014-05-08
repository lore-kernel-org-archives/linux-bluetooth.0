Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 0/8] Get Connection Information
Date: Thu, 8 May 2014 15:32:07 +0200
Message-ID: <1399555935-702-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here are patches which implement Get Connection Information mgmt command.
Patches 1-7 provide implementation based on API v2 and I added separate
patch (8) which updates to API v3 to make it easier to spot differences
between v2 and v3 API.

Addition of max TX power level is due to proposed device property with
this value exposed and it seems convenient to retrieve this value using
new Connection Information API.

As for now both RSSI and TX power level are read on request - it's much
simpler this way and later it can be modified to refresh only what is
required for specific request, i.e. refresh only RSSI if TX power level
was not requested.


Andrzej Kaczmarek (8):
  Bluetooth: Store RSSI for connection
  Bluetooth: Store TX power level for connection
  Bluetooth: Move eir_append_data up
  Bluetooth: Add support for user data in hci_request
  Bluetooth: Add support to get connection information
  Bluetooth: Make min interval for connection information configurable
  Bluetooth: Avoid pooling TX power for LE links
  Bluetooth: Add support for max_tx_power in Get Conn Info

 include/net/bluetooth/bluetooth.h |   3 +-
 include/net/bluetooth/hci.h       |  23 +++
 include/net/bluetooth/hci_core.h  |  11 +-
 include/net/bluetooth/mgmt.h      |  17 +++
 net/bluetooth/hci_conn.c          |   6 +-
 net/bluetooth/hci_core.c          |  33 +++--
 net/bluetooth/hci_event.c         |  68 +++++++++
 net/bluetooth/mgmt.c              | 295 +++++++++++++++++++++++++++++++-------
 8 files changed, 391 insertions(+), 65 deletions(-)

-- 
1.9.2

