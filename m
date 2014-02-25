Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 00/17] LE auto connection
Date: Tue, 25 Feb 2014 18:01:27 -0300
Message-Id: <1393362104-12175-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

Since the latest reviews of this "LE auto connection" series were basically
minor changes, I replaced the 'RFC' label by 'PATCH'.

This patch set differs from previous one by the hci_connect() refactoring
(Patches 5 and 6) requested in the last review.

BR,

Andre

PS: The patch "[PATCH] tools/btmgmt: Add command to set scan parameters"
(already sent to ML) can help with testing different scanning parameters.

Andre Guedes (17):
  Bluetooth: Create hci_req_add_le_scan_disable helper
  Bluetooth: Declare le_conn_failed in hci_core.h
  Bluetooth: Stop scanning on LE connection
  Bluetooth: Remove unused function
  Bluetooth: Refactor HCI connection code
  Bluetooth: Move address type conversion to outside hci_connect_le
  Bluetooth: Introduce hdev->pend_le_conn list
  Bluetooth: Introduce LE auto connection infrastructure
  Bluetooth: Introduce LE auto connect options
  Bluetooth: Connection parameters and auto connection
  Bluetooth: Temporarily stop background scanning on discovery
  Bluetooth: Auto connection and power on
  Bluetooth: Connection parameters and resolvable address
  Bluetooth: Support resolvable private addresses
  Bluetooth: Add le_auto_conn file on debugfs
  Bluetooth: Create hci_req_add_le_passive_scan helper
  Bluetooth: Update background scan parameters

 include/net/bluetooth/hci.h      |   1 +
 include/net/bluetooth/hci_core.h |  43 ++++-
 net/bluetooth/hci_conn.c         | 115 +++++++-----
 net/bluetooth/hci_core.c         | 369 +++++++++++++++++++++++++++++++++++++--
 net/bluetooth/hci_event.c        |  72 +++++++-
 net/bluetooth/l2cap_core.c       |  19 +-
 net/bluetooth/mgmt.c             |  68 +++++---
 7 files changed, 589 insertions(+), 98 deletions(-)

-- 
1.8.5.4

