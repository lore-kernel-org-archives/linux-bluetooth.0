Return-Path: <cyrus@holtmann.org>
From: Alfonso Acosta <fons@spotify.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/2] Bluetooth: Include ADV_IND report in Device Connected event
Date: Fri,  3 Oct 2014 12:10:24 +0000
Message-Id: <1412338226-7351-1-git-send-email-fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch appends the ADV_IND report which triggered an
autoconnection to the EIR Data in the Device Connected event.

The initial patch passes hci_conn to mgmt_device_connected() in order
to keep its argument number under constrol.


Alfonso Acosta (2):
  Bluetooth: Refactor arguments of mgmt_device_connected
  Bluetooth: Include ADV_IND report in Device Connected event

 include/net/bluetooth/hci_core.h |  8 ++++---
 net/bluetooth/hci_event.c        | 48 +++++++++++++++++++++++-----------------
 net/bluetooth/l2cap_core.c       |  4 +---
 net/bluetooth/mgmt.c             | 33 ++++++++++++++++++---------
 4 files changed, 56 insertions(+), 37 deletions(-)

-- 
1.9.1

