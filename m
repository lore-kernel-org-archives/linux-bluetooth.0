Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH 00/12] Add LE broadcaster and observer functionality
Date: Fri, 14 Dec 2012 14:51:26 -0400
Message-Id: <1355511098-10190-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch series adds broadcaster and observer functionality.

For the userspace, we are updating our branch and we will send it in s few
days.

Aloisio Almeida Jr (10):
  Bluetooth: Set advertising parameters on LE setup
  Bluetooth: Add set controller data MGMT command
  Bluetooth: Add set broadcaster MGMT command
  Bluetooth: Advertise controller data in broadcaster mode
  Bluetooth: Stop to acquire hdev lock inside hci_update_ad
  Bluetooth: Enable on-the-fly update of broadcast data
  Bluetooth: Enable support for broadcaster mode when powered off.
  Bluetooth: Refactor le scan helpers to enable observer support
  Bluetooth: Add set observer MGMT command
  Bluetooth: Enable support for observer mode when powered off.

Jefferson Delfes (2):
  Bluetooth: Add HCI command to set advertising parameters
  Bluetooth: Add unset controller data MGMT command

 include/net/bluetooth/hci.h      |  19 +++
 include/net/bluetooth/hci_core.h |  42 ++++-
 include/net/bluetooth/mgmt.h     |  21 +++
 net/bluetooth/hci_core.c         | 183 ++++++++++++++++-----
 net/bluetooth/hci_event.c        | 121 +++++++++-----
 net/bluetooth/mgmt.c             | 335 +++++++++++++++++++++++++++++++++++++--
 6 files changed, 628 insertions(+), 93 deletions(-)

-- 
1.8.0.2

