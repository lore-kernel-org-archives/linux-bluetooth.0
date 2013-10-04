Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv6 0/5] Initial skeleton
Date: Fri,  4 Oct 2013 14:48:42 +0300
Message-Id: <1380887327-6652-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Those are modified patches from Frederic Danis.

Changes:
	* v6: removed -n option, print to stdout & stderr depending on type of logs.
	* v5: log is now printed to stderr

Frederic Danis (5):
  build: Add skeleton for BlueZ Android
  android: Add skeleton of BlueZ Android daemon
  android-build: Add BlueZ Android daemon
  build: Add BlueZ Android daemon
  android: Android version of log.c

 .gitignore          |    2 +
 Makefile.am         |    4 +-
 Makefile.android    |    8 ++++
 android/Android.mk  |   31 ++++++++++++++
 android/log.c       |   82 +++++++++++++++++++++++++++++++++++++
 android/main.c      |  112 +++++++++++++++++++++++++++++++++++++++++++++++++++
 bootstrap-configure |    1 +
 configure.ac        |    5 +++
 8 files changed, 244 insertions(+), 1 deletion(-)
 create mode 100644 Makefile.android
 create mode 100644 android/Android.mk
 create mode 100644 android/log.c
 create mode 100644 android/main.c

-- 
1.7.10.4

