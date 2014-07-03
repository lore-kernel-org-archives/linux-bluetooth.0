Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/5] LE scanning fixes & cleanups
Date: Thu,  3 Jul 2014 19:33:46 +0300
Message-Id: <1404405231-16390-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This v2 only modifies 3/5 by simplifying hci_pend_le_conn_add a bit further.

Johan

----------------------------------------------------------------
Johan Hedberg (5):
      Bluetooth: Fix missing update of pend_le_reports
      Bluetooth: Remove redundant IRK lookup
      Bluetooth: Use hci_conn_params in pend_le_conns
      Bluetooth: Remove unnecessary checks for auto-connected devices
      Bluetooth: Add identity address check in param lookup functions

 include/net/bluetooth/hci_core.h |  9 +++--
 net/bluetooth/hci_core.c         | 76 +++++++++++++++-----------------------
 net/bluetooth/hci_event.c        | 45 ++++++++++------------
 net/bluetooth/mgmt.c             |  7 +++-


