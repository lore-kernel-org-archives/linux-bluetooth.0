Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1] Split AMP init sequence to two stages
Date: Fri,  6 Feb 2015 17:45:51 +0200
Message-Id: <1423237552-23080-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Changes:
	* PATCHv1: split initialization to two stages and check supported commands.
	* RFC: init version

Andrei Emeltchenko (1):
  Bluetooth: Check supported commands before run

 net/bluetooth/hci_core.c | 56 ++++++++++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 21 deletions(-)

-- 
2.1.0

