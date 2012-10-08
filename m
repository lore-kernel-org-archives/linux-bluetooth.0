Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 0/6] Handle AMP_LINK
Date: Mon,  8 Oct 2012 17:52:06 +0300
Message-Id: <1349707932-10006-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add code for handling High Speed link

Andrei Emeltchenko (6):
  Bluetooth: Allow to set flush timeout
  Bluetooth: AMP: Handle AMP_LINK timeout
  Bluetooth: AMP: Add handle to hci_chan structure
  Bluetooth: Handle number of compl blocks for AMP_LINK
  Bluetooth: AMP: Handle AMP_LINK connection
  Bluetooth: AMP: Hanlde AMP_LINK case in conn_put

 include/net/bluetooth/hci_core.h |   36 +++++++++++++++++---
 net/bluetooth/hci_conn.c         |   69 ++++++++++++++++++++++++++++++++++++--
 net/bluetooth/hci_core.c         |   22 ++++++++++--
 net/bluetooth/hci_event.c        |   13 +++++--
 net/bluetooth/l2cap_sock.c       |    1 +
 5 files changed, 128 insertions(+), 13 deletions(-)

-- 
1.7.9.5

