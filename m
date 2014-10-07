Return-Path: <cyrus@holtmann.org>
From: Alfonso Acosta <fons@spotify.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 0/3] Bluetooth: Include ADV_IND report in Device Connected event
Date: Tue,  7 Oct 2014 08:44:09 +0000
Message-Id: <1412671452-24854-1-git-send-email-fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Rebased and took care of Johan's remarks, including a separate patch
to remove an redundant check on hci_conn's device class.

Alfonso Acosta (3):
  Bluetooth: Refactor arguments of mgmt_device_connected
  Bluetooth: Include ADV_IND report in Device Connected event
  Bluetooth: Remove redundant check on hci_conn's device class

 include/net/bluetooth/hci_core.h |  7 +++---
 net/bluetooth/hci_event.c        | 46 +++++++++++++++++++++++-----------------
 net/bluetooth/l2cap_core.c       |  4 +---
 net/bluetooth/mgmt.c             | 32 ++++++++++++++++++----------
 4 files changed, 52 insertions(+), 37 deletions(-)

-- 
1.9.1

