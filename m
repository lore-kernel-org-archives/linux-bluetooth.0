Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 0/3] Implement basic block flow control code
Date: Mon,  5 Dec 2011 14:55:01 +0200
Message-Id: <1323089704-1005-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Adds basic HCI commands and event handlers related to data block
flow control.

Andrei Emeltchenko (3):
  Bluetooth: Add HCI Read Data Block Size function
  Bluetooth: Simplify num_comp_pkts_evt function
  Bluetooth: Process num completed data blocks event

 include/net/bluetooth/hci.h      |   15 +++++
 include/net/bluetooth/hci_core.h |    5 ++
 net/bluetooth/hci_event.c        |  130 ++++++++++++++++++++++++++++++++-----
 3 files changed, 132 insertions(+), 18 deletions(-)

-- 
1.7.4.1

