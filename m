Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/6] android: initial code for automated tests
Date: Thu, 28 Nov 2013 10:42:44 +0100
Message-Id: <1385631770-3858-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

V2:
 - change-id removed
 - bogus patch removed from serie

from V1:

This serie adds initial code for automated android deamon and HAL library
tests. Skeleton and one initial test case is added.

-- 
Best regards,
Grzegorz

Grzegorz Kolodziejczyk (1):
  android: Add basic test and handle mgmt notifications, hal cb

Marcin Kraglak (4):
  android: Add android-tester
  android: Add pre-setup and post-teardown routines
  android: Start emulator in separate thread
  android: Add stack initialization of stack in setup

Szymon Janc (1):
  android: Make HAL logging wrapper print to stderr instead of stdout

 android/Makefile.am      |  18 ++
 android/android-tester.c | 592 +++++++++++++++++++++++++++++++++++++++++++++++
 android/hal-log.h        |   2 +-
 3 files changed, 611 insertions(+), 1 deletion(-)
 create mode 100644 android/android-tester.c

-- 
1.8.4.2

