Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	marcel@holtmann.org
Cc: pkrystad@codeaurora.org
Subject: [PATCH 0/2] l2cap_chan init and delete fixes for ERTM
Date: Thu, 17 May 2012 16:20:12 -0700
Message-Id: <1337296814-3763-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I came across a repeatable crash when testing the new ERTM state
machine, and traced it down to some unexpected control flow in
l2cap_chan_del.  This also led me to discover a possible, but
unlikely, leak in some recently added l2cap_ertm_init code.

Mat Martineau (2):
  Bluetooth: Fix early return from l2cap_chan_del
  Bluetooth: Free allocated ERTM SREJ list if init fails

 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/l2cap_core.c    |   10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

-- 
1.7.10

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
