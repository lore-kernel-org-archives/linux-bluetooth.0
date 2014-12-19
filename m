Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/4] Bluetooth: Add/Remove Device completion through hci_request
Date: Fri, 19 Dec 2014 22:25:59 +0200
Message-Id: <1419020763-9139-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's a second attempt at this set, now rebased against the changes
with hci_request.{c,h}.

Johan

----------------------------------------------------------------
Johan Hedberg (4):
      Bluetooth: Add hci_request support for hci_update_background_scan
      Bluetooth: Fix Remove Device to wait for HCI before sending cmd_complete
      Bluetooth: Fix Add Device to wait for HCI before sending cmd_complete
      Bluetooth: Add return parameter to cmd_complete callbacks

 include/net/bluetooth/hci_core.h |   4 -
 net/bluetooth/hci_core.c         | 147 ----------------------
 net/bluetooth/hci_request.c      |  96 ++++++++++++++
 net/bluetooth/hci_request.h      |   3 +
 net/bluetooth/mgmt.c             | 254 +++++++++++++++++++++++++++++---------
 5 files changed, 298 insertions(+), 206 deletions(-)

