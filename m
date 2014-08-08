Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/3] A few more cleanups for l2cap_chan based SMP
Date: Fri,  8 Aug 2014 09:28:02 +0300
Message-Id: <1407479285-4261-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here are a few more cleanups/fixes in preparation for converting SMP to
use l2cap_chan.

Johan

----------------------------------------------------------------
Johan Hedberg (3):
      Bluetooth: Call L2CAP teardown callback before clearing chan->conn
      Bluetooth: Call l2cap_le_conn_ready after notifying channels
      Bluetooth: Fix using HCI_CONN_LE_SMP_PEND to check for SMP context

 net/bluetooth/l2cap_core.c | 10 +++++-----
 net/bluetooth/smp.c        |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)


