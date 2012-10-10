Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 0/6] Handle AMP_LINK
Date: Wed, 10 Oct 2012 17:38:25 +0300
Message-Id: <1349879912-23633-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1349707932-10006-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1349707932-10006-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add code for handling High Speed link

Changes:
	* v1: Fixes according to Marcel's review
	* RFCv1: Initial release

Andrei Emeltchenko (6):
  Bluetooth: Allow to set flush timeout
  Bluetooth: AMP: Handle AMP_LINK timeout
  Bluetooth: AMP: Add handle to hci_chan structure
  Bluetooth: AMP: Handle number of compl blocks for AMP_LINK
  Bluetooth: AMP: Handle AMP_LINK connection
  Bluetooth: AMP: Hanlde AMP_LINK case in conn_put

 include/net/bluetooth/hci_core.h |   35 ++++++++++++++++++---
 net/bluetooth/hci_conn.c         |   64 ++++++++++++++++++++++++++++++++++++--
 net/bluetooth/hci_core.c         |   22 +++++++++++--
 net/bluetooth/hci_event.c        |   26 ++++++++++++++--
 net/bluetooth/l2cap_sock.c       |    1 +
 5 files changed, 136 insertions(+), 12 deletions(-)

-- 
1.7.9.5

