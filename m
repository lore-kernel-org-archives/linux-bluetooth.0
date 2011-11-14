Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 0/3] Trivial fixes for emulating AMP HCI
Date: Mon, 14 Nov 2011 12:42:47 +0200
Message-Id: <1321267370-15727-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Changes:
	v3 Changed parameter description
        v2 Taken Marcel's comments about parameter name & permissions.

Those trivial patches help to emulate AMP HCI controller
currently used for A2MP protocol verification.

Andrei Emeltchenko (3):
  Bluetooth: Allow to set AMP type for virtual HCI
  Bluetooth: Move scope of kernel parameter enable_hs
  Bluetooth: Do not set HCI_RAW when HS enabled

 drivers/bluetooth/hci_vhci.c  |    8 ++++++++
 include/net/bluetooth/hci.h   |    2 ++
 include/net/bluetooth/l2cap.h |    1 -
 net/bluetooth/hci_core.c      |    5 +++--
 4 files changed, 13 insertions(+), 3 deletions(-)

-- 
1.7.4.1

