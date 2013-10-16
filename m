Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 0/6] Android BlueZ patches, second chunk
Date: Wed, 16 Oct 2013 11:46:49 +0300
Message-Id: <1381913215-17957-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1381833423-862-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1381833423-862-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This is second chunk from my initial big patch set. Fixed style issues commented
by Marcel.

Changes:
	* v2: Corrected android_daemon -> enable_android autoconf stuff, better name for acquiring caps,
	renamed hal_msg.h to hal-msg.h due to Johan's comment. Added small test-sdp fix.

Note that due to Marcel comment this cannot be built unless you include my patch
for Android bionic library:
http://code.google.com/p/android-bluez/source/detail?r=77a07e7703b63e280d9880baad30b3375e7df079&repo=bionic#

Andrei Emeltchenko (6):
  sdp: Check that correct packet received in recv
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
 android/hal-msg.h  |  246 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 android/main.c     |  244 +++++++++++++++++++++++++++++++++++++++++++++++++++
 configure.ac       |    4 +
 unit/test-sdp.c    |    5 +-
 10 files changed, 667 insertions(+), 5 deletions(-)
 create mode 100644 android/adapter.c
 create mode 100644 android/adapter.h
 create mode 100644 android/device.c
 create mode 100644 android/device.h
 create mode 100644 android/hal-msg.h

-- 
1.7.10.4

