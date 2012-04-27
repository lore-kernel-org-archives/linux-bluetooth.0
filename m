Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	marcel@holtmann.org
Cc: pkrystad@codeaurora.org, andrei.emeltchenko.news@gmail.com
Subject: [RFCv2 0/8] ERTM state machine changes, part 2
Date: Fri, 27 Apr 2012 16:50:47 -0700
Message-Id: <1335570655-30878-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Note: Please do not merge **any** of these RFC patches to
bluetooth-next yet. The patches that were merged from the RFCv1 set
were ok. There are several changes to locking code in this series that
need thorough testing and there are some non-obvious dependencies
between certain patches that require them to be merged in order. I
will repost with [PATCH] headers after further review and testing.

This is the second patch series reworking the ERTM state machine and
closely related streaming mode code.  These patches include bug fixes
and segmentation of outgoing L2CAP data.

RFCv1: Four of eight patches were merged already.
RFCv2: Fixed the send lock patch, found and fixed a few more issues
       with locking, reference counting, and unused code.

Mat Martineau (8):
  Bluetooth: Initialize new l2cap_chan structure members
  Bluetooth: Remove unused function
  Bluetooth: Make better use of l2cap_chan reference counting
  Bluetooth: Fix a redundant and problematic incoming MTU check
  Bluetooth: Restore locking semantics when looking up L2CAP channels
  Bluetooth: Lock the L2CAP channel when sending
  Bluetooth: Refactor L2CAP ERTM and streaming transmit segmentation
  Bluetooth: Add Code Aurora Forum copyright

 include/net/bluetooth/bluetooth.h |    2 -
 include/net/bluetooth/l2cap.h     |    1 +
 net/bluetooth/l2cap_core.c        |  227 +++++++++++++++++++------------------
 net/bluetooth/l2cap_sock.c        |   18 +--
 4 files changed, 130 insertions(+), 118 deletions(-)

-- 
1.7.10

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
