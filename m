Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 0/5] android: aptX support
Date: Mon, 2 Jun 2014 13:20:06 +0200
Message-ID: <1401708011-12828-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's v2 for remaining aptX patches. Changes:
- hardcoded list of codecs (aptX won't load if there's no .so)
- .so for aptX is hardcoded to libbt-aptx.so (can be symlinked)


Andrzej Kaczmarek (5):
  android/hal-audio: Always call qos_update
  android/hal-audio: Allow codec to init on startup
  android/hal-audio-aptx: Add initial support for aptX codec
  android/hal-audio-aptx: Load aptX encoder library
  android/hal-audio-aptx: Add encoding

 android/Android.mk       |   2 +
 android/Makefile.am      |   1 +
 android/hal-audio-aptx.c | 282 +++++++++++++++++++++++++++++++++++++++++++++++
 android/hal-audio.c      |  35 +++++-
 android/hal-audio.h      |   5 +
 5 files changed, 320 insertions(+), 5 deletions(-)
 create mode 100644 android/hal-audio-aptx.c

-- 
1.9.3

