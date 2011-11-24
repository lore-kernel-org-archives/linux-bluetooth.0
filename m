Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 0/6] AMP/BREDR initialization patches
Date: Thu, 24 Nov 2011 14:51:59 +0200
Message-Id: <1322139125-22377-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

RFC for AMP init and block flow control code.

Resubmit "remove old code" patch as it seems that there is little
sense to copy it over.

Marcel is it OK? Otherwise I can copy-paste those commented lines to new
functions.

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

