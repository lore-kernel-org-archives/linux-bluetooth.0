Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 00/15] Update android/hardware headers to 5.0 API
Date: Thu,  6 Nov 2014 17:05:45 +0200
Message-Id: <1415286360-26268-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Replaces headers which allows to build only against the very
latest Android for host.

Andrei Emeltchenko (15):
  android/hardware: Update bt_gatt_client.h header
  android/hardware: Update bt_hf_client.h header
  android/hardware: Update bluetooth.h header from Android 5.0
  android/hardware: Update audio.h HAL header
  android/system: Update system/audio.h header
  android/cutils: Add missing bitops.h header
  android/hardware: Update bt_hf.h header
  android/hardware: Update bt_gatt_server.h header
  android/hardware: Update bt_gatt_types.h header
  android/hardware: Update bt_pan.h header
  android/hardware: Update audio_effect.h header
  android/hardware: Update bt_av.h header
  android/hardware: Update bt_hh.h header
  android/hardware: Update bt_mce.h header
  android/hardware: Update bt_rc.h header

 android/cutils/bitops.h           | 120 ++++++
 android/hardware/audio.h          | 149 ++++++-
 android/hardware/audio_effect.h   |   5 +-
 android/hardware/bluetooth.h      |  82 +++-
 android/hardware/bt_av.h          |  15 +-
 android/hardware/bt_gatt_client.h | 134 +++++-
 android/hardware/bt_gatt_server.h |  19 +-
 android/hardware/bt_gatt_types.h  |   8 +
 android/hardware/bt_hf.h          |  63 ++-
 android/hardware/bt_hf_client.h   |  30 +-
 android/hardware/bt_hh.h          |  10 +-
 android/hardware/bt_mce.h         |   5 +-
 android/hardware/bt_pan.h         |   4 +-
 android/hardware/bt_rc.h          |  34 +-
 android/system/audio.h            | 862 +++++++++++++++++++++++++++++++++++---
 15 files changed, 1414 insertions(+), 126 deletions(-)
 create mode 100644 android/cutils/bitops.h

-- 
1.9.1

