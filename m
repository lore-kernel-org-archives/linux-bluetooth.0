Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/7] LE connection refactoring and fixes
Date: Tue,  1 Oct 2013 20:03:49 -0300
Message-Id: <1380668636-30654-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This patchset contains several refactoring and fixes for LE connection code.
These patches are part of the bigger LE auto connection patchset. As discussed
in New Orleans, I'm sending these patches since they can already be applied to
bluetooth-next.

Also, I'm still implementing the suggestions collected during the Wireless
Summit and I'll send the LE auto connection patchset soon.

Regards,

Andre


Andre Guedes (7):
  Bluetooth: Initialize hci_conn fields in hci_connect_le
  Bluetooth: Use HCI request for LE connection
  Bluetooth: Remove hci_le_create_connection
  Bluetooth: Remove hci_cs_le_create_conn event handler
  Bluetooth: Refactor hci_connect_le
  Bluetooth: Refactor LE Connection Complete HCI event handler
  Bluetooth: Locking in hci_le_conn_complete_evt

 include/net/bluetooth/hci.h      |   1 +
 include/net/bluetooth/hci_core.h |   2 +
 net/bluetooth/hci_conn.c         |  70 +++++++++++++--------------
 net/bluetooth/hci_core.c         |  46 ++++++++++++++++++
 net/bluetooth/hci_event.c        | 102 +++++++++++++++++++--------------------
 5 files changed, 132 insertions(+), 89 deletions(-)

-- 
1.8.4

