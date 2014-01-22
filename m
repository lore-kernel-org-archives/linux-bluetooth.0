Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v3 00/10] android: Add SBC encoding
Date: Wed, 22 Jan 2014 11:34:43 +0100
Message-ID: <1390386893-8212-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

v1 -> v2
- fixed comments
- added dependency to libsbc shared library on Android

v2 -> v3
- added comment explaining why we need to sleep in out_write
- updated to new SBC API
- libsbc shared library is now built from our Android.mk
- implemented proper get_latency callback



Andrzej Kaczmarek (10):
  android: Add MTU data to Open Stream Audio IPC
  android: Build Audio HAL with SBC
  android/hal-audio: Rename sbc_init to avoid collision with libsbc
  android/hal-audio: Initialize SBC encoder
  android/hal-audio: Calculate SBC stream parameters
  android/hal-audio: Add resume to codec callbacks
  android/hal-audio: Return proper buffer size to AudioFlinger
  android/hal-audio: Read fd from Output Stream response
  android/hal-audio: Add proper SBC encoding
  android/hal-audio: Return proper latency for stream

 android/Android.mk  |  37 ++++++-
 android/Makefile.am |   2 +
 android/a2dp.c      |   8 +-
 android/audio-msg.h |   1 +
 android/hal-audio.c | 301 +++++++++++++++++++++++++++++++++++++++++++++++++---
 configure.ac        |   7 ++
 6 files changed, 338 insertions(+), 18 deletions(-)

-- 
1.8.5.2

