Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/3] Bluetooth: Various L2CAP fixes
Date: Fri, 13 Sep 2013 14:29:24 +0300
Message-Id: <1379071767-16604-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This one contains a fix for the locking bug spotted by Lizardo in patch
3/3 as well as the minor coding style issue in the same patch.

Johan

----------------------------------------------------------------
Johan Hedberg (3):
      Bluetooth: Fix L2CAP Disconnect response for unknown CID
      Bluetooth: Fix responding to invalid L2CAP signaling commands
      Bluetooth: Fix waiting for clearing of BT_SK_SUSPEND flag

 include/net/bluetooth/bluetooth.h |  1 +
 net/bluetooth/af_bluetooth.c      | 39 +++++++++++++++++++++++++++++++++++++
 net/bluetooth/l2cap_core.c        | 10 +++++++++-
 net/bluetooth/l2cap_sock.c        |  6 ++++++
 net/bluetooth/rfcomm/sock.c       |  9 +++++++--
 5 files changed, 62 insertions(+), 3 deletions(-)

