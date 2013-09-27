Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 00/16] Basic code for Android BlueZ
Date: Fri, 27 Sep 2013 17:12:25 +0300
Message-Id: <1380291161-10232-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Skeletons for Android Bluetooth and Socket HALs and BlueZ daemon.

Andrei Emeltchenko (16):
  android: Add Adapter Bluetooth HAL template
  android: Add Socket Bluetooth HAL template
  android: Enable Socket interface
  android: Start Android Bluetooth daemon
  android: Add Android Makefile for mgmt library
  android: Add basic mgmt initialization sequence
  android: Create HAL API header skeleton
  android: Add Android HAL callback task
  android: Add adapter and device struct for BlueZ daemon
  android: Add Android Makefile for libbluetooth
  android: sdp: Reuse BlueZ SDP server in Android
  android: Add cap to bind to port < 1024
  android: Implement read_info_complete callback
  android: Handle mgmt changed events
  android: Implement basic HAL server
  android: Add HAL message helpers

 Makefile.android         |   10 +-
 android/Android.mk       |  124 +++++++++++
 android/bt_adapter.c     |  132 ++++++++++++
 android/bt_adapter.h     |   68 +++++++
 android/hal.h            |   18 ++
 android/hal_bluetooth.c  |  412 +++++++++++++++++++++++++++++++++++++
 android/hal_bt_sock.c    |   84 ++++++++
 android/hal_cb_thread.c  |  144 +++++++++++++
 android/hal_msg.c        |  241 ++++++++++++++++++++++
 android/hal_msg.h        |  263 ++++++++++++++++++++++++
 android/hal_msg_client.c |  112 ++++++++++
 android/hal_msg_client.h |   25 +++
 android/main.c           |  508 ++++++++++++++++++++++++++++++++++++++++++++++
 android/main.h           |   25 +++
 configure.ac             |    4 +
 15 files changed, 2168 insertions(+), 2 deletions(-)
 create mode 100644 android/bt_adapter.c
 create mode 100644 android/bt_adapter.h
 create mode 100644 android/hal.h
 create mode 100644 android/hal_bluetooth.c
 create mode 100644 android/hal_bt_sock.c
 create mode 100644 android/hal_cb_thread.c
 create mode 100644 android/hal_msg.c
 create mode 100644 android/hal_msg.h
 create mode 100644 android/hal_msg_client.c
 create mode 100644 android/hal_msg_client.h
 create mode 100644 android/main.h

-- 
1.7.10.4

