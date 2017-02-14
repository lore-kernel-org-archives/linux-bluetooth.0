Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Felipe F. Tonello" <eu@felipetonello.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC][PATCH v2 BlueZ 0/2] Connection Update improvements
Date: Tue, 14 Feb 2017 20:28:27 +0000
Message-Id: <20170214202829.550-1-eu@felipetonello.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These changes should improve application who want to update the connection
parameters for both master and slave devices.

Note: Connection Parameters Request Link Layer Control Procedure (>=4.1) is
not supported in BlueZ yet. I will work on this on later patches.

Changes from v1:
 * Use simpler user-space API
 * Added patch #1

Felipe F. Tonello (2):
  Bluetooth: L2CAP: Refactor L2CAP_CONN_PARAM_UPDATE_REQ into a function
  Bluetooth: L2CAP: Add BT_LE_CONN_CONFIG socket option

 include/net/bluetooth/bluetooth.h |   9 ++++
 include/net/bluetooth/hci_core.h  |   1 +
 include/net/bluetooth/l2cap.h     |   3 ++
 net/bluetooth/hci_core.c          |   1 +
 net/bluetooth/l2cap_core.c        |  36 ++++++++-----
 net/bluetooth/l2cap_sock.c        | 108 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c              |   1 +
 7 files changed, 146 insertions(+), 13 deletions(-)

-- 
2.11.1

