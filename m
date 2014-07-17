Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 00/23] Audio SCO HAL second patch set
Date: Thu, 17 Jul 2014 11:54:00 +0300
Message-Id: <1405587263-19867-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This patch set makes Audio SCO HAL usable

Andrei Emeltchenko (23):
  android/hal-sco: Use nanosleep for SCO synchronization
  android/hal-sco: Fixes for unreliable mtu
  android/hal-sco: Add SCO packet cache
  android/hal-sco: Make use of config parameter
  android/hal-sco: Implement open input stream
  android/hal-sco: Check file descriptor >= 0
  android/hal-sco: Use global sco file descriptor
  android/hal-sco: Make debug more readable
  android/hal-sco: Fix memory leak
  android/hal-sco: Implement read
  android/hal-sco: Skip resampling for output stream with 8k
  android/hal-sco: Skip resampling for input of 8k
  android/hal-sco: Choose buffer size
  android/hal-sco: Add stream synchronization
  android/hal-sco: Connect SCO audio on demand
  android/hal-sco: Defer SCO connection to write()
  android/hal-sco: Fix incorrect assignment
  android/hal-audio: Fix leaving open socket
  android/hal-sco: Fix leaving open socket
  android/hal-sco: Fix error code printing
  android/hal-audio: Remove dead code
  android/hal-sco: Remove unneeded statement
  android/tools: Rearrange headers include

 android/client/if-sco.c |   8 +-
 android/hal-audio.c     |  15 +-
 android/hal-sco.c       | 605 ++++++++++++++++++++++++++++++++++++++++++------
 3 files changed, 538 insertions(+), 90 deletions(-)

-- 
1.9.1

