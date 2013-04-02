Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo@padovan.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH v2 00/18] Rework HIDP Module
Date: Tue,  2 Apr 2013 18:08:20 +0200
Message-Id: <1364918918-2336-1-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

This is my second attempt to get these patches merged. I added 4 more fixes at
the end and removed the patches that were already merged by Gustavo.

This fixes a lot of issues with the HIDP layer. It is currently nearly
impossible to use HIDP devices. Every attempt (except the first) to connect a
device results in an oops or panic for me.

I haven't found a way to fix this easily, so I decided to rewrite the session
handling of HIDP.

The following patches can be cherry-picked if you decide to give the others
some more time for reviews: (you have to replace hidp_session_terminate()
with atomic_inc(&session->terminate))
  Bluetooth: hidp: remove redundant error message
  Bluetooth: hidp: verify l2cap sockets
  Bluetooth: hidp: remove unused session->state field
  Bluetooth: hidp: test "terminate" before sleeping
  Bluetooth: allow constant arguments for bacmp()/bacpy()
  Bluetooth: hidp: move hidp_schedule() to core.c
  Bluetooth: hidp: handle kernel_sendmsg() errors correctly
  Bluetooth: hidp: merge hidp_process_{ctrl,intr}_transmit()
  Bluetooth: hidp: merge 'send' functions into hidp_send_message()
  Bluetooth: hidp: don't send boot-protocol messages as HID-reports
  Bluetooth: hidp: fix sending output reports on intr channel

Thanks
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
  Bluetooth: l2cap: add l2cap_sock_get_hci_conn() helper
  Bluetooth: add hci_conn_user sub-modules
  Bluetooth: hidp: move hidp_schedule() to core.c
  Bluetooth: hidp: add new session-management helpers
  Bluetooth: hidp: remove old session-management
  Bluetooth: hidp: handle kernel_sendmsg() errors correctly
  Bluetooth: hidp: merge hidp_process_{ctrl,intr}_transmit()
  Bluetooth: hidp: merge 'send' functions into hidp_send_message()
  Bluetooth: hidp: don't send boot-protocol messages as HID-reports
  Bluetooth: hidp: fix sending output reports on intr channel

 include/net/bluetooth/bluetooth.h |   4 +-
 include/net/bluetooth/hci_core.h  |  46 +-
 include/net/bluetooth/l2cap.h     |   2 +
 net/bluetooth/hci_conn.c          |  92 +++-
 net/bluetooth/hci_event.c         |  40 +-
 net/bluetooth/hci_sysfs.c         |   1 -
 net/bluetooth/hidp/core.c         | 981 ++++++++++++++++++++++----------------
 net/bluetooth/hidp/hidp.h         |  67 ++-
 net/bluetooth/hidp/sock.c         |  22 +-
 net/bluetooth/l2cap_core.c        |   6 +-
 net/bluetooth/l2cap_sock.c        |  27 ++
 net/bluetooth/mgmt.c              |   6 +-
 net/bluetooth/sco.c               |   6 +-
 net/bluetooth/smp.c               |   2 +-
 14 files changed, 783 insertions(+), 519 deletions(-)

-- 
1.8.2
