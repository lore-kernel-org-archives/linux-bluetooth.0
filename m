Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 00/10] android: Audio HAL implementation
Date: Wed, 15 Jan 2014 10:59:47 +0100
Message-ID: <1389779996-9749-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here are patches which implement Audio HAL. Complete IPC signalling is
implemented with stubs to add SBC codec in next step.

Note that in order to make these patches work correctly BlueZ needs to
notify A2DP connected state after streaming channel is connected - at
the moment it does so just after singalling is connected which will
result in an error when Audio HAL tries to open stream.


Andrzej Kaczmarek (9):
  android/hal-audio: Add support to register audio endpoints
  android/hal-audio: Add support to unregister audio endpoints
  android/hal-audio: Add support to open output stream
  android/hal-audio: Add support to close output stream
  android/hal-audio: Add support to resume output stream
  android/hal-audio: Add support to suspend output stream
  android/hal-audio: Handle audio preset from stream
  android/hal-audio: Fix module loading
  android/hal-audio: Fix AudioFlinger crash

Lukasz Rymanowski (1):
  android/hal-audio: Add audio_ipc_cmd

 android/Makefile.am |   1 +
 android/hal-audio.c | 699 +++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 667 insertions(+), 33 deletions(-)

-- 
1.8.5.2

