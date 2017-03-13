Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Felipe F. Tonello" <eu@felipetonello.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC][PATCH v3 BlueZ 0/3] Connection Update improvements
Date: Mon, 13 Mar 2017 17:54:09 +0000
Message-Id: <20170313175412.11365-1-eu@felipetonello.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These changes should improve applications who want to update the connection
parameters for both master and slave devices.

Note: Connection Parameters Request Link Layer Control Procedure (>=4.1) is
not supported in BlueZ yet. I will work on this later as this RFC is approved.

Changes from v2:
 * Added new MGMT command (patch #3)
 * Roll back to first socket option implementation, details are on the patch
   iself.

Changes from v1:
 * Use simpler user-space API
 * Added patch #1

Felipe F. Tonello (3):
  Bluetooth: L2CAP: Refactor L2CAP_CONN_PARAM_UPDATE_REQ into a function
  Bluetooth: L2CAP: Add BT_LE_CONN_PARAM socket option
  Bluetooth: mgmt: Added new MGMT_OP_UPDATE_CONN_PARAM command

 include/net/bluetooth/bluetooth.h |   8 +++
 include/net/bluetooth/l2cap.h     |   3 ++
 include/net/bluetooth/mgmt.h      |  10 ++++
 net/bluetooth/l2cap_core.c        |  36 ++++++++-----
 net/bluetooth/l2cap_sock.c        | 101 +++++++++++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c              | 103 +++++++++++++++++++++++++-------------
 6 files changed, 212 insertions(+), 49 deletions(-)

-- 
2.12.0

