Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 0/8] Add PAN test cases
Date: Tue,  5 Aug 2014 14:19:06 +0300
Message-Id: <1407237554-5079-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v2: Fixed comments.

Ravi kumar Veeramally (8):
  android/tester: Add PAN init test case
  android/tester: Add PAN Connect test case
  android/tester: Add PAN Disconnect test case
  android/tester: Add PAN Get Local Role test case
  android/pan: Notify control state callback on HAL .enable call
  android/tester: Add PAN Enable NAP test case
  android/tester: Add PAN Enable PANU test case
  android/tester: Add PAN Enable None test case

 android/Makefile.am   |   1 +
 android/pan.c         |  21 +++--
 android/tester-main.c | 109 +++++++++++++++++++++
 android/tester-main.h |  29 ++++++
 android/tester-pan.c  | 256 ++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 409 insertions(+), 7 deletions(-)
 create mode 100644 android/tester-pan.c

-- 
1.9.1

