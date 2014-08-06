Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 0/3] Initial HDP E2E test cases
Date: Wed,  6 Aug 2014 16:41:47 +0300
Message-Id: <1407332510-3831-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Patchset contains HDP initial (app register and unregister) test cases.

Ravi kumar Veeramally (3):
  android/tester: Add HDP init test case
  android/tester: Add HDP App Register test cases
  android/tester: Add HDP App Unregister test case

 android/Makefile.am   |   1 +
 android/tester-hdp.c  | 225 ++++++++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.c | 111 +++++++++++++++++++++++++
 android/tester-main.h |  29 +++++++
 4 files changed, 366 insertions(+)
 create mode 100644 android/tester-hdp.c

-- 
1.9.1

