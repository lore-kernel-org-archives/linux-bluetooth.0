Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	gustavo@padovan.org,
	marcel@holtmann.org
Cc: pkrystad@codeaurora.org,
	ulisses@profusion.mobi,
	andrei.emeltchenko.news@gmail.com
Subject: [PATCH 0/4] ERTM state machine changes, part 2
Date: Wed,  2 May 2012 09:41:58 -0700
Message-Id: <1335976922-19456-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This is the second patch series reworking the ERTM state machine and
closely related streaming mode code.  These patches include bug fixes
and segmentation of outgoing L2CAP data.

RFCv1:   Four of eight patches were merged.
RFCv2:   Fixed the send lock patch, found and fixed a few more issues
         with locking, reference counting, and unused code.  Four of
         eight patches were merged.
PATCHv1: Confirmed ERTM operation with locking and segmentation updates


Mat Martineau (4):
  Bluetooth: Fix a redundant and problematic incoming MTU check
  Bluetooth: Restore locking semantics when looking up L2CAP channels
  Bluetooth: Lock the L2CAP channel when sending
  Bluetooth: Refactor L2CAP ERTM and streaming transmit segmentation

 include/net/bluetooth/bluetooth.h |    2 -
 include/net/bluetooth/l2cap.h     |    1 +
 net/bluetooth/l2cap_core.c        |  184 +++++++++++++++++++------------------
 net/bluetooth/l2cap_sock.c        |   15 +--
 4 files changed, 103 insertions(+), 99 deletions(-)

-- 
1.7.10

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
