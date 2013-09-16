Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 0/8] Bluetooth: Various L2CAP fixes
Date: Mon, 16 Sep 2013 13:05:11 +0300
Message-Id: <1379325919-19003-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's a fifth revision with all feedback taken into account (as far as
these 8 patches are concerned). There's still the issue of verifying
sk locking in l2cap_sock_sendmsg as well as a potentially missing
comment for the wait_state function, but even if those fixes are needed
they'll end up being in separate patches. So, I'm hoping this patch set
could start reaching its conclusion.

Johan

----------------------------------------------------------------
Johan Hedberg (8):
      Bluetooth: Remove unused event mask struct
      Bluetooth: Fix double error response for l2cap_create_chan_req
      Bluetooth: Fix L2CAP error return used for failed channel lookups
      Bluetooth: Fix L2CAP Disconnect response for unknown CID
      Bluetooth: Fix L2CAP command reject reason
      Bluetooth: Fix sending responses to identified L2CAP response packets
      Bluetooth: Fix responding to invalid L2CAP signaling commands
      Bluetooth: Fix waiting for clearing of BT_SK_SUSPEND flag

 include/net/bluetooth/bluetooth.h |  1 +
 include/net/bluetooth/hci.h       |  3 ---
 net/bluetooth/af_bluetooth.c      | 40 ++++++++++++++++++++++++++++
 net/bluetooth/l2cap_core.c        | 52 +++++++++++++++++++++++++------------
 net/bluetooth/l2cap_sock.c        |  6 +++++
 net/bluetooth/rfcomm/sock.c       |  7 ++++-
 6 files changed, 89 insertions(+), 20 deletions(-)

