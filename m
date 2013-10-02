Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/2] Bluetooth: Add a new mgmt_set_bredr command
Date: Wed,  2 Oct 2013 12:10:38 +0300
Message-Id: <1380705040-16300-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This is a new revision of the previous RFC with all feedback taken into
account. Additionally, the setting can now only be disabled while
powered off which means that the second patch from my previous set
becomes unnecessary (and has therefore been dropped).

Johan

----------------------------------------------------------------
Johan Hedberg (2):
      Bluetooth: Introduce a new HCI_BREDR_ENABLED flag
      Bluetooth: Add a new mgmt_set_bredr command

 include/net/bluetooth/hci.h  |   1 +
 include/net/bluetooth/mgmt.h |   2 +
 net/bluetooth/hci_conn.c     |   3 +
 net/bluetooth/hci_core.c     |  21 +++++-
 net/bluetooth/hci_event.c    |   5 ++
 net/bluetooth/mgmt.c         | 148 ++++++++++++++++++++++++++++++++++++++----
 6 files changed, 167 insertions(+), 13 deletions(-)

