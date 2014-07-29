Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 0/9] android/tester-ng: Add HIDHost test cases
Date: Tue, 29 Jul 2014 09:18:23 +0200
Message-Id: <1406618312-15059-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds last set of test cases ported to newer tester framework.
Last patch removes the old 'android-tester' and renames 'android-tester-ng'
to 'android-tester'.

v2changes:
	* improved/cleaned up some cases step flow
	* renamed the 'android-tester-ng' to 'android-tester'

Jakub Tyszkowski (9):
  android/tester-ng: Add HIDHost connect, disconnect cases
  android/tester-ng: Add HIDHost virtual unplug test case
  android/tester-ng: Add HIDHost get protocol mode case
  android/tester-ng: Add HIDHost set protocol mode case
  android/tester-ng: Add HIDHost get report case
  android/tester-ng: Add HIDHost set report case
  android/tester-ng: Add HIDHost send data case
  android/tester: Remove old HIDHost test cases
  android/tester: Remove old android-tester

 .gitignore               |    1 -
 android/Makefile.am      |   30 +-
 android/android-tester.c | 2812 ----------------------------------------------
 android/tester-hidhost.c |  533 ++++++++-
 android/tester-main.c    |   80 +-
 android/tester-main.h    |   27 +
 6 files changed, 637 insertions(+), 2846 deletions(-)
 delete mode 100644 android/android-tester.c

--
1.9.1

