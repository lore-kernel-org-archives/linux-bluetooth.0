Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [RFC 0/5] Broadcaster/Observer MGMT API
Date: Fri, 10 Aug 2012 17:01:42 -0400
Message-Id: <1344632507-21381-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

After some discussions on BlueZ meeting, it was decided to have a MGMT API for
Broadcaster and Observer roles.

The normal flow for Broadcaster is set controller data for any data needed and
set broadcaster on. For now, kernel will try to pack as much data as possible
for Adv. In future, we may implement a rotation logic to send all data set by
userspace.
Use unset controller data with respective data_type to remove any data that
matches this data_type.
After adding or removing controller data, to update Adv data, you need to set
broadcaster off and after set broadcaster on, so adv. data can be updated on
the controller.

To start observer, just set observer to on. Any data will come from device
found event.

We have patches for userspace that will hit BlueZ ML next week.

Jefferson Delfes (5):
  Bluetooth: Add new commands HCI for LE and BR/EDR
  Bluetooth: Add set controller data MGMT command
  Bluetooth: Add unset controller data MGMT command
  Bluetooth: Add set broadcaster MGMT command
  Bluetooth: Add set observer MGMT command

 include/net/bluetooth/hci.h      |  30 +++++++
 include/net/bluetooth/hci_core.h |  15 ++++
 include/net/bluetooth/mgmt.h     |  23 ++++++
 net/bluetooth/hci_core.c         |  48 +++++++++++
 net/bluetooth/mgmt.c             | 167 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 283 insertions(+)

-- 
1.7.11.4

