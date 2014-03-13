Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 0/7] Add PAN E2E client role test cases
Date: Thu, 13 Mar 2014 23:50:36 +0200
Message-Id: <1394747443-23220-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Patch set contains PAN E2E client role test cases.

Ravi kumar Veeramally (7):
  android/tester: Add PAN init test case
  android/tester: Add PAN Connect test case
  android/tester: Add PAN Disconnect test case
  android/tester: Add PAN get local role test cases
  android/tester: Add PAN enable PANU test case
  android/tester: Add PAN enable NAP test case
  android/tester: Add PAN enable NONE test case

 android/android-tester.c | 669 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 669 insertions(+)

-- 
1.8.3.2

