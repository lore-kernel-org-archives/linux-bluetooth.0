Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	pkrystad@codeaurora.org,
	marcel@holtmann.org,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCHv2 0/2] ERTM state machine changes, part 1
Date: Thu, 29 Mar 2012 17:32:47 -0700
Message-Id: <1333067569-19247-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This is the first of several patch series to rework the ERTM state
machine.  v1 of this patch set had two patches updating header files
that were already merged, v2 has some reworked utility functions that
are used by the new state machine.

Mat Martineau (2):
  Bluetooth: Add the l2cap_seq_list structure for tracking frames
  Bluetooth: Functions parsing or generating ERTM control fields

 include/net/bluetooth/l2cap.h |   12 +++
 net/bluetooth/l2cap_core.c    |  240 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 252 insertions(+)

-- 
1.7.9.4

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
