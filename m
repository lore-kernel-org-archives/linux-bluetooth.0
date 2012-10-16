Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 0/8] Handling physical and logical link
Date: Tue, 16 Oct 2012 18:01:02 +0300
Message-Id: <1350399670-12418-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Set of patches adding handling for physical and logical link
complete events.

Andrei Emeltchenko (8):
  Bluetooth: AMP: Process Physical Link Complete evt
  Bluetooth: AMP: Process Logical Link complete evt
  Bluetooth: Add logical link create function
  Bluetooth: AMP: Process Disc Logical Link
  Bluetooth: AMP: Process Disc Physical Link complete evt
  Bluetooth: AMP: Remove hci_conn receiving error command status
  Bluetooth: Disconnect logical link when deleteing chan
  Bluetooth: Add put(hcon) when deleting hchan

 include/net/bluetooth/amp.h   |    3 +
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/amp.c           |   67 ++++++++++++++++
 net/bluetooth/hci_conn.c      |    2 +
 net/bluetooth/hci_event.c     |  174 ++++++++++++++++++++++++++++++++++++++++-
 net/bluetooth/l2cap_core.c    |   33 ++++++++
 6 files changed, 276 insertions(+), 4 deletions(-)

-- 
1.7.9.5

