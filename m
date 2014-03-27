Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v3 0/7] Add PAN E2E client role test cases
Date: Thu, 27 Mar 2014 12:00:19 +0200
Message-Id: <1395914426-24249-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v3: Solved Szymon's comments.
v2: Solved rebase conflicts.
v1: Patch set contains PAN E2E client role test cases.

Ravi kumar Veeramally (7):
  android/tester: Add PAN init test case
  android/tester: Add PAN Connect test case
  android/tester: Add PAN Disconnect test case
  android/tester: Add PAN get local role test case
  android/tester: Add PAN enable PANU test case
  android/tester: Add PAN enable NAP test case
  android/tester: Add PAN enable NONE test case

 android/android-tester.c | 673 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 673 insertions(+)

-- 
1.8.3.2

