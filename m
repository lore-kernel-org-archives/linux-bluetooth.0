Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 0/8] Bluetooth: Various L2CAP fixes
Date: Sun, 15 Sep 2013 21:16:33 +0300
Message-Id: <1379269001-6313-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's a fourth revision of this patch set with all feedback received so
far taken into account.

----------------------------------------------------------------
Johan Hedberg (8):
      Bluetooth: Remove unused event mask struct
      Bluetooth: Fix double error response for l2cap_create_chan_req
      Bluetooth: Fix L2CAP command reject reason
      Bluetooth: Fix L2CAP Disconnect response for unknown CID
      Bluetooth: Fix L2CAP error return used for failed channel lookups
      Bluetooth: Fix sending responses to identified L2CAP response packets
      Bluetooth: Fix responding to invalid L2CAP signaling commands
      Bluetooth: Fix waiting for clearing of BT_SK_SUSPEND flag

 include/net/bluetooth/bluetooth.h |  1 +
 include/net/bluetooth/hci.h       |  3 ---
 net/bluetooth/af_bluetooth.c      | 39 +++++++++++++++++++++++++++++
 net/bluetooth/l2cap_core.c        | 50 ++++++++++++++++++++++++++-----------
 net/bluetooth/l2cap_sock.c        |  6 +++++
 net/bluetooth/rfcomm/sock.c       |  9 +++++--
 6 files changed, 88 insertions(+), 20 deletions(-)

