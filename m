Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3] Bluetooth: Use non-flushable by default L2CAP data packets
Date: Tue, 28 Dec 2010 17:16:06 +0200
Message-Id: <1293549367-2516-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Modification of Nick Pelly <npelly@google.com> patch.

Changes to previous releases:
- rebasing, simplifying logic, using SOL_BLUETOOTH instead of SOL_L2CAP.
- LMP_NO_FLUSH feature mask corrected, added check to l2cap_send_sframe

Andrei Emeltchenko (1):
  Bluetooth: Use non-flushable by default L2CAP data packets

 include/net/bluetooth/bluetooth.h |    5 +++
 include/net/bluetooth/hci.h       |    2 +
 include/net/bluetooth/hci_core.h  |    1 +
 include/net/bluetooth/l2cap.h     |    1 +
 net/bluetooth/hci_core.c          |    7 +++-
 net/bluetooth/l2cap.c             |   57 ++++++++++++++++++++++++++++++++++--
 6 files changed, 67 insertions(+), 6 deletions(-)

