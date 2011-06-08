Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH -v2 0/8] More l2cap rewrite
Date: Wed,  8 Jun 2011 12:18:51 -0300
Message-Id: <1307546339-12035-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Second version of the patches that introduce an C API on l2cap_core.c.

-----
changes from v1
- changed function names as suggested by Mat.
- fixed a bug with the new API

Gustavo F. Padovan (8):
  Bluetooth: Merge l2cap_chan_create() in the l2cap_sock_alloc()
  Bluetooth: Add l2cap_chan_ops abstraction
  Bluetooth: add recv() callback to l2cap_chan_ops
  Bluetooth: add close() callback to l2cap_chan_ops
  Bluetooth: Add state tracking to struct l2cap_chan
  Bluetooth: Add refcnt to struct l2cap_chan
  Bluetooth: Make timer functions generic
  Bluetooth: keep reference if any ERTM timer is enabled

 include/net/bluetooth/l2cap.h |   38 ++++--
 net/bluetooth/l2cap_core.c    |  303 +++++++++++++++++++++--------------------
 net/bluetooth/l2cap_sock.c    |   77 +++++++++--
 3 files changed, 245 insertions(+), 173 deletions(-)

-- 
1.7.5.1

