Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 00/11] Android BlueZ patches, second chunk
Date: Wed, 16 Oct 2013 17:08:37 +0300
Message-Id: <1381932528-31584-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1381833423-862-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1381833423-862-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This is second chunk from my initial big patch set. Fixed style issues commented
by Marcel.

Changes:
	* v3: Following upstream comments file names are changed from "_" to "-", added kernel style
	struct initialization, fixed bug checking status for mgmt commands, added 2 HALs skeletons.
	* v2: Corrected android_daemon -> enable_android autoconf stuff, better name for acquiring caps,
	renamed hal_msg.h to hal-msg.h due to Johan's comment. Added small test-sdp fix.

Note that due to Marcel comment this cannot be built unless you include my patch
for Android bionic library:
http://code.google.com/p/android-bluez/source/detail?r=77a07e7703b63e280d9880baad30b3375e7df079&repo=bionic#

Andrei Emeltchenko (11):
  android: Create HAL API header skeleton
  android: Add basic mgmt initialization sequence
  android: Add adapter and device struct for BlueZ daemon
  android: sdp: Reuse BlueZ SDP server in Android
  android: Add cap to bind to port < 1024
  android: Implement read_info_complete callback
  android: Use kernel style to initialize struct fields
  android: Rename hal_bluetooth.c to hal-bluetooth.c
  android: Rename hal_bt_sock.c to hal-bt-sock.c
  android: Add HID Host skeleton
  android: Add PAN skeleton

 Makefile.android        |   12 +-
 android/Android.mk      |   20 ++-
 android/adapter.c       |  138 +++++++++++++++++
 android/adapter.h       |   40 +++++
 android/device.c        |   25 +++
 android/device.h        |   24 +++
 android/hal-bluetooth.c |  392 +++++++++++++++++++++++++++++++++++++++++++++++
 android/hal-bt-sock.c   |   85 ++++++++++
 android/hal-hidhost.c   |  204 ++++++++++++++++++++++++
 android/hal-msg.h       |  246 +++++++++++++++++++++++++++++
 android/hal-pan.c       |  120 +++++++++++++++
 android/hal.h           |    2 +
 android/hal_bluetooth.c |  384 ----------------------------------------------
 android/hal_bt_sock.c   |   85 ----------
 android/main.c          |  248 ++++++++++++++++++++++++++++++
 configure.ac            |    4 +
 16 files changed, 1556 insertions(+), 473 deletions(-)
 create mode 100644 android/adapter.c
 create mode 100644 android/adapter.h
 create mode 100644 android/device.c
 create mode 100644 android/device.h
 create mode 100644 android/hal-bluetooth.c
 create mode 100644 android/hal-bt-sock.c
 create mode 100644 android/hal-hidhost.c
 create mode 100644 android/hal-msg.h
 create mode 100644 android/hal-pan.c
 delete mode 100644 android/hal_bluetooth.c
 delete mode 100644 android/hal_bt_sock.c

-- 
1.7.10.4

