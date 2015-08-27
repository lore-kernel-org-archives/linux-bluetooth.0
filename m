Return-Path: <cyrus@holtmann.org>
From: Will Wang <wiwang@mozilla.com>
To: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org, Will Wang <wiwang@mozilla.com>
Subject: [PATCH 0/3] Fix missing HFP WBS callback
Date: Thu, 27 Aug 2015 20:01:59 +0800
Message-Id: <1440676922-29249-1-git-send-email-wiwang@mozilla.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This set of patches:
- adds HFP Wideband speech(WBS) callback function for Android.
- adds a new opcode 0x91 for WBS Command notification.

The patches has been tested on Nexus 5 with Android 5.0.1 Lollipop,
and passed the PTS test "TC_AG_ACC_BI_12_I", the Android framework
outputs log such as:

08-20 18:29:39.932 E/BluetoothHeadsetServiceJni( 1442): mozzz: wbs_callback
...
08-20 18:29:39.933 D/HeadsetStateMachine( 1442): EVENT_TYPE_WBS codec is 1
08-20 18:29:39.935 D/HeadsetStateMachine( 1442): AudioManager.setParameters bt_wbs=off for PTS-HFP-MOZILLA-TPE-PC - 00:1B:DC:07:2F:9A
08-20 18:29:39.936 D/audio_hw_primary(  215): adev_set_parameters: enter: bt_wbs=off

Thanks Szymon Janc(:sjanc)'s speedy reply of the patch process questions
on IRC, and Shawn Huang(:shawnjohnjr)'s technical support.


Will Wang (3):
  android/hal-ipc-api: Fix missing HFP WBS callback
  android/hal-handsfree: Fix missing HFP WBS callback
  android/handsfree: Fix missing HFP WBS callback

 android/hal-handsfree.c | 12 ++++++++++++
 android/hal-ipc-api.txt |  8 ++++++++
 android/hal-msg.h       |  6 ++++++
 android/handsfree.c     |  8 ++++++++
 4 files changed, 34 insertions(+)

-- 
1.9.1

