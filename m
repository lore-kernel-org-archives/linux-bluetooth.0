Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH v4 00/13] Bluetooth: Extended Adv, Scan, Connection and PHY support 
Date: Wed, 11 Jul 2018 15:01:22 +0530
Message-Id: <1531301495-14479-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implemented Get, Set PHY Configuration and setting of PHY in
Advertising. Also implemented extended advertising,
scanning and connection.

v2: Fixed kbuild warnings
v3: Added BREDR packet types in PHY Configurtion commands and events
v4: Added default phys as variable in hdev and removed same from hci flags

Jaganath Kanakkassery (13):
  Bluetooth: Define default phys in hdev and set 1M as default
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

 include/net/bluetooth/hci.h      | 116 +++++++++-
 include/net/bluetooth/hci_core.h |  21 ++
 include/net/bluetooth/mgmt.h     |  55 +++++
 net/bluetooth/hci_conn.c         | 153 +++++++++----
 net/bluetooth/hci_core.c         |  25 ++-
 net/bluetooth/hci_event.c        | 182 ++++++++++++++--
 net/bluetooth/hci_request.c      | 456 ++++++++++++++++++++++++++++++++++-----
 net/bluetooth/hci_request.h      |   8 +
 net/bluetooth/hci_sock.c         |   1 +
 net/bluetooth/mgmt.c             | 420 +++++++++++++++++++++++++++++++++++-
 10 files changed, 1314 insertions(+), 123 deletions(-)

-- 
2.7.4

