Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v1 0/7] Introduce APIs to set advertising data
Date: Fri, 20 Mar 2015 19:48:03 -0700
Message-Id: <1426906090-9026-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

*v1: - Addressed Marcel's comments.
     - Included support for setting scan response data and timeouts.

Arman Uguray (7):
  Bluetooth: Add definitions for Add/Remove Advertising API
  Bluetooth: Introduce HCI_ADVERTISING_INSTANCE setting and add AD flags
  Bluetooth: Add data structure for advertising instance
  Bluetooth: Implement the Add Advertising command
  Bluetooth: Implement the Remove Advertising command
  Bluetooth: Add support for instance scan response
  Bluetooth: Add support for adv instance timeout

 include/net/bluetooth/hci.h      |   2 +
 include/net/bluetooth/hci_core.h |  18 ++
 include/net/bluetooth/mgmt.h     |  34 +++
 net/bluetooth/hci_core.c         |   1 +
 net/bluetooth/mgmt.c             | 465 ++++++++++++++++++++++++++++++++++++++-
 5 files changed, 509 insertions(+), 11 deletions(-)

-- 
2.2.0.rc0.207.ga3a616c

