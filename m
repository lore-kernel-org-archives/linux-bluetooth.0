Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/7] Bluetooth: Hook up connectable setting for LE
Date: Mon, 14 Oct 2013 13:52:38 +0300
Message-Id: <1381747965-24599-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This set of patches adds hooks to associsate the connectable setting
with the LE advertising type. This means that we can now do
non-connectable advertising by enabling the advertising setting but
having the connectable setting disabled.

Johan

----------------------------------------------------------------
Johan Hedberg (7):
      Bluetooth: Add connectable argument to enable_advertising()
      Bluetooth: Reorganize set_connectable HCI command sending
      Bluetooth: Move static advertising functions to avoid forward declarations
      Bluetooth: Fix updating advertising data needlessly
      Bluetooth: Update Set Connectable to also impact the advertising type
      Bluetooth: Move set_bredr_scan() to avoid forward declaration
      Bluetooth: Fix updating scan mode in set_bredr()

 net/bluetooth/hci_event.c |   2 +-
 net/bluetooth/mgmt.c      | 169 ++++++++++++++++++++++++++--------------------
 2 files changed, 98 insertions(+), 73 deletions(-)

