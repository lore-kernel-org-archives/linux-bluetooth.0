Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 0/5] Trivial fixes for emulating AMP HCI
Date: Tue, 15 Nov 2011 16:15:42 +0200
Message-Id: <1321366547-29462-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Changes:
	v4: Added 2 more patches making sure that BREDR is the 1st device in hci_dev_list;
	added AMP definitions form Bluez patch sent by Peter Krystad <pkrystad@codeaurora.org>.
	For VHCI set also amp_status.
	v3: Changed parameter description
        v2: Taken Marcel's comments about parameter name & permissions.

Those trivial patches help to emulate AMP HCI controller
currently used for A2MP protocol verification.

Andrei Emeltchenko (5):
  Bluetooth: Define AMP controller statuses
  Bluetooth: Allow to set AMP type for virtual HCI
  Bluetooth: Move scope of kernel parameter enable_hs
  Bluetooth: Do not set HCI_RAW when HS enabled
  Bluetooth: Assure BREDR HCI device first in the list

 drivers/bluetooth/hci_vhci.c  |   10 ++++++++++
 include/net/bluetooth/hci.h   |   11 +++++++++++
 include/net/bluetooth/l2cap.h |    1 -
 net/bluetooth/hci_core.c      |   11 ++++++++---
 4 files changed, 29 insertions(+), 4 deletions(-)

-- 
1.7.4.1

