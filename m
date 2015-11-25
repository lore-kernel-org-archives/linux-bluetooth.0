Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/4] Bluetooth: More hci_request.c & hci_req_sync updates
Date: Wed, 25 Nov 2015 16:15:40 +0200
Message-Id: <1448460944-17002-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

The first three patches in this set are preparations for moving the
power on sequence to be done with hci_req_sync. The fourth patch does
the actual refactoring for that.

Johan

----------------------------------------------------------------
Johan Hedberg (4):
      Bluetooth: HCI name update to hci_request.c
      Bluetooth: Move EIR update to hci_request.c
      Bluetooth: Move fast connectable code to hci_request.c
      Bluetooth: Perform HCI update for power on synchronously

 include/net/bluetooth/hci_core.h |   3 +-
 net/bluetooth/hci_core.c         |  21 ++-
 net/bluetooth/hci_request.c      | 334 ++++++++++++++++++++++++++++++++
 net/bluetooth/hci_request.h      |   6 +
 net/bluetooth/mgmt.c             | 388 ++------------------------------------
 5 files changed, 376 insertions(+), 376 deletions(-)

