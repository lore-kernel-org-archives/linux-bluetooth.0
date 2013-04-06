Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo@padovan.org>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH v4 00/16] Rework HIDP Session Management
Date: Sat,  6 Apr 2013 20:28:36 +0200
Message-Id: <1365272932-571-1-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1365166670-3271-1-git-send-email-dh.herrmann@gmail.com>
References: <1365166670-3271-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

No changes from v3, but rebased onto bluetooth-next/master. Sorry, I forgot
that on the previous series.
I tested it with bluetooth-next and everything works great. Only conflicts
were some unrelated HCI core-fixes.

Regards
David

David Herrmann (16):
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
 include/net/bluetooth/l2cap.h     |  14 +
 net/bluetooth/hci_conn.c          |  26 +-
 net/bluetooth/hci_event.c         |  40 +-
 net/bluetooth/hci_sysfs.c         |   1 -
 net/bluetooth/hidp/core.c         | 994 ++++++++++++++++++++++----------------
 net/bluetooth/hidp/hidp.h         |  67 ++-
 net/bluetooth/hidp/sock.c         |  21 +-
 net/bluetooth/l2cap_core.c        | 117 ++++-
 net/bluetooth/mgmt.c              |   6 +-
 net/bluetooth/sco.c               |   6 +-
 net/bluetooth/smp.c               |   2 +-
 13 files changed, 810 insertions(+), 523 deletions(-)

-- 
1.8.2

