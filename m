Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 00/15] Basic code for Android BlueZ
Date: Mon,  7 Oct 2013 10:38:01 +0300
Message-Id: <1381131496-9417-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Skeletons for Android Bluetooth and Socket HALs and BlueZ daemon.

Note: Still need rebase after patches from Frederic are applied.

Changes:
	* PATCHv1: Rebased against applied fdanis patch set, moved SDP init from
	adapter start to daemon start, other minor fixes.
	* RFCv3: Rebased against recent FDanis patch set, fixed library build,
	corrected process capabilities, corrected API header.
	* RFCv2: Took comments from mailing list reviewers. Use single
	makefile, remove mgmt library and directly link, remove adapter
	code and use default_adapter pointer and other style changes.
	Dropped some patches due to major changes.

Andrei Emeltchenko (15):
  android: Supress missing initializers warnings
  android: Add Adapter Bluetooth HAL template
  android: Add Socket Bluetooth HAL template
  android: Enable Socket interface
  android: Start Android Bluetooth daemon
  android: Add basic mgmt initialization sequence
  android: Create HAL API header skeleton
  android: Add adapter and device struct for BlueZ daemon
  android: Add Android Makefile for libbluetooth
  android: sdp: Reuse BlueZ SDP server in Android
  android: Add cap to bind to port < 1024
  android: Implement read_info_complete callback
  android: Handle mgmt changed events
  android: Add makefile for hciconfig
  android: Add makefile for hcitool

 Makefile.android        |    9 +-
 android/Android.mk      |  166 +++++++++++++++
 android/bt_adapter.c    |   54 +++++
 android/bt_adapter.h    |   60 ++++++
 android/hal.h           |   18 ++
 android/hal_bluetooth.c |  411 +++++++++++++++++++++++++++++++++++++
 android/hal_bt_sock.c   |   84 ++++++++
 android/hal_msg.h       |  255 +++++++++++++++++++++++
 android/main.c          |  521 +++++++++++++++++++++++++++++++++++++++++++++++
 configure.ac            |    4 +
 10 files changed, 1580 insertions(+), 2 deletions(-)
 create mode 100644 android/bt_adapter.c
 create mode 100644 android/bt_adapter.h
 create mode 100644 android/hal.h
 create mode 100644 android/hal_bluetooth.c
 create mode 100644 android/hal_bt_sock.c
 create mode 100644 android/hal_msg.h

-- 
1.7.10.4

