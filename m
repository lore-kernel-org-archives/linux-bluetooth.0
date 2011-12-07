Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 0/6] Implement basic HCI block-based flow control
Date: Wed,  7 Dec 2011 15:56:50 +0200
Message-Id: <1323266216-25261-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Changes:
	RFCv2: taken Marcel's comments: added check for flow control,
	removed magic pointers and numbers, added SCO type check.

Simplify current handling of number of completed packets.
Adds basic HCI commands and event handlers related to data block
flow control.

Andrei Emeltchenko (6):
  Bluetooth: Add HCI Read Data Block Size function
  Bluetooth: Simplify num_comp_pkts_evt function
  Bluetooth: Check for flow control mode
  Bluetooth: Clean up magic pointers
  Bluetooth: Correct packet len calculation
  Bluetooth: Process num completed data blocks event

 include/net/bluetooth/hci.h      |   28 +++++++-
 include/net/bluetooth/hci_core.h |    5 ++
 net/bluetooth/hci_event.c        |  149 +++++++++++++++++++++++++++++++-------
 3 files changed, 156 insertions(+), 26 deletions(-)

-- 
1.7.4.1

