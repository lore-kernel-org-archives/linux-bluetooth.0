Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 0/3] Use BT policy option in l2test
Date: Fri, 24 Feb 2012 10:44:22 +0200
Message-Id: <1330073065-8188-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Adds support for policy socket option for l2test. Will be used
for some PTS tests.

Changes:
	* PATCHv2: Fixed checkpatch warnings, added help.

Andrei Emeltchenko (3):
  bluez: Copy L2CAP chan policy defines from kernel
  l2test: Clean up lookup table code
  l2test: Add BT Channel Policy option

 lib/bluetooth.h |   27 ++++++++++++++++++++
 test/l2test.c   |   72 ++++++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 83 insertions(+), 16 deletions(-)

-- 
1.7.9

