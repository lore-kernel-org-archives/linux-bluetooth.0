Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 0/6] Introduce APIs to set advertising data
Date: Thu, 19 Mar 2015 17:04:31 -0700
Message-Id: <1426809877-22469-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set implements the Add/Remove Advertising commands and the
Advertising Added/Removed events. This provides the bare minimum support
for adding at most one advertising instance, with only support for
setting the advertising data parameter.

Arman Uguray (6):
  Bluetooth: Add definitions for Add/Remove Advertising mgmt commands
  Bluetooth: Introduce HCI_ADVERTISING_INSTANCE setting and add AD flags
  Bluetooth: Add data structure for advertising instance
  Bluetooth: Implement the Add Advertising command
  Bluetooth: Implement the Remove Advertising command
  Bluetooth: Add Advertising Added/Removed events

 include/net/bluetooth/hci.h      |  14 ++
 include/net/bluetooth/hci_core.h |  18 ++
 include/net/bluetooth/mgmt.h     |  34 ++++
 net/bluetooth/hci_core.c         |   1 +
 net/bluetooth/mgmt.c             | 416 ++++++++++++++++++++++++++++++++++++++-
 5 files changed, 473 insertions(+), 10 deletions(-)

-- 
2.2.0.rc0.207.ga3a616c

