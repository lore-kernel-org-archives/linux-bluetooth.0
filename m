Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/2] Disconnect complete refactoring
Date: Mon,  4 Nov 2013 14:57:25 -0300
Message-Id: <1383587847-16523-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This small patch set contains the remaining patches from "[RFC] Disconnect
complete refactoring" patch set which weren't applied due to coding style
issues.

Andre Guedes (2):
  Bluetooth: Remove unneeded check in hci_disconn_complete_evt()
  Bluetooth: Refactor hci_disconn_complete_evt

 net/bluetooth/hci_event.c | 59 ++++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 31 deletions(-)

-- 
1.8.4

