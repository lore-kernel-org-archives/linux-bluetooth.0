Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/2] Bluetooth: Add new HCI commands to the init sequence
Date: Fri, 13 Sep 2013 11:40:00 +0300
Message-Id: <1379061602-8290-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

These two patches add a couple of new(ish) HCI commands to the init
sequence. Event mask page 2 has been available already since core spec
4.0 whereas the sync train parameters were introduced in CSA4.

Johan

----------------------------------------------------------------
Johan Hedberg (2):
      Bluetooth: Add synchronization train parameters reading support
      Bluetooth: Add event mask page 2 setting support

 include/net/bluetooth/hci.h |  4 ++++
 net/bluetooth/hci_core.c    | 47 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 1 deletion(-)

