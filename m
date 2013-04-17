Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/2] Bluetooth: Add supported features page 2 support
Date: Wed, 17 Apr 2013 15:00:50 +0300
Message-Id: <1366200052-13196-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

CSA4 introduces a new features page 2 in addition to the LMP features
(page 0) and host features (page 1). The handling of these pages
(especially if more will come in future core spec versions) becomes much
simpler if we just store them in a single table indexed by the page
number.

Johan

----------------------------------------------------------------
Johan Hedberg (2):
      Bluetooth: Track feature pages in a single table
      Bluetooth: Add reading of all local feature pages

 include/net/bluetooth/hci_core.h |   50 ++++++++++++++++---------------
 net/bluetooth/hci_core.c         |   10 +++++++
 net/bluetooth/hci_event.c        |   60 ++++++++++++++++++++------------------
 net/bluetooth/hci_sysfs.c        |   16 +++++-----
 4 files changed, 76 insertions(+), 60 deletions(-)

