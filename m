Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 00/11] HIDHost E2E tests and fixes
Date: Fri, 17 Jan 2014 01:25:40 +0200
Message-Id: <1389914751-18545-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Patch set contains few fixes which are noticed while writing
tests and success test cases for hidhost.

Ravi kumar Veeramally (11):
  android/hidhost: Fix connection state notification on profile
    unregister
  android/hidhost: Fix miscalculation of get report event struct length
  android/hidhost: Remove unnecessary check
  android/tester: Add HIDhost Connect test
  android/tester: Add HIDhost Disconnect test
  android/tester: Add HIDhost VirtualUnplug test
  android/tester: Add HIDhost GetProtocol test
  android/tester: Add HIDhost SetProtocol test
  android/tester: Add HIDhost GetReport test
  android/tester: Add HIDhost SetReport test
  android/tester: Add HIDhost SendData test

 android/android-tester.c | 517 ++++++++++++++++++++++++++++++++++++++++++++++-
 android/hal-hidhost.c    |   3 +-
 android/hidhost.c        |  14 +-
 3 files changed, 511 insertions(+), 23 deletions(-)

-- 
1.8.3.2

