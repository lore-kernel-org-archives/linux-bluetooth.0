Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 00/15] AMP Logical Link setup
Date: Tue,  4 Sep 2012 16:44:19 +0300
Message-Id: <1346766274-21612-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

RFC for setting up AMP logical link over AMP physical
link (previously sent).

Andrei Emeltchenko (13):
  Bluetooth: Set Exended Flowspec flag for HS chan
  Bluetooth: Add logical link create function
  Bluetooth: AMP: Process Logical Link Complete event
  Bluetooth: AMP: Add handle to hci_chan structure
  Bluetooth: AMP: Process Disc Logical Link
  Bluetooth: AMP: Process Disc Physical Link
  Bluetooth: L2CAP: Create Conf Response function
  Bluetooth: AMP: Send EFS Conf Rsp when loglink cmpl
  Bluetooth: AMP: Add hs_hchan and hs_hcon to l2cap_chan
  Bluetooth: AMP: Handle AMP_LINK connection
  Bluetooth: AMP: Send data over AMP channel
  Bluetooth: Factor out hci_queue_acl
  Bluetooth: AMP: Use Loglink handle in ACL Handle field

Mat Martineau (2):
  Bluetooth: Process create response and connect response identically
  Bluetooth: Factor out common L2CAP connection code

 include/net/bluetooth/amp.h      |    2 +
 include/net/bluetooth/hci.h      |    1 +
 include/net/bluetooth/hci_core.h |   19 ++++++-
 include/net/bluetooth/l2cap.h    |    5 ++
 net/bluetooth/amp.c              |   50 ++++++++++++++++++
 net/bluetooth/hci_conn.c         |   35 +++++++++++++
 net/bluetooth/hci_core.c         |   43 +++++++++++++---
 net/bluetooth/hci_event.c        |  103 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/l2cap_core.c       |   98 ++++++++++++++++++++++++++----------
 9 files changed, 320 insertions(+), 36 deletions(-)

-- 
1.7.9.5

