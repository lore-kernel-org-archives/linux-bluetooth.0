Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 00/32] Android SCO HAL
Date: Fri,  4 Jul 2014 16:46:45 +0300
Message-Id: <1404481637-900-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Implementation for Android SCO HAL, second iteration of patches.

Andrei Emeltchenko (32):
  android/ipc: Add ipc_is_connected() check
  android/handsfree: Connect SCO audio on demand
  android/hal-sco: Use nanosleep for SCO synchronization
  android/hal-sco: Fixes for unreliable mtu
  android/hal-sco: Add SCO packet cache
  android/hal-sco: Make use of config parameter
  android/hal-sco: Implement open input stream
  android/hal-sco: Check file descriptor >= 0
  android/hal-sco: Use global sco file descriptor
  android/haltest: Add open/close input stream commands
  android/haltest: Add read command.
  android/haltest: Add loop command
  android/hal-sco: Make debug more readable
  android/hal-sco: Fix memory leak
  android/hal-sco: Implement read
  android/haltest: Implement read to file
  android/hal-sco: Connect SCO when opening input stream
  android/haltest: Add sample rate parameter when opening audio streams
  android/hal-sco: Skip resampling for output stream with 8k
  android/hal-sco: Skip resampling for input of 8k
  android/haltest: Correct check for similar buffer size
  android/haltest: Add mono to stereo conversion for loopback
  android/hal-sco: Choose buffer size
  android/hal-sco: Add stream synchronization
  android/haltest: Refactor stop and closing streams
  android/hal-sco: Connect SCO audio on demand
  android/hal-sco: Disconnect SCO audio on standby()
  android/handsfree: Refactor SCO audio connect sequence
  android/hal-sco: Fix incorrect assignment
  android/hal-audio: Fix leaving open socket
  android/hal-sco: Fix leaving open socket
  android/hal-sco: Fix error code printing

 android/Android.mk      |   3 +
 android/client/if-sco.c | 291 ++++++++++++++++++++++-
 android/hal-audio.c     |  12 +-
 android/hal-sco.c       | 610 ++++++++++++++++++++++++++++++++++++++++++------
 android/handsfree.c     |  38 ++-
 android/ipc.c           |   5 +
 android/ipc.h           |   1 +
 7 files changed, 863 insertions(+), 97 deletions(-)

-- 
1.9.1

