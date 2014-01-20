Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 0/9] android: Add SBC encoding
Date: Mon, 20 Jan 2014 15:58:54 +0100
Message-ID: <1390229943-29609-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

v1 -> v2
- fixed comments
- added dependency to libsbc shared library on Android

Note that configure.ac requires SBC 1.2 which does not exist at the
moment, but I added this since now sbc_init_a2dp() is used which
does not exist in SBC 1.1 and requires patches from Luiz to be
merged so I expect that we'll have SBC 1,2 once this is done (if
accepted, of course).


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

 android/Android.mk  |   7 +-
 android/Makefile.am |   2 +
 android/a2dp.c      |   8 +-
 android/audio-msg.h |   1 +
 android/hal-audio.c | 270 +++++++++++++++++++++++++++++++++++++++++++++++++---
 configure.ac        |   7 ++
 6 files changed, 278 insertions(+), 17 deletions(-)

-- 
1.8.5.2

