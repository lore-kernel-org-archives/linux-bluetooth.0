Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	marcel@holtmann.org
Cc: pkrystad@codeaurora.org, andrei.emeltchenko.news@gmail.com
Subject: [RFC 0/8] ERTM state machine changes, part 2
Date: Wed, 25 Apr 2012 16:36:11 -0700
Message-Id: <1335396979-11692-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is the second patch series reworking the ERTM state machine and
closely related streaming mode code.  These patches include a couple
of bug fixes, preparation for future patch series, and segmentation of
outgoing L2CAP data.

Mat Martineau (8):
  Bluetooth: Improve ERTM sequence number offset calculation
  Bluetooth: Initialize new l2cap_chan structure members
  Bluetooth: Remove duplicate structure members from bt_skb_cb
  Bluetooth: Move recently-added ERTM header packing functions
  Bluetooth: Move recently-added ERTM header unpacking functions
  Bluetooth: Lock the L2CAP channel when sending
  Bluetooth: Refactor L2CAP ERTM and streaming transmit segmentation
  Bluetooth: Add Code Aurora Forum copyright

 include/net/bluetooth/bluetooth.h |    3 -
 include/net/bluetooth/l2cap.h     |   12 +-
 net/bluetooth/l2cap_core.c        |  435 +++++++++++++++++++++----------------
 3 files changed, 249 insertions(+), 201 deletions(-)

-- 
1.7.10

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
