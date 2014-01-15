Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 00/11] Audio HAL implementation
Date: Wed, 15 Jan 2014 19:03:46 +0100
Message-ID: <1389809037-11575-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

changes v1 -> v2
- fixed comments from Luiz
- removed "codec_" prefix from function related to SBC codec
- additional patch to implement set_parameters for audio device
  (A2dpSuspend is initialized this way)
- changes dummy buffer size to 20*512 which is inline with Bluedroid
  (AudioFlinger does crash when closing output stream when set to 512)


Andrzej Kaczmarek (10):
  android/hal-audio: Add support to register audio endpoints
  android/hal-audio: Add support to unregister audio endpoints
  android/hal-audio: Add support to open output stream
  android/hal-audio: Add support to close output stream
  android/hal-audio: Add support to resume output stream
  android/hal-audio: Add support to suspend output stream
  android/hal-audio: Handle audio preset from stream
  android/hal-audio: Fix module loading
  android/hal-audio: Fix AudioFlinger crash
  android/hal-audio: Implement set_parameters for device

Lukasz Rymanowski (1):
  android/hal-audio: Add audio_ipc_cmd

 android/Makefile.am |   1 +
 android/hal-audio.c | 729 +++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 696 insertions(+), 34 deletions(-)

-- 
1.8.5.2

