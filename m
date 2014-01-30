Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 00/15] android/client: Add audio support
Date: Thu, 30 Jan 2014 12:23:06 +0100
Message-Id: <1391081001-30723-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set adds audio support for haltest tool. It provides basic audio HAL
functionality and adds ability to play PCM audio files.

I've also added sound generator when no file path is provided for "play"
command. We can leave that be or push sample audio file to the tree, and/or
hardcode the path. I think that leaving audio file selection to the user and
providing fallback to sound generator is the right solution. Please let me know
what is yours preference.

Regards.

Jakub Tyszkowski (15):
  android/client-av: Fix checking for a2dp interface
  android/client-audio: Add open/close output stream
  android/client-audio: Add audio file playback
  android/client-audio: Add playback suspend/resume
  android/client-audio: Add get_latency for output
  android/client-audio: Add get_buffer_size for output
  android/client-audio: Add get_channels
  android/client-audio: Add getting audio format
  android/client-audio: Add getting sample rate
  android/client-audio: Add get_parameters for output
  android/client-audio: Add set_parameters
  android/client-audio: Add setting sample rate
  android/client-audio: Add init_check
  android/client-audio: Add sine generator as fallback
  android/client-audio: Fix getting audio module on Android

 android/Makefile.am       |   2 +-
 android/client/if-audio.c | 477 +++++++++++++++++++++++++++++++++++++++++++++-
 android/client/if-av.c    |   4 +-
 3 files changed, 479 insertions(+), 4 deletions(-)

--
1.8.5.2

