Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v3 0/5] LE Connection
Date: Thu,  5 Apr 2012 14:17:16 -0300
Message-Id: <1333646241-12574-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This new version fixes all aligning style issues.

BR,

Andre Guedes


Andre Guedes (5):
  Bluetooth: Add address type to struct sockaddr_l2
  Bluetooth: Move address type macros to bluetooth.h
  Bluetooth: Add dst_type parameter to hci_connect
  Bluetooth: Use address type info from User-space
  Bluetooth: Remove advertising cache

 include/net/bluetooth/bluetooth.h |    5 +++
 include/net/bluetooth/hci_core.h  |   27 ++++---------
 include/net/bluetooth/l2cap.h     |    3 +-
 net/bluetooth/hci_conn.c          |   12 ++----
 net/bluetooth/hci_core.c          |   75 -------------------------------------
 net/bluetooth/hci_event.c         |    7 ----
 net/bluetooth/l2cap_core.c        |   15 ++++----
 net/bluetooth/l2cap_sock.c        |    2 +-
 net/bluetooth/mgmt.c              |   36 +++++++++---------
 net/bluetooth/sco.c               |    3 +-
 10 files changed, 47 insertions(+), 138 deletions(-)

-- 
1.7.9.4

