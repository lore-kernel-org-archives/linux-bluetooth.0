Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH v2 0/3] Zero-copy L2CAP ERTM & streaming reassembly
Date: Fri, 22 Jul 2011 14:53:57 -0700
Message-Id: <1311371640-10324-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch series changes SDU reassembly to link together PDU skbs
using a frag list instead of copying all data bytes to a single,
linear skb.  The reduction in overhead is especially helpful with high
speed AMP links.

Mat Martineau (3):
  Bluetooth: Linearize skbs for use in BNEP, CMTP, HIDP, and RFCOMM
  Bluetooth: Handle fragmented skbs in bt_sock_stream_recvmsg()
  Bluetooth: Perform L2CAP SDU reassembly without copying data

 include/net/bluetooth/l2cap.h |    3 +-
 net/bluetooth/af_bluetooth.c  |   30 +++++-
 net/bluetooth/bnep/core.c     |    5 +-
 net/bluetooth/cmtp/core.c     |    5 +-
 net/bluetooth/hidp/core.c     |   10 ++-
 net/bluetooth/l2cap_core.c    |  241 ++++++++++++++---------------------------
 net/bluetooth/rfcomm/core.c   |    5 +-
 7 files changed, 129 insertions(+), 170 deletions(-)

-- 
1.7.6

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

