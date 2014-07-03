Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/5] LE scanning fixes & cleanups
Date: Thu,  3 Jul 2014 19:21:16 +0300
Message-Id: <1404404481-14518-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's a set of cleanups and fixes I came accross while still working on
the recently added LE scanning code.

Johan

----------------------------------------------------------------
Johan Hedberg (5):
      Bluetooth: Fix missing update of pend_le_reports
      Bluetooth: Remove redundant IRK lookup
      Bluetooth: Use hci_conn_params in pend_le_conns
      Bluetooth: Remove unnecessary checks for auto-connected devices
      Bluetooth: Add identity address check in param lookup functions

 include/net/bluetooth/hci_core.h |  9 +++--
 net/bluetooth/hci_core.c         | 75 ++++++++++++++++---------------------
 net/bluetooth/hci_event.c        | 45 ++++++++++------------
 net/bluetooth/mgmt.c             |  7 +++-
 4 files changed, 61 insertions(+), 75 deletions(-)

