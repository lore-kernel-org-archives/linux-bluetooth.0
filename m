Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/8] LE Connection
Date: Tue, 24 Apr 2012 21:02:48 -0300
Message-Id: <1335312176-21306-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This patch series is basically a rebased version of the previous RFC v3 series.

Claudio is going to send user-space patches in a few minutes.

This series depends on "[PATCH] Bluetooth: Remove useless code in hci_connect"
already sent to this ML.

Regards,

Andre


Andre Guedes (8):
  Bluetooth: Move address type macros to bluetooth.h
  Bluetooth: Rename link_to_mgmt to link_to_bdaddr
  Bluetooth: Rename mgmt_to_le to bdaddr_to_le
  Bluetooth: Add address type to struct sockaddr_l2
  Bluetooth: Move bdaddr_to_le to hci_core
  Bluetooth: Add dst_type parameter to hci_connect
  Bluetooth: Use address type info from user-space
  Bluetooth: Remove advertising cache

 include/net/bluetooth/bluetooth.h |    5 +++
 include/net/bluetooth/hci_core.h  |   29 ++++---------
 include/net/bluetooth/l2cap.h     |    3 +-
 net/bluetooth/hci_conn.c          |   11 ++---
 net/bluetooth/hci_core.c          |   86 ++++++-------------------------------
 net/bluetooth/hci_event.c         |    7 ---
 net/bluetooth/l2cap_core.c        |   15 ++++---
 net/bluetooth/l2cap_sock.c        |    2 +-
 net/bluetooth/mgmt.c              |   78 ++++++++++++++-------------------
 net/bluetooth/sco.c               |    3 +-
 10 files changed, 75 insertions(+), 164 deletions(-)

-- 
1.7.10

