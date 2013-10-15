Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 0/5] Initial Android BlueZ patches
Date: Tue, 15 Oct 2013 13:36:58 +0300
Message-Id: <1381833423-862-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This is second chunk from my initial big patch set. Fixed style issues commented
by Marcel.

Note that due to Marcel comment this cannot be built unless you include my patch
for Android bionic library:
http://code.google.com/p/android-bluez/source/detail?r=77a07e7703b63e280d9880baad30b3375e7df079&repo=bionic#

Andrei Emeltchenko (5):
  android: Create HAL API header skeleton
  android: Add basic mgmt initialization sequence
  android: Add adapter and device struct for BlueZ daemon
  android: sdp: Reuse BlueZ SDP server in Android
  android: Add cap to bind to port < 1024

 Makefile.android   |    8 +-
 android/Android.mk |   13 +++
 android/adapter.c  |   63 ++++++++++++++
 android/adapter.h  |   36 ++++++++
 android/device.c   |   29 +++++++
 android/device.h   |   24 +++++
 android/hal_msg.h  |  246 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 android/main.c     |  244 +++++++++++++++++++++++++++++++++++++++++++++++++++
 configure.ac       |    4 +
 9 files changed, 665 insertions(+), 2 deletions(-)
 create mode 100644 android/adapter.c
 create mode 100644 android/adapter.h
 create mode 100644 android/device.c
 create mode 100644 android/device.h
 create mode 100644 android/hal_msg.h

-- 
1.7.10.4

