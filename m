Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org, pkrystad@codeaurora.org, marcel@holtmann.org,
	andrei.emeltchenko.news@gmail.com, szymon.janc@tieto.com,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCHv4 0/2] ERTM state machine changes, part 1
Date: Wed,  4 Apr 2012 11:29:41 -0700
Message-Id: <1333564183-23442-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is the first of several patch series to rework the ERTM state
machine.

PATCHv1: Four patches, two patches updating header files were merged
PATCHv2: Reworked utility functions for seq_lists and control headers.
PATCHv3: Removed extra debug output, added error handling for
  allocation failure, used some long lines at Marcel's request, removed
  an unnecessary variable, and added a __set_control function.
PATCHv4: Use roundup_pow_of_two macro and kmalloc

Mat Martineau (2):
  Bluetooth: Add the l2cap_seq_list structure for tracking frames
    (Acked-by Marcel at v2, but added new error handling code in v3)
  Bluetooth: Functions for handling ERTM control fields

 include/net/bluetooth/l2cap.h |   12 ++
 net/bluetooth/l2cap_core.c    |  247 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 251 insertions(+), 8 deletions(-)

-- 
1.7.9.4

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
