Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 0/8] Add PAN test cases
Date: Tue, 29 Jul 2014 15:01:24 +0300
Message-Id: <1406635292-30691-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ravi kumar Veeramally (8):
  android/tester: Fix memory leak
  android/tester-ng: Add PAN init test case
  android/tester-ng: Add PAN Connect test case
  android/tester-ng: Add PAN Disconnect test case
  anrdroid/tester-ng: Add PAN Get Local Role test case
  android/tester-ng: Add PAN Enable PANU test case
  android/tester-ng: Add PAN Enable NAP test case
  android/tester-ng: Add PAN Enable None test case

 android/Makefile.am   |   1 +
 android/tester-main.c |  83 +++++++++++++++++++
 android/tester-main.h |   8 ++
 android/tester-pan.c  | 219 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 311 insertions(+)
 create mode 100644 android/tester-pan.c

-- 
1.9.1

