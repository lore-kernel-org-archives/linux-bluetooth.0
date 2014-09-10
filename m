Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 00/16] android: HF Client initial implementation part 1
Date: Wed, 10 Sep 2014 13:33:58 +0200
Message-Id: <1410348854-26249-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Following patches adds HF Client commands skeleton

v2:
* Szymon comment from IRC handled
* Splited patch set to smaller sets on Luiz request.

Lukasz Rymanowski (16):
  android/hf-client: Add hf-client ID
  android/hardware: Add HFP Client Interface ID.
  android/hf-client: Add hf-client daemon skeleton
  android/hf-client: Add hf-client HAL skeleton
  android/hf-client: Add hf-client to Android build
  android/readme: Add information about hf-client
  android/hf-client: Add Connect/Disconnect commands
  android/hf-client: Add Audio Connect/Disconnect commands
  android/hf-client: Add Start/Stop Voice Recognition command
  android/hf-client: Add Volume Control command
  android/hf-client: Add Dial and Dial Memory command
  android/hf-client: Add Call Action command
  android/hf-client: Add Query Current Call and Operator Name command
  android/hf-client: Add Retrieve Subscriber Info command
  android/hf-client: Add Send DTMF command
  android/hf-client: Add Get Last Voice Tag Number command

 android/Android.mk           |   4 +
 android/Makefile.am          |   3 +
 android/README               |  10 ++
 android/hal-bluetooth.c      |   3 +
 android/hal-hf-client.c      | 353 +++++++++++++++++++++++++++++++++++++++++++
 android/hal-msg.h            |  78 +++++++++-
 android/hal.h                |   2 +
 android/hardware/bluetooth.h |   1 +
 android/hf-client.c          | 222 +++++++++++++++++++++++++++
 android/hf-client.h          |  25 +++
 android/main.c               |   9 ++
 11 files changed, 709 insertions(+), 1 deletion(-)
 create mode 100644 android/hal-hf-client.c
 create mode 100644 android/hf-client.c
 create mode 100644 android/hf-client.h

-- 
1.8.4

