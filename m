Return-Path: <jaganath.k.os@gmail.com>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH v3 00/18] Bluetooth: Extended Adv, Scan, Connection and PHY support
Date: Fri,  6 Jul 2018 17:05:26 +0530
Message-Id: <1530876944-17453-1-git-send-email-jaganathx.kanakkassery@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Implemented Get, Set PHY Configuration and setting of PHY in
Advertising. Also implemented extended advertising,
scanning and connection.

v2: Fixed kbuild warnings
v3: Added BREDR packet types in PHY Configurtion commands and events

Jaganath Kanakkassery (18):
  Bluetooth: Introduce helpers for LE set scan start and complete
  Bluetooth: Use extended scanning if controller supports
  Bluetooth: Process extended ADV report event
  Bluetooth: Introduce helpers for le conn status and complete
  Bluetooth: Use extended LE Connection if supported
  Bluetooth: Define PHY flags in hdev and set 1M as default
  Bluetooth: Implement Get PHY Configuration mgmt command
  Bluetooth: Implement Set PHY Confguration command
  Bluetooth: Set Scan PHYs based on selected PHYs by user
  Bluetooth: Handle extended ADV PDU types
  Bluetooth: Use selected PHYs in extended connect
  Bluetooth: Read no of adv sets during init
  Bluetooth: Impmlement extended adv enable
  Bluetooth: Use Set ext adv/scan rsp data if controller supports
  Bluetooth: Implement disable and removal of adv instance
  Bluetooth: Use ext adv for directed adv
  Bluetooth: Implement Set ADV set random address
  Bluetooth: Implement secondary advertising on different PHYs

 include/net/bluetooth/hci.h      | 207 ++++++++++++++
 include/net/bluetooth/hci_core.h |  24 ++
 include/net/bluetooth/mgmt.h     |  55 ++++
 net/bluetooth/hci_conn.c         | 191 ++++++++++---
 net/bluetooth/hci_core.c         |  33 ++-
 net/bluetooth/hci_event.c        | 478 +++++++++++++++++++++++++++-----
 net/bluetooth/hci_request.c      | 568 +++++++++++++++++++++++++++++++++------
 net/bluetooth/hci_request.h      |   8 +
 net/bluetooth/hci_sock.c         |   1 +
 net/bluetooth/mgmt.c             | 420 ++++++++++++++++++++++++++++-
 10 files changed, 1791 insertions(+), 194 deletions(-)

-- 
2.7.4
