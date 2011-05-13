Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH -v2 0/7] L2CAP rework patches
Date: Fri, 13 May 2011 16:20:43 -0300
Message-Id: <1305314450-25493-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is part of the ongoing series to fix the L2CAP core and remove its socket
dependence.

Changes since v1:
- Fixed styles issues and typos reported by Lizardo
- renamed link_type to chan_type
- renamed L2CAP_LINK_RAW to L2CAP_CHAN_RAW
- renamed L2CAP_LINK_CONNLESS to L2CAP_CHAN_CONN_LESS
- renamed L2CAP_LINK_ORIENTED to L2CAP_CHAN_CONN_ORIENTED

Gustavo F. Padovan (7):
  Bluetooth: Remove leftover debug messages
  Bluetooth: Create __l2cap_chan_close()
  Bluetooth: Create l2cap_chan_send()
  Bluetooth: Add chan->chan_type struct member
  Bluetooth: create channel timer to replace sk_timer
  Bluetooth: Remove export of l2cap_chan_clear_timer()
  Bluetooth: Rename __l2cap_chan_close() to l2cap_chan_close()

 include/net/bluetooth/l2cap.h |   23 ++--
 net/bluetooth/l2cap_core.c    |  289 ++++++++++++++++++++++++++++++++++------
 net/bluetooth/l2cap_sock.c    |  244 ++++-------------------------------
 3 files changed, 280 insertions(+), 276 deletions(-)

-- 
1.7.5.rc3

