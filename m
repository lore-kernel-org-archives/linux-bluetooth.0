Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [RFC 00/16] Completely remove socket dependency from l2cap_core.c
Date: Wed, 12 Dec 2012 02:13:28 -0200
Message-Id: <1355285624-25811-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

This is the last series of patches to completely remove the l2cap socket usage
in the l2cap_core.c file. We now have a C API to access L2CAP and as a next
step we should convert RFCOMM to use this API.

Gustavo Padovan (16):
  Bluetooth: Add src and dst info to struct l2cap_chan
  Bluetooth: Remove sk_sndtimeo from l2cap_core.c
  Bluetooth: extend state_change() call to report errors too
  Bluetooth: add l2cap_state_change_and_error()
  Bluetooth: Add missing braces to an "else if"
  Bluetooth: use l2cap_chan_ready() instead of duplicate code
  Bluetooth: duplicate DEFER_SETUP flag on l2cap_chan
  Bluetooth: Improving locking in l2cap_conn_start()
  Bluetooth: lock socket in defer_cb call
  Bluetooth: Remove socket lock from state_change() in l2cap_core
  Bluetooth: remove parent socket usage from l2cap_core.c
  Bluetooth: Use abstract chan->data in comparison
  Bluetooth: Move l2cap_wait_ack() to l2cap_sock.c
  Bluetooth: Create l2cap->ops->resume()
  Bluetooth: Create l2cap->ops->set_shutdown()
  Bluetooth: Remove sk member from struct l2cap_chan

 include/net/bluetooth/l2cap.h |  20 ++++-
 net/bluetooth/a2mp.c          |   4 +-
 net/bluetooth/l2cap_core.c    | 200 ++++++++++++------------------------------
 net/bluetooth/l2cap_sock.c    |  95 +++++++++++++++++---
 4 files changed, 159 insertions(+), 160 deletions(-)

-- 
1.7.11.7

