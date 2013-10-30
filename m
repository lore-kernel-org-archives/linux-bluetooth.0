Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 0/5] Disconnect complete refactoring
Date: Wed, 30 Oct 2013 19:01:39 -0300
Message-Id: <1383170504-16602-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This patch set does some code refactoring in disconnect complete event handler
and related functions from Mgmt layer.

This refactoring used to be one patch from LE auto connection patch set, but
since Marcel asked me to do more changes, I put all these refactoring patches
in its own patch set.

Regards,

Andre Guedes (5):
  Bluetooth: Check address in mgmt_disconnect_failed()
  Bluetooth: Add an extra check in mgmt_device_disconnected()
  Bluetooth: Remove link type check in hci_disconn_complete_evt()
  Bluetooth: Remove unneeded check in hci_disconn_complete_evt()
  Bluetooth: Refactor hci_disconn_complete_evt

 net/bluetooth/hci_event.c | 61 ++++++++++++++++++++++-------------------------
 net/bluetooth/mgmt.c      | 15 +++++++++++-
 2 files changed, 43 insertions(+), 33 deletions(-)

-- 
1.8.4

