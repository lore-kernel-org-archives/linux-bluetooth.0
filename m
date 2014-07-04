Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 00/12] Bluetooth: Further LE scanning fixes & cleanups
Date: Fri,  4 Jul 2014 12:37:15 +0300
Message-Id: <1404466647-16352-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's another set of patches to fix and clean up various things with LE
scanning. The core part of these changes are related to unifuing the
list usage for the various types of connection parameter entries.

Johan

----------------------------------------------------------------
Johan Hedberg (12):
      Bluetooth: Fix missing return statement in process_adv_report
      Bluetooth: Convert pend_le_conn list to a generic action list
      Bluetooth: Convert pend_le_reports into a list
      Bluetooth: Simplify use of hci_pend_le_conns_clear()
      Bluetooth: Don't bother doing anything if auto_connect doesn't change
      Bluetooth: Simplify hci_conn_params->action list usage
      Bluetooth: Remove unused hci_pend_le_conn_del() function
      Bluetooth: Fix clearing and restarting all LE actions on power cycle
      Bluetooth: Remove unnecessary usage of hci_pend_le_conn_add
      Bluetooth: Remove unused hci_pend_le_conn_add function
      Bluetooth: Make hci_pend_le_conn_lookup more general purposed
      Bluetooth: Use hci_pend_le_action_lookup to look up report entries

 include/net/bluetooth/hci_core.h | 12 ++---
 net/bluetooth/hci_core.c         | 93 ++++++++++++++----------------------
 net/bluetooth/hci_event.c        | 21 ++++----
 net/bluetooth/mgmt.c             | 41 ++++++++--------
 4 files changed, 73 insertions(+), 94 deletions(-)

