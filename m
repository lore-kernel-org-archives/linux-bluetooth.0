Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 0/5 v2] prioritizing data over HCI
Date: Wed, 17 Aug 2011 16:22:59 +0300
Message-Id: <1313587384-2653-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This incorporate some suggestions like removal of fixed amount of queues in
favor of one per L2CAP channel using HCI Channel abstraction (hci_chan) so
packet order is maintained, SCO/ESCO packets are no longer affected and
some other minor things like promoting starving channels directly to
maximum possible priority (6).

Priorities are unchanged, so anything bigger than 6 requires extra
capabilities and are meant for guaranteed channels or time critical packets
e.g. RFCOMM commands.

In addition to that I decide to maintain the queue per hci_conn so hci_chan
is only created when L2CAP connection completes.

Luiz Augusto von Dentz (5):
  Bluetooth: make use of connection number to optimize the scheduler
  Bluetooth: set skbuffer priority based on L2CAP socket priority
  Bluetooth: make use sk_priority to priritize RFCOMM packets
  Bluetooth: prioritizing data over HCI
  Bluetooth: recalculate priorities when channels are starving

 include/net/bluetooth/hci_core.h |   61 +++++++++
 include/net/bluetooth/l2cap.h    |    4 +-
 net/bluetooth/hci_conn.c         |   59 +++++++++
 net/bluetooth/hci_core.c         |  256 +++++++++++++++++++++++++++++++++++---
 net/bluetooth/l2cap_core.c       |   52 ++++++--
 net/bluetooth/l2cap_sock.c       |    2 +-
 net/bluetooth/rfcomm/core.c      |   51 +++++---
 net/bluetooth/rfcomm/sock.c      |    2 +
 8 files changed, 437 insertions(+), 50 deletions(-)

-- 
1.7.6

