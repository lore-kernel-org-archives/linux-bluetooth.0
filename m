Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/3] Bluetooth: LE connection fixes & cleanups
Date: Wed, 11 Nov 2015 14:44:56 +0200
Message-Id: <1447245899-30783-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This set of patches simplifies the LE connection logic and fixes
outgoing connect attempts through directed advertising.

Johan

----------------------------------------------------------------
Johan Hedberg (3):
      Bluetooth: Fix specifying role for LE connections
      Bluetooth: Move check for ongoing connect earlier in hci_connect_le()
      Bluetooth: Remove conn_unfinished variable from hci_connect_le()

 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/hci_conn.c         | 60 ++++++++++++---------------------------
 net/bluetooth/l2cap_core.c       | 15 +++++-----
 net/bluetooth/mgmt.c             |  3 +-
 4 files changed, 27 insertions(+), 53 deletions(-)

