Return-Path: <jaganath.k.os@gmail.com>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH v5 00/16] Bluetooth: Extended Adv, Scan, Connection and PHY support
Date: Thu, 19 Jul 2018 17:09:31 +0530
Message-Id: <1532000387-3649-1-git-send-email-jaganathx.kanakkassery@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Implemented Get, Set PHY Configuration and setting of PHY in
Advertising. Also implemented extended advertising,
scanning and connection.

v2: Fixed kbuild warnings
v3: Added BREDR packet types in PHY Configurtion commands and events
v4: Added default phys as variable in hdev and removed same from hci flags
v5: Applied Marcel's comments

Jaganath Kanakkassery (16):
  Bluetooth: Define PHY flags in hdev and set 1M as default
  Bluetooth: Add defines for BREDR pkt_type and LE PHYs
  Bluetooth: Implement Get PHY Configuration mgmt command
  Bluetooth: Implement Set PHY Confguration command
  Bluetooth: Implement PHY changed event
  Bluetooth: Set Scan PHYs based on selected PHYs by user
  Bluetooth: Handle extended ADV PDU types
  Bluetooth: Use selected PHYs in extended connect
  Bluetooth: Read no of adv sets during init
  Bluetooth: Impmlement extended adv enable
  Bluetooth: Use Set ext adv/scan rsp data if controller supports
  Bluetooth: Implement disable and removal of adv instance
  Bluetooth: Use ext adv for directed adv
  Bluetooth: Implement Set ADV set random address
  Bluetooth: Handle ADv set terminated event
  Bluetooth: Implement secondary advertising on different PHYs

 include/net/bluetooth/hci.h      | 118 +++++++++-
 include/net/bluetooth/hci_core.h |  26 ++
 include/net/bluetooth/mgmt.h     |  55 +++++
 net/bluetooth/hci_conn.c         | 151 +++++++++---
 net/bluetooth/hci_core.c         |  72 +++++-
 net/bluetooth/hci_event.c        | 250 ++++++++++++++++++--
 net/bluetooth/hci_request.c      | 498 ++++++++++++++++++++++++++++++++++-----
 net/bluetooth/hci_request.h      |   8 +
 net/bluetooth/mgmt.c             | 405 ++++++++++++++++++++++++++++++-
 9 files changed, 1451 insertions(+), 132 deletions(-)

-- 
2.7.4
