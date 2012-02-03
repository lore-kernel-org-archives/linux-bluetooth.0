Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 0/7] New MGMT messages for SMP Long Term Keys
Date: Thu,  2 Feb 2012 21:07:58 -0300
Message-Id: <1328227685-27245-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes from last version:
 * Updated code acording to review comments;
 * Added a patch that removes useless casts from MGMT code;


Cheers,

Vinicius Costa Gomes (7):
  Bluetooth: Fix doing some useless casts when receiving MGMT commands
  Bluetooth: Add new structures for handling SMP Long Term Keys
  Bluetooth: Use the updated key structures for handling LTKs
  Bluetooth: Add MGMT handlers for dealing with SMP LTK's
  Bluetooth: Add support for removing LTK's when pairing is removed
  Bluetooth: Clean up structures left unused
  Bluetooth: Add support for notifying userspace of new LTK's

 include/net/bluetooth/hci.h      |    9 +-
 include/net/bluetooth/hci_core.h |   35 +++--
 net/bluetooth/hci_core.c         |  108 +++++++++------
 net/bluetooth/hci_event.c        |   11 ++-
 net/bluetooth/mgmt.c             |  296 ++++++++++++++++++++++----------------
 net/bluetooth/smp.c              |   38 +++--
 6 files changed, 296 insertions(+), 201 deletions(-)

--
1.7.8.1

