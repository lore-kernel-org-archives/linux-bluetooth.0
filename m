Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/7] Bluetooth: Cleanups and LE advertising support
Date: Wed, 25 Sep 2013 13:26:03 +0300
Message-Id: <1380104770-8022-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's an updated set based on feedback on the first one. The
mgmt_valid_hdev patch has been dropped since it's a trivial one and I
didn't want the debate over it to slow down the overall progress of this
set.

The main difference to the initial set_le and set_advertising code is
that I now let the hci_event.c handlers take care of setting the right
values of the dev_flags bits. This works fine since these handlers are
always executed before the async request callbacks which then get called
with dev_flags already having the correct value. The benefit of using
the event handlers like this is that we retain at least partial support
for raw HCI access (hciconfig) by ensuring that the kernel state flags
are always correct.

Johan

----------------------------------------------------------------
Johan Hedberg (7):
      Bluetooth: Add clarifying comment to bt_sock_wait_state()
      Bluetooth: Clean up socket locking in l2cap_sock_recvmsg
      Bluetooth: Fix busy return for mgmt_set_powered in some cases
      Bluetooth: Move mgmt response convenience functions to a better location
      Bluetooth: Use async request for LE enable/disable
      Bluetooth: Add new mgmt setting for LE advertising
      Bluetooth: Add new mgmt_set_advertising command

 include/net/bluetooth/hci_core.h |   1 -
 include/net/bluetooth/mgmt.h     |   3 +
 net/bluetooth/af_bluetooth.c     |   1 +
 net/bluetooth/hci_event.c        |  12 +-
 net/bluetooth/l2cap_sock.c       |   4 +-
 net/bluetooth/mgmt.c             | 257 ++++++++++++++++++++++++++------------
 6 files changed, 191 insertions(+), 87 deletions(-)

