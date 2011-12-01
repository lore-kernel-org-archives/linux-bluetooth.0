Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 0/8] AMP/BREDR initialization patches
Date: Thu,  1 Dec 2011 14:42:07 +0200
Message-Id: <1322743335-8671-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Changes:
	v2: added helper function for block calculation, added patches for
	checking BREDR when going to Sniff mode and complete Read Local Version
	HCI command.
	v1: Changed HCI_<block,packet>_FLOW_CTL_MODE => HCI_FLOW_CTL_MODE_<block,packet>
	RFCv1: Initial version

AMP initialization and block flow control code.

Resubmit "remove old code" patch as it seems that there is little
sense to copy it over.

Andrei Emeltchenko (8):
  Bluetooth: remove old code
  Bluetooth: Split ctrl init to BREDR and AMP parts
  Bluetooth: Add HCI Read Flow Control Mode function
  Bluetooth: Initialize default flow control mode
  Bluetooth: Add HCI Read Data Block Size function
  Bluetooth: Recalculate sched for HCI block flow ctrl
  Bluetooth: Use SNIFF mode only for BREDR controller
  Bluetooth: Complete Read Local Version HCI cmd

 include/net/bluetooth/hci.h      |   18 ++++++
 include/net/bluetooth/hci_core.h |    4 +
 net/bluetooth/hci_conn.c         |    6 ++
 net/bluetooth/hci_core.c         |  116 +++++++++++++++++++++++++++-----------
 net/bluetooth/hci_event.c        |   58 +++++++++++++++++++-
 5 files changed, 167 insertions(+), 35 deletions(-)

-- 
1.7.4.1

