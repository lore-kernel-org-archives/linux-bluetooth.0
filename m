Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 0/5] Rebased AMP initialization patches
Date: Mon, 19 Dec 2011 16:31:26 +0200
Message-Id: <1324305091-19393-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Changes:
	v3: rebased unapplied patches
	v2: added helper function for block calculation, added patches for
	checking BREDR when going to Sniff mode and complete Read Local Version
	HCI command.
	v1: Changed HCI_<block,packet>_FLOW_CTL_MODE => HCI_FLOW_CTL_MODE_<block,packet>
	RFCv1: Initial version

AMP initialization and block flow control code.

Andrei Emeltchenko (5):
  Bluetooth: Split ctrl init to BREDR and AMP parts
  Bluetooth: Initialize default flow control mode
  Bluetooth: Check for flow control mode
  Bluetooth: Clean up magic pointers
  Bluetooth: Correct packet len calculation

 include/net/bluetooth/hci.h |   11 ++++++-
 net/bluetooth/hci_core.c    |   66 ++++++++++++++++++++++++++++++++-----------
 net/bluetooth/hci_event.c   |   23 ++++++++++-----
 3 files changed, 74 insertions(+), 26 deletions(-)

-- 
1.7.4.1

