Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/4] Bluetooth: Local name fixes for LE controllers
Date: Thu, 28 Feb 2013 14:23:11 +0200
Message-Id: <1362054195-18919-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Dependency: Bluetooth: Add HCI transaction framework

This set of patches fixes setting the local name for LE controllers. By
ensuring that the right HCI commands get sent (and the wrong ones don't
get sent) and by refactoring the way the hci_update_ad() function is
used.

Johan

----------------------------------------------------------------
Johan Hedberg (4):
      Bluetooth: Fix waiting for EIR update when setting local name
      Bluetooth: Handle AD updating through a transaction
      Bluetooth: Fix local name setting for LE-only controllers
      Bluetooth: Fix setting local name to the existing value

 include/net/bluetooth/hci_core.h |    4 +-
 net/bluetooth/hci_core.c         |   30 +++++------
 net/bluetooth/hci_event.c        |   19 ++++---
 net/bluetooth/mgmt.c             |  101 +++++++++++++++++++++-----------------
 4 files changed, 77 insertions(+), 77 deletions(-)

