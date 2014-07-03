Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 00/19] Android/tester-ng: New android tester
Date: Thu,  3 Jul 2014 18:00:03 +0200
Message-Id: <1404403222-26911-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Based on past experience with android-tester, new android tester is
written from scrath with fixed all known bugs and framework
inadvertancies.

Each HAL will have it's own file named tester-"hal" which will
contain test cases and test steps macros (multiple usage of repeating
test steps in test cases). Main tester (framework) will gather all
test cases from tester-"hal" and run it.

Once new test case will be added, same one from old android tester
will be removed, until whole test case list will be replaced.

Grzegorz Kolodziejczyk (17):
  shared/tester: Add support for debug logs for tester
  android/tester-ng: Add android-tester-ng
  android/tester-bluetooth: Initial bluetooth HAL tester
  android/tester-bluetooth: Add initial test case
  android/tester-bluetooth: Add enable success test case
  android/tester-ng: Add double enable success test case
  android/tester-socket: Initial socket tester
  android/tester-socket: Add initial test case
  android/tester-hidhost: Initial hidhost tester
  android/tester-hidhost: Add initial test case
  android/tester-gatt: Add initial test case
  android/tester-ng: Add property check handling
  android/tester-bluetooth: Add disable success test case
  android/tester-bluetooth: Add bdname set success tc
  Android/tester-bluetooth: Add scan_mode set success tc
  Android/tester-bluetooth: Add disc_timeout set success tc
  android/android-tester: Remove test cases replaced by tester-ng

Jakub Tyszkowski (2):
  android/tester-ng: Add callback mechanism
  android/tester-gatt: Initial gatt tester

 android/Makefile.am        |   28 ++
 android/android-tester.c   |  248 -----------
 android/tester-bluetooth.c |  269 ++++++++++++
 android/tester-gatt.c      |   46 ++
 android/tester-hidhost.c   |   46 ++
 android/tester-main.c      | 1001 ++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.h      |  191 +++++++++
 android/tester-socket.c    |   46 ++
 src/shared/tester.c        |   14 +
 src/shared/tester.h        |    2 +
 10 files changed, 1643 insertions(+), 248 deletions(-)
 create mode 100644 android/tester-bluetooth.c
 create mode 100644 android/tester-gatt.c
 create mode 100644 android/tester-hidhost.c
 create mode 100644 android/tester-main.c
 create mode 100644 android/tester-main.h
 create mode 100644 android/tester-socket.c

-- 
1.9.3

