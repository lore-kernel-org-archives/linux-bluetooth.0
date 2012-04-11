Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Cc: pkrystad@codeaurora.org, marcel@holtmann.org,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCHv6 0/2] ERTM state machine changes, part 1
Date: Wed, 11 Apr 2012 10:48:41 -0700
Message-Id: <1334166523-11060-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PATCHv1: Four patches, two patches updating header files were merged
PATCHv2: Reworked utility functions for seq_lists and control headers.
PATCHv3: Removed extra debug output, added error handling for
  allocation failure, used some long lines at Marcel's request, removed
  an unnecessary variable, and added a __set_control function.
PATCHv4: Use roundup_pow_of_two macro and kmalloc
PATCHv5: No warnings
PATCHv6: Fix indentation issue introduced in v5

Mat Martineau (2):
  Bluetooth: Add the l2cap_seq_list structure for tracking frames
  Bluetooth: Functions for handling ERTM control fields

 include/net/bluetooth/l2cap.h |   12 ++
 net/bluetooth/l2cap_core.c    |  263 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 267 insertions(+), 8 deletions(-)

-- 
1.7.10

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
