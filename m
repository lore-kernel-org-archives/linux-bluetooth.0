Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4] Bluetooth: Use non-flushable by default L2CAP data packets
Date: Mon,  3 Jan 2011 11:14:35 +0200
Message-Id: <1294046076-3712-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Modification of Nick Pelly <npelly@google.com> patch.

Changes to previous releases:
- rebasing, simplifying logic, using SOL_BLUETOOTH instead of SOL_L2CAP.
- LMP_NO_FLUSH feature mask corrected, added check to l2cap_send_sframe
- added check to setsockopt function

Andrei Emeltchenko (1):
  Bluetooth: Use non-flushable by default L2CAP data packets

 include/net/bluetooth/bluetooth.h |    5 +++
 include/net/bluetooth/hci.h       |    2 +
 include/net/bluetooth/hci_core.h  |    1 +
 include/net/bluetooth/l2cap.h     |    1 +
 net/bluetooth/hci_core.c          |    7 +++-
 net/bluetooth/l2cap.c             |   59 ++++++++++++++++++++++++++++++++++--
 6 files changed, 69 insertions(+), 6 deletions(-)

