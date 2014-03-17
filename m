Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 0/7] Add PAN E2E client role test cases
Date: Mon, 17 Mar 2014 16:00:04 +0200
Message-Id: <1395064811-5469-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v2: Solved rebase conflicts.

v1: Patch set contains PAN E2E client role test cases.

Ravi kumar Veeramally (7):
  android/tester: Add PAN init test case
  android/tester: Add PAN Connect test case
  android/tester: Add PAN Disconnect test case
  android/tester: Add PAN get local role test cases
  android/tester: Add PAN enable PANU test case
  android/tester: Add PAN enable NAP test case
  android/tester: Add PAN enable NONE test case

 android/android-tester.c | 671 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 671 insertions(+)

-- 
1.8.3.2

