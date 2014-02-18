Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 00/10] Bluetooth: More patches for privacy
Date: Tue, 18 Feb 2014 17:14:29 +0200
Message-Id: <1392736479-8808-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here are more patches towards implementing support for privacy. Included
are also some cleanup and fix patches for issues I came accross when
dealing with the code.

Johan

----------------------------------------------------------------
Johan Hedberg (10):
      Bluetooth: Remove SMP data specific crypto context
      Bluetooth: Fix missing address type check for removing LTKs
      Bluetooth: Remove return values from functions that don't need them
      Bluetooth: Fix hci_remove_ltk failure when no match is found
      Bluetooth: Fix completing SMP as peripheral when no keys are expected
      Bluetooth: Fix removing any IRKs when unpairing devices
      Bluetooth: Add convenience function for fetching IRKs
      Bluetooth: Track the LE Identity Address in struct hci_conn
      Bluetooth: Fix updating Identity Address in L2CAP channels
      Bluetooth: Wait for SMP key distribution completion when pairing

 include/net/bluetooth/hci_core.h | 23 +++++++++++++-----
 include/net/bluetooth/l2cap.h    |  1 +
 net/bluetooth/hci_core.c         | 49 ++++++++++++++++++++++----------------
 net/bluetooth/hci_event.c        |  7 ++++++
 net/bluetooth/l2cap_core.c       | 17 +++++++++++++
 net/bluetooth/mgmt.c             | 45 ++++++++++++++++++++++++++--------
 net/bluetooth/smp.c              | 25 ++++++++++---------
 net/bluetooth/smp.h              |  2 +-
 8 files changed, 119 insertions(+), 50 deletions(-)


