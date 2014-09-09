Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 00/39] android: HF Client initial implementation
Date: Tue,  9 Sep 2014 21:56:45 +0200
Message-Id: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Following patches adds
* HF client HAL
* HF client daemon skeleton
* ipc structs and defines for commands and events
* small fixes in hal-ipc-api

Lukasz Rymanowski (39):
  android/hal-ipc-api: Use 2 bytes for location in dial memory
  android/hal-ipc-api: Use Tone instead of Code DTMF
  android/hal-ipc-api: Add missing peer features parameter
  android/avrcp: Clean up command order
  android/hf-client: Add hf-client ID
  android/hf-client: Add hf-client daemon skeleton
  android/hf-client: Add skeleton for HAL hf-client
  android/hf-client: Add Connect/Disconnect commands
  android/hf-client: Add Audio Connect/Disconnect commands
  android/hf-client: Add Start/Stop Voice Recognition command
  android/hf-client: Add Volume Control command
  android/hf-client: Add Dial and Dial Memory command
  android/hf-client: Add Command Action command
  android/hf-client: Add Query Current Call and Operator Name command
  android/hf-client: Add Retrieve Subscriber Info command
  android/hf-client: Add Send DTMF command
  android/hf-client: Add Get Last Voice Tag Number command
  android/hf-client: Add Connection State event
  android/hf-client: Add Audio Connection State event
  android/hf-client: Add Voice Recognition State event
  android/hf-client: Add Network State event
  android/hf-client: Add Network Roaming State event
  android/hf-client: Add Network Signal Strenght event
  android/hf-client: Add Battery Level event
  android/hf-client: Add Operator Name event
  android/hf-client: Add Call Indicator event
  android/hf-client: Add Call Setup Indicator event
  android/hf-client: Add Call Held Indicator event
  android/hf-client: Add Response and Hold Status event
  android/hf-client: Add Call Waiting and Calling Line Ident. events
  android/hf-client: Add Current Client Call event
  android/hf-client: Add Volume Changed event
  android/hf-client: Add Command Complete event
  android/hf-client: Add Subscriber Info event
  android/hf-client: Add In Band Ringtone event
  android/hf-client: Add Last Voice Tag Number event
  android/hf-client: Add RING notification event
  android/hf-client: Add hf-client to Android build
  android/readme: Add information about hf-client

 android/Android.mk      |   4 +
 android/Makefile.am     |   3 +
 android/README          |  10 +
 android/hal-hf-client.c | 644 ++++++++++++++++++++++++++++++++++++++++++++++++
 android/hal-ipc-api.txt |   9 +-
 android/hal-msg.h       | 463 ++++++++++++++++++++++++++--------
 android/hal.h           |   2 +
 android/hf-client.c     | 222 +++++++++++++++++
 8 files changed, 1248 insertions(+), 109 deletions(-)
 create mode 100644 android/hal-hf-client.c
 create mode 100644 android/hf-client.c

-- 
1.8.4

