Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/5] Bluetooth: Page scan fixes & improvements
Date: Mon, 28 Jul 2014 15:10:11 +0300
Message-Id: <1406549416-9229-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Patches 1 and 2 are the same as I already sent as a two-patch set. The
rest are new. Out of these 5/5 is probably the single most important one
since that's an actual bug fix to the current bluetooth-next tree which
should go to mainline before 3.17-rc1 (even if the other patches get
postponed for 3.18).

Johan

----------------------------------------------------------------
Johan Hedberg (5):
      Bluetooth: Add convenience function to check for pending power off
      Bluetooth: Disable page scan if all whitelisted devices are connected
      Bluetooth: Fix updating whitelist state for existing connections
      Bluetooth: Fix redundant scan mode updates
      Bluetooth: Fix incorrectly disabling page scan when toggling connectable

 include/net/bluetooth/hci_core.h |   2 +
 net/bluetooth/hci_event.c        |  35 +++++++++++--
 net/bluetooth/mgmt.c             | 101 ++++++++++++++++++++++++++----------
 3 files changed, 107 insertions(+), 31 deletions(-)

