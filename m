Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 00/12] SCO Audio interface for Android
Date: Thu,  8 May 2014 11:01:31 +0300
Message-Id: <1399536103-19052-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Changes:
	* v3: Refactored code following comments, renamed API commands
	to connect_sco instead of get_sco_fd. Better code split.

Andrei Emeltchenko (12):
  android/hal-sco: Add audio HAL for SCO handling
  android/hal-audio-hsp: Add open_output_stream()
  android/audio: Add Audio SCO message API
  android/handsfree: Add SCO Audio IPC
  android/hal-sco: Implement Audio IPC on Audio HAL
  android/ipc: Use error printing error messages
  android/haltest: Add testinng for audio SCO HAL
  android/audio: Add resampler support
  audio/haltest: Make audio_stream static
  android/audio: Add downmix support to audio SCO HAL
  android/audio: Use resampler interface to resample SCO
  android/audio: Add write to SCO

 android/Android.mk                            |  26 +
 android/Makefile.am                           |  20 +
 android/audio_utils/resampler.c               | 265 ++++++++
 android/audio_utils/resampler.h               | 109 +++
 android/client/haltest.c                      |   3 +
 android/client/{if-audio.c => if-audio-sco.c} |  60 +-
 android/client/if-audio.c                     |   2 +-
 android/client/if-main.h                      |   1 +
 android/hal-sco.c                             | 912 ++++++++++++++++++++++++++
 android/handsfree.c                           |  58 +-
 android/ipc.c                                 |  12 +-
 android/sco-ipc-api.txt                       |  36 +
 android/sco-msg.h                             |  36 +
 configure.ac                                  |   7 +
 14 files changed, 1510 insertions(+), 37 deletions(-)
 create mode 100644 android/audio_utils/resampler.c
 create mode 100644 android/audio_utils/resampler.h
 copy android/client/{if-audio.c => if-audio-sco.c} (90%)
 create mode 100644 android/hal-sco.c
 create mode 100644 android/sco-ipc-api.txt
 create mode 100644 android/sco-msg.h

-- 
1.8.3.2

