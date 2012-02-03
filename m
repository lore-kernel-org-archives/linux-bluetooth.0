Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 0/2] Adds support for block based flow ctrl
Date: Fri,  3 Feb 2012 16:27:53 +0200
Message-Id: <1328279275-10303-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Split HCI scheduling for block and packet flow control.

Changes:
	No change from RFC I've sent some time ago since I've got
	no comments.

Andrei Emeltchenko (2):
  Bluetooth: Recalculate sched HCI blk/pkt flow ctrl
  Bluetooth: Helper removes duplicated code

 net/bluetooth/hci_core.c |   92 ++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 80 insertions(+), 12 deletions(-)

-- 
1.7.8.3

