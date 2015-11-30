Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/2] Bluetooth: Advertising cleanups
Date: Mon, 30 Nov 2015 11:21:43 +0200
Message-Id: <1448875305-1347-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here are a few patches to simplify & clean up advertising handling. I
might be doing a bit more similar things before going for refactoring
all of the advertising HCI activitity behind hdev->req_workqueue and
hci_req_sync().

Johan

----------------------------------------------------------------
Johan Hedberg (2):
      Bluetooth: Clean up advertising initialization in powered_update_hci()
      Bluetooth: Clean up current advertising instance tracking

 net/bluetooth/hci_core.c    | 12 ++++--
 net/bluetooth/hci_request.c | 98 ++++++++++++--------------------------------
 net/bluetooth/hci_request.h |  8 ++--
 net/bluetooth/mgmt.c        | 10 +++--
 4 files changed, 44 insertions(+), 84 deletions(-)

