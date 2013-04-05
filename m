Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH v3 00/18] Rework HIDP Session Management
Date: Fri,  5 Apr 2013 14:57:32 +0200
Message-Id: <1365166670-3271-1-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

This is v3 of the HIDP session management rework. Only thing that changed is
that I moved hci_conn_user to l2cap_user as requested. The l2cap_user object is
now bound to l2cap_conn objects instead of hci_conn. This avoids any direct HCI
dependency in external modules.

Note that this requires l2cap_conn ref-counting. However, this is pretty easy to
implement and does not affect existing code at all as we use direct
synchronization.

Also note that I designed it in a way that it is independent of l2cap_sock. So
if we succeed it making l2cap_core independent of l2cap_sock, we can move HIDP
or other l2cap_user users over and make them independent of l2cap_sock, too.

Regards
David

David Herrmann (18):
  Bluetooth: hidp: remove redundant error message
  Bluetooth: hidp: verify l2cap sockets
  Bluetooth: rename hci_conn_put to hci_conn_drop
  Bluetooth: remove unneeded hci_conn_hold/put_device()
  Bluetooth: introduce hci_conn ref-counting
  Bluetooth: hidp: remove unused session->state field
  Bluetooth: hidp: test "terminate" before sleeping
  Bluetooth: allow constant arguments for bacmp()/bacpy()
  Bluetooth: hidp: move hidp_schedule() to core.c
  Bluetooth: l2cap: introduce l2cap_conn ref-counting
  Bluetooth: l2cap: add l2cap_user sub-modules
  Bluetooth: hidp: add new session-management helpers
  Bluetooth: hidp: remove old session-management
  Bluetooth: hidp: handle kernel_sendmsg() errors correctly
  Bluetooth: hidp: merge hidp_process_{ctrl,intr}_transmit()
  Bluetooth: hidp: merge 'send' functions into hidp_send_message()
  Bluetooth: hidp: don't send boot-protocol messages as HID-reports
  Bluetooth: hidp: fix sending output reports on intr channel

 include/net/bluetooth/bluetooth.h |   4 +-
 include/net/bluetooth/hci_core.h  |  35 +-
 include/net/bluetooth/l2cap.h     |  15 +
 net/bluetooth/hci_conn.c          |  26 +-
 net/bluetooth/hci_event.c         |  40 +-
 net/bluetooth/hci_sysfs.c         |   1 -
 net/bluetooth/hidp/core.c         | 991 ++++++++++++++++++++++----------------
 net/bluetooth/hidp/hidp.h         |  67 ++-
 net/bluetooth/hidp/sock.c         |  22 +-
 net/bluetooth/l2cap_core.c        | 117 ++++-
 net/bluetooth/l2cap_sock.c        |   6 +
 net/bluetooth/mgmt.c              |   6 +-
 net/bluetooth/sco.c               |   6 +-
 net/bluetooth/smp.c               |   2 +-
 14 files changed, 817 insertions(+), 521 deletions(-)

-- 
1.8.2
