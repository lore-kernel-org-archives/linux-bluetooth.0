Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 0/8] Bluetooth: Various L2CAP fixes
Date: Sat, 14 Sep 2013 20:28:23 +0300
Message-Id: <1379179711-16436-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This set started off with just three patches but after looking into the
code based on feedback from Marcel there were several other issues that
were found which prompted for more patches.

Johan

----------------------------------------------------------------
Johan Hedberg (8):
      Bluetooth: Remove unused event mask struct
      Bluetooth: Fix L2CAP command reject reason
      Bluetooth: Fix double error response for l2cap_create_chan_req
      Bluetooth: Fix L2CAP Disconnect response for unknown CID
      Bluetooth: Fix error code for invalid CID in l2cap_config_req
      Bluetooth: Fix sending responses to identified L2CAP response packets
      Bluetooth: Fix responding to invalid L2CAP signaling commands
      Bluetooth: Fix waiting for clearing of BT_SK_SUSPEND flag

 include/net/bluetooth/bluetooth.h |  1 +
 include/net/bluetooth/hci.h       |  3 ---
 net/bluetooth/af_bluetooth.c      | 39 ++++++++++++++++++++++++++++++
 net/bluetooth/l2cap_core.c        | 48 +++++++++++++++++++++++++++----------
 net/bluetooth/l2cap_sock.c        |  6 +++++
 net/bluetooth/rfcomm/sock.c       |  9 +++++--
 6 files changed, 88 insertions(+), 18 deletions(-)

