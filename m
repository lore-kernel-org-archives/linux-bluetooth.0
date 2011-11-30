Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 0/6] AMP/BREDR initialization patches
Date: Wed, 30 Nov 2011 11:35:59 +0200
Message-Id: <1322645765-9519-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Changes:
	v1: Changed HCI_<block,packet>_FLOW_CTL_MODE => HCI_FLOW_CTL_MODE_<block,packet>
	RFCv1: Initial version

AMP initialization and block flow control code.

Resubmit "remove old code" patch as it seems that there is little
sense to copy it over.

Andrei Emeltchenko (6):
  Bluetooth: remove old code
  Bluetooth: Split ctrl init to BREDR and AMP parts
  Bluetooth: Add HCI Read Flow Control Mode function
  Bluetooth: Initialize default flow control mode
  Bluetooth: Add HCI Read Data Block Size function
  Bluetooth: Recalculate sched for HCI block flow ctrl

 include/net/bluetooth/hci.h      |   18 +++++++
 include/net/bluetooth/hci_core.h |    4 ++
 net/bluetooth/hci_core.c         |  103 +++++++++++++++++++++++++------------
 net/bluetooth/hci_event.c        |   53 +++++++++++++++++++
 4 files changed, 144 insertions(+), 34 deletions(-)

-- 
1.7.4.1

