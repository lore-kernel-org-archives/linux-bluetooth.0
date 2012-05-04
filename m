Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Cc: pkrystad@codeaurora.org
Subject: [PATCHv2 0/2] Reworked send locking patches
Date: Fri,  4 May 2012 14:20:29 -0700
Message-Id: <1336166431-4926-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These patches are now based on the bluetooth repository instead of 
bluetooth-next.

Mat Martineau (2):
  Bluetooth: Restore locking semantics when looking up L2CAP channels
  Bluetooth: Lock the L2CAP channel when sending

 include/net/bluetooth/bluetooth.h |    2 --
 net/bluetooth/l2cap_core.c        |   10 +++-------
 net/bluetooth/l2cap_sock.c        |   19 +++++++++++--------
 3 files changed, 14 insertions(+), 17 deletions(-)

-- 
1.7.10

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
