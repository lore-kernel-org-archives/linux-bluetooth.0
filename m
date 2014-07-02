Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 00/10] Bluetooth: Connection parameter support
Date: Wed,  2 Jul 2014 16:35:51 +0300
Message-Id: <1404308161-15100-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This patch set implements the Load Connection Parameters command and
contains other connection parameter related fixes and improvements.

Johan

----------------------------------------------------------------
Johan Hedberg (10):
      Bluetooth: Rename hci_conn_params_clear to hci_conn_params_clear_all
      Bluetooth: Add specific connection parameter clear functions
      Bluetooth: Add new auto_conn value matching mgmt action 0x00
      Bluetooth: Remove only enabled entries with Remove Device command
      Bluetooth: Add Load Connection Parameters command
      Bluetooth: Fix missing update of conn params
      Bluetooth: Make hci_le_conn_update return any updated parameters
      Bluetooth: Pass store hint to mgmt_new_conn_param
      Bluetooth: Make is_identity_address a global function
      Bluetooth: Set store_hint to 0 for non-identity addresses

 include/net/bluetooth/hci_core.h |  26 ++++++--
 include/net/bluetooth/mgmt.h     |  15 +++++
 net/bluetooth/hci_conn.c         |   7 ++-
 net/bluetooth/hci_core.c         |  53 +++++++++++-----
 net/bluetooth/hci_event.c        |  22 ++++++-
 net/bluetooth/l2cap_core.c       |  15 ++++-
 net/bluetooth/mgmt.c             | 113 +++++++++++++++++++++++++++++++++--
 7 files changed, 218 insertions(+), 33 deletions(-)

