Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 0/7] Add basic socket tests
Date: Thu, 12 Dec 2013 14:48:27 +0200
Message-Id: <1386852514-17270-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Initial socket test cases

Andrei Emeltchenko (7):
  android/tester: Rename controller_setup to test_dummy
  android/tester: Make generic_data structure const void pointer
  android/tester: Add basic Socket Init test
  android/tester: Add Socket data to generic test data struct
  android/tester: Add Socket listen() invalid sock type
  android/hal-sock: Fix returning unsupported instead of invalid
  android/tester: Add Socket listen() invalid L2CAP socket type

 android/android-tester.c | 114 +++++++++++++++++++++++++++++++++++++++++------
 android/hal-sock.c       |   2 +-
 2 files changed, 102 insertions(+), 14 deletions(-)

-- 
1.8.3.2

