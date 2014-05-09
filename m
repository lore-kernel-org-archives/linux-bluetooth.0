Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 0/6] Get Connection Information
Date: Fri,  9 May 2014 21:35:27 +0200
Message-Id: <1399664133-2892-1-git-send-email-andrzej.kaczmarek@tieto.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here are v2 patches which implement Get Connection Information mgmt command.
As in v1, patches 1-5 provide implementation based on API v2 and patch 6
updates to API v3.


Changes in v2:
- fixed comments regarding naming
- removed hci_request patch and used hci_sent_cmd_data() to retrieve hci_conn
  it works fine and code is quite simple, but it looks a bit hackish imo
- some functions are renamed and comments added, hopefully request flow is
  now easier to follow


Andrzej Kaczmarek (6):
  Bluetooth: Store TX power level for connection
  Bluetooth: Move eir_append_data up
  Bluetooth: Add support to get connection information
  Bluetooth: Make max age for connection information configurable
  Bluetooth: Avoid pooling TX power for LE links
  Bluetooth: Add support for max_tx_power in Get Conn Info

 include/net/bluetooth/hci.h      |  11 ++
 include/net/bluetooth/hci_core.h |   8 ++
 include/net/bluetooth/mgmt.h     |  17 +++
 net/bluetooth/hci_conn.c         |   2 +
 net/bluetooth/hci_core.c         |   4 +
 net/bluetooth/hci_event.c        |  45 +++++++
 net/bluetooth/mgmt.c             | 250 +++++++++++++++++++++++++++++++++++++--
 7 files changed, 326 insertions(+), 11 deletions(-)

-- 
1.9.2
