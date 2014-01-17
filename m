Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 0/9] android: Add SBC encoding
Date: Fri, 17 Jan 2014 16:40:04 +0100
Message-ID: <1389973213-30251-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This series of patches adds SBC encoding to Audio HAL.

There are 2 issues which I'm aware of, but at the moment I can't tell
whether it's something in code or it's because of incomplete A2DP HAL
implementation:
- when streaming and trying to change ringtone (on Nexus 4), ringtone
  sound playback using built-in speaker is choppy
- after disconnecting some A2DP devices AudioFliger crashes (seems like
  problem I worked around before with buffer size, yet I still have no
  idea why this happens)

It's possible that after proper A2DP audio state notification is done,
both issues will be "solved", but this still needs to be tested.



Andrzej Kaczmarek (9):
  android: Add MTU data to Open Stream Audio IPC
  android: Build Audio HAL with SBC
  android/hal-audio: Rename sbc_init to avoid collision with libsbc
  android/hal-audio: Initialize SBC encoder
  android/hal-audio: Calculate SBC stream parameters
  android/hal-audio: Add resume to codec callbacks
  android/hal-audio: Return proper buffer size to AudioFlinger
  android/hal-audio: Read fd from Output Stream response
  android/hal-audio: Add proper SBC encoding

 android/Android.mk  |  14 ++-
 android/Makefile.am |   2 +
 android/a2dp.c      |   8 +-
 android/audio-msg.h |   1 +
 android/hal-audio.c | 263 +++++++++++++++++++++++++++++++++++++++++++++++++---
 android/rtp.h       |  76 +++++++++++++++
 configure.ac        |   7 ++
 7 files changed, 353 insertions(+), 18 deletions(-)
 create mode 100644 android/rtp.h

-- 
1.8.5.2

