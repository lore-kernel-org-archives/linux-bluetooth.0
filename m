Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 00/47] BlueZ support for Android 5.0 Lollipop
Date: Tue,  4 Nov 2014 10:18:23 +0200
Message-Id: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

First version of BlueZ compatible with Android 5.0 Lollipop.

Build against https://android.googlesource.com/platform/hardware/libhardware
branch lollipop-release

Andrei Emeltchenko (47):
  android: Set exact Android version
  android/hal-bluetooth: Add parameter to create_bond
  android/hal-bluetooth: Add missing functions
  android/hal-audio: Add support for new Android API
  android/hal-audio: Implement dummy Audio HAL functions
  android/hal-sco: Add support for new Android API
  android/hal-sco: Remove deprecated API usage
  android/hal-sco: Implement dummy SCO HAL functions
  android/hal-sco: Save bd_addr for output stream of Audio SCO HAL
  android/hal-sco: Save bd_addr for input stream of Audio SCO HAL
  android/hal-sco: Add remote address parameter in Get SCO fd command
  android/hal-sco: Use bdaddr parameter in Get SCO fd command
  android/gatt: Add support for new API
  android/gatt: Add support for new parameter for connect
  android/gatt: Add support for new parameter in srv connect()
  android/client: Support new API for Audio HAL
  android/client: Support new API for SCO HAL
  android/client: Add new API argument for scan()
  android/client: Add support for new Android API for PAN HAL
  android/client: Add support for new GATT HAL API
  android/client: Add new API support for handsfree client
  android/handsfree: Add support for new API for handsfree init
  android/handsfree: Add support for new API for start_vr
  android/handsfree: Add support for new API for stop_vr
  android/handsfree: Add support for new API for volume_control
  android/handsfree: Add support for new API for cops_response
  android/handsfree: Add support for new API for cind_response
  android/handsfree: Add support for new API for formatted_at_response
  android/handsfree: Add support for new API for at_response
  android/handsfree: Add support for new API for clcc_response
  android/handsfree: Add support for new API for vr_cmd_cb
  android/handsfree: Add support for new API for handle_answer
  android/handsfree: Add support for new API for hangup_call_cmd_cb
  android/handsfree: Add support for new API for volume_cmd_cb
  android/handsfree: Add support for new API for dial_call_cmd_cb
  android/handsfree: Add support for new API for handle_dtmf
  android/handsfree: Add support for new API for nrec_cmd_cb
  android/handsfree: Add support for new API for chld_cmd_cb
  android/handsfree: Add support for new API for cnum_cmd_cb
  android/handsfree: Add support for new API for cind_cmd_cb
  android/handsfree: Add support for new API for cops_cmd_cb
  android/handsfree: Add support for new API for clcc_cmd_cb
  android/handsfree: Add support for new API for unknown_at_cmd_cb
  android/handsfree: Add support for new API for key_pressed_cmd_cb
  android/handsfree: Use bdaddr provided for find_device()
  android/handsfree: Return default device for zero bdaddr
  android/build: Disable declaration-after-statement warnings

 android/Android.mk        |   7 +-
 android/Makefile.am       |   2 +-
 android/client/if-audio.c |  11 +++
 android/client/if-bt.c    |  12 +++
 android/client/if-gatt.c  |  32 +++++++
 android/client/if-hf.c    | 209 ++++++++++++++++++++++++++++++++++++++++++-
 android/client/if-pan.c   |   5 ++
 android/client/if-sco.c   |  19 ++++
 android/gatt.c            |  18 ++--
 android/hal-audio.c       |  75 +++++++++++++++-
 android/hal-bluetooth.c   |  47 ++++++++++
 android/hal-gatt.c        |  24 +++++
 android/hal-handsfree.c   | 223 ++++++++++++++++++++++++++++++++++++++++++++--
 android/hal-ipc-api.txt   |  37 +++++---
 android/hal-msg.h         |  48 ++++++++++
 android/hal-sco.c         | 131 +++++++++++++++++++++++++--
 android/handsfree.c       | 110 +++++++++++++++++++----
 android/handsfree.h       |   3 +-
 android/main.c            |   3 +-
 android/sco-ipc-api.txt   |   2 +-
 android/sco-msg.h         |   4 +
 21 files changed, 961 insertions(+), 61 deletions(-)

-- 
1.9.1

