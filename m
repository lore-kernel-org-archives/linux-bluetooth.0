Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, pkrystad@codeaurora.org,
	andrei.emeltchenko@intel.com,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 0/9] AMP interface and signal framework
Date: Thu, 13 Oct 2011 15:00:38 -0700
Message-Id: <1318543247-27130-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set includes the AMP policy socket option that was
previously discussed and accepted in to bluetooth-testing, and the
signaling framework for AMP channel creation and AMP channel moves.

There is overlap with Andrei Emeltchenko's RFC ("L2CAP and HCI
preparation code for A2MP") earlier this week.  We (and Andrei) aren't
trying to have dueling patch sets - we very much want to cooperate and
get the AMP functionality upstreamed efficiently.  We were in touch
with him earlier in the week to see how far he was with the porting
effort.

Next steps:
 * L2CAP lockstep configuration
 * HCI layer changes for AMP HCI commands and physical/logical links
 * The rest of the create channel and move channel code
 * Move channel coordination with ERTM
 * AMP manager
 * ERTM optimizations

Mat Martineau (9):
  Bluetooth: Add BT_AMP_POLICY socket option
  Bluetooth: Add AMP policy information to l2cap_chan
  Bluetooth: Get/set AMP policy socket option
  Bluetooth: Add AMP-related data and structures for channel signals
  Bluetooth: Add signal handlers for channel creation
  Bluetooth: Add definitions for L2CAP fixed channels
  Bluetooth: Use symbolic values for the fixed channel map
  Bluetooth: Add AMP header file
  Bluetooth: Add signal handlers for channel moves

 include/net/bluetooth/amp.h       |   20 +++++
 include/net/bluetooth/bluetooth.h |   27 ++++++
 include/net/bluetooth/l2cap.h     |   65 ++++++++++++++
 net/bluetooth/l2cap_core.c        |  172 ++++++++++++++++++++++++++++++++++++-
 net/bluetooth/l2cap_sock.c        |   25 ++++++
 5 files changed, 308 insertions(+), 1 deletions(-)
 create mode 100644 include/net/bluetooth/amp.h

-- 
1.7.7

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

