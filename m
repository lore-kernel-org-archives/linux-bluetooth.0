Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, pkrystad@codeaurora.org,
	marcel@holtmann.org, Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCHv3 0/2] ERTM state machine changes, part 1
Date: Tue,  3 Apr 2012 15:48:50 -0700
Message-Id: <1333493332-24623-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is the first of several patch series to rework the ERTM state
machine.

PATCHv1: Four patches, two patches updating header files were merged
PATCHv2: Reworked utility functions for seq_lists and control headers
PATCHv3: Removed extra debug output, added error handling for
  allocation failure, used some long lines at Marcel's request, removed
  an unnecessary variable, and added a __set_control function.

Mat Martineau (2):
  Bluetooth: Add the l2cap_seq_list structure for tracking frames
    (Acked-by Marcel last time, but added new error handling code)
  Bluetooth: Functions for handling ERTM control fields

 include/net/bluetooth/l2cap.h |   12 ++
 net/bluetooth/l2cap_core.c    |  251 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 255 insertions(+), 8 deletions(-)

-- 
1.7.9.4

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
