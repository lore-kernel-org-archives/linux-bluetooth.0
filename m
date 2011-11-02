Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, pkrystad@codeaurora.org,
	Andrei.Emeltchenko.news@gmail.com,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCHv4 0/9] AMP interface and signal framework
Date: Wed,  2 Nov 2011 16:18:27 -0700
Message-Id: <1320275916-32103-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set includes the AMP policy socket option that was
previously discussed and accepted in to bluetooth-testing, and the
signaling framework for AMP channel creation and AMP channel moves.

Next steps:
 * L2CAP lockstep configuration
 * HCI layer changes for AMP HCI commands and physical/logical links
 * The rest of the create channel and move channel code
 * Move channel coordination with ERTM
 * AMP manager
 * ERTM optimizations

Mat Martineau (9):
  Bluetooth: Add BT_CHANNEL_POLICY socket option
  Bluetooth: Change scope of the enable_hs module parameter
  Bluetooth: Add channel policy to getsockopt/setsockopt
  Bluetooth: Add AMP-related data and structures for channel signals
  Bluetooth: Add signal handlers for channel creation
  Bluetooth: Add definitions for L2CAP fixed channels
  Bluetooth: Use symbolic values for the fixed channel map
  Bluetooth: Add signal handlers for channel moves
  Bluetooth: Guarantee BR-EDR device will be registered as hci0

 include/net/bluetooth/bluetooth.h |   27 +++++
 include/net/bluetooth/l2cap.h     |   60 +++++++++++-
 net/bluetooth/hci_core.c          |    7 +-
 net/bluetooth/l2cap_core.c        |  191 ++++++++++++++++++++++++++++++++++++-
 net/bluetooth/l2cap_sock.c        |   35 +++++++
 5 files changed, 316 insertions(+), 4 deletions(-)

-- 
1.7.7.1

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
