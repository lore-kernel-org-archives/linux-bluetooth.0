Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/4] Bluetooth: Add/Remove Device completion through hci_request
Date: Fri, 19 Dec 2014 11:23:33 +0200
Message-Id: <1418981017-10462-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

So far the last couple of Remove Device tests in mgmt-tester have been
randomly failing some 50% of the time, mainly because the Add/Remove
mgmt command implementation wouldn't wait for HCI command completion
before returning. This would let the tests proceed from the setup to the
test phase when there are still setup phase HCI command uncompleted.

This set of patches updates the HCI scanning functions to take a
hci_request parameter so that the completion of any HCI commands can be
hooked up to sending the mgmt response to user space.

Johan

----------------------------------------------------------------
Johan Hedberg (4):
      Bluetooth: Move struct hci_request definition higher up in hci_core.h
      Bluetooth: Add hci_request parameter to hci_update_background_scan
      Bluetooth: Fix Remove Device to wait for HCI before sending cmd_complete
      Bluetooth: Fix Add Device to wait for HCI before sending cmd_complete

 include/net/bluetooth/hci_core.h |  24 +++----
 net/bluetooth/hci_conn.c         |   2 +-
 net/bluetooth/hci_core.c         |  35 ++++++-----
 net/bluetooth/hci_event.c        |   4 +-
 net/bluetooth/mgmt.c             | 119 ++++++++++++++++++++++++++++-------
 5 files changed, 131 insertions(+), 53 deletions(-)

