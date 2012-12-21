Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH v2 0/2] Fix stop discovery not handled if discovery state is
 STARTING
Date: Fri, 21 Dec 2012 18:20:23 +0530
Message-id: <1356094225-12706-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If user calls stop_discovery when the discovery state is STARTING, then it fails.
In this scenario discovery will continue. 

This patch handles stop_discovery even if state is STARTING

v2---> Incorporated Gustavo's comments

Jaganath Kanakkassery (2):
  Bluetooth: Move discovery state check inside hci_dev_lock()
  Bluetooth: Fix stop discovery while in STARTING state

 include/net/bluetooth/hci_core.h |    2 ++
 net/bluetooth/hci_event.c        |   23 ++++++++++++++++-------
 net/bluetooth/mgmt.c             |   35 ++++++++++++++++++++++++++++++-----
 3 files changed, 48 insertions(+), 12 deletions(-)

-- 
1.7.9.5

