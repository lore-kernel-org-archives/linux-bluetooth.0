Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [RFC 00/22] Bluetooth: change tasklets to workqueue
Date: Sat, 17 Dec 2011 19:29:20 -0200
Message-Id: <1324157382-1815-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

Here are the patches to run the receive path in workqueue.  With these patches
l2cap and rfcomm seems to be working fine, but some more work still needs to be
done.

Please review.

Gustavo F. Padovan (21):
  Bluetooth: Replace spin_lock by mutex in hci_dev
  Bluetooth: Use delayed_work for connection timeout
  Bluetooth: Use delayed work for advertisiment cache timeout
  Bluetooth: hci_conn_auto_accept() doesn't need locking
  Bluetooth: Move L2CAP timers to workqueue
  Bluetooth: Don't use spin_lock socket lock anymore
  Bluetooth: Remove sk_backlog usage from L2CAP
  Bluetooth: move hci_task_lock to mutex
  Bluetooth: convert chan_lock to mutex
  Bluetooth: Use RCU to manipulate chan_list
  Bluetooth: convert conn hash to RCU
  Bluetooth: Don't disable tasklets to call hdev->notify()
  Bluetooth: Move command task to workqueue
  Bluetooth: convert tx_task to workqueue
  Bluetooth: convert info timer to delayed_work
  Bluetooth: remove power_on work_struct
  Bluetooth: invert locking order in connect path
  Bluetooth: Change l2cap chan_list to use RCU
  Bluetooth: move power_off to system workqueue
  Bluetooth: Use new alloc_workqueue()
  Bluetooth: Remove work_add and work_del from hci_sysfs

Marcel Holtmann (1):
  Bluetooth: Process recv path in a workqueue instead of a tasklet

 include/net/bluetooth/hci_core.h |   75 +++++----
 include/net/bluetooth/l2cap.h    |   24 ++--
 net/bluetooth/hci_conn.c         |   48 ++----
 net/bluetooth/hci_core.c         |  165 ++++++++++--------
 net/bluetooth/hci_event.c        |   26 +--
 net/bluetooth/hci_sock.c         |   14 +-
 net/bluetooth/hci_sysfs.c        |   91 ++++------
 net/bluetooth/hidp/core.c        |    4 +-
 net/bluetooth/l2cap_core.c       |  345 +++++++++++++++++++-------------------
 net/bluetooth/l2cap_sock.c       |   61 +-------
 net/bluetooth/mgmt.c             |  108 ++++++------
 net/bluetooth/sco.c              |    4 +-
 12 files changed, 456 insertions(+), 509 deletions(-)

-- 
1.7.6.4

