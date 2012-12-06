Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH 0/3 v1] Fix stop discovery not handled if discovery state is
 STARTING
Date: Thu, 06 Dec 2012 16:35:55 +0530
Message-id: <1354791958-28334-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If user calls stop_discovery when the discovery state is STARTING, then it fails.
In this scenario discovery will continue. 

This patch handles stop_discovery even if state is STARTING

Jaganath Kanakkassery (3):
  Bluetooth: Rename stop_discovery_failed() to
    stop_discovery_complete()
  Bluetooth: Move discovery state check inside hci_dev_lock()
  Bluetooth: Fix stop discovery while in STARTING state

 include/net/bluetooth/hci_core.h |    3 ++-
 net/bluetooth/hci_core.c         |    9 ++++++++-
 net/bluetooth/hci_event.c        |   28 +++++++++++++++++++---------
 net/bluetooth/mgmt.c             |   15 ++++++++++-----
 4 files changed, 39 insertions(+), 16 deletions(-)

-- 
1.7.9.5

