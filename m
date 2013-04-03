Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/2] Bluetooth: Add __hci_cmd_sync() helper
Date: Wed,  3 Apr 2013 16:52:44 +0300
Message-Id: <1364997166-24236-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This function is mainly intended as a helper for the hdev->setup()
routine which needs to be able to wait for completion of its commands
before returning (i.e. a pre-requisite is Marcel's patch set I sent
yesterday).

Johan

----------------------------------------------------------------
Johan Hedberg (2):
      Bluetooth: Track received events in hdev
      Bluetooth: Add __hci_cmd_sync() helper function

 include/net/bluetooth/hci_core.h |    5 ++
 net/bluetooth/hci_core.c         |   98 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |    8 ++++
 3 files changed, 111 insertions(+)


