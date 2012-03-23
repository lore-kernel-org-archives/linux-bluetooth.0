Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	pkrystad@codeaurora.org,
	marcel@holtmann.org,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 0/4] ERTM state machine changes, part 1
Date: Fri, 23 Mar 2012 16:56:54 -0700
Message-Id: <1332547018-19468-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This is the first in several patch series to rework the ERTM state
machine.  These are some early changes to the headers, and some
utility functions that are used by the new state machine.

Mat Martineau (4):
  Bluetooth: Add definitions and struct members for new ERTM state
    machine
  Bluetooth: Add a structure to carry ERTM data in skb control blocks
  Bluetooth: Add the l2cap_seq_list structure for tracking frames
  Bluetooth: Functions parsing or generating ERTM control fields

 include/net/bluetooth/bluetooth.h |   13 ++
 include/net/bluetooth/l2cap.h     |   62 ++++++++++
 net/bluetooth/l2cap_core.c        |  248 +++++++++++++++++++++++++++++++++++++
 3 files changed, 323 insertions(+)

-- 
1.7.9.4

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
