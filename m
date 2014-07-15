Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/8] haltest support for Audio SCO HAL testing
Date: Tue, 15 Jul 2014 10:59:19 +0300
Message-Id: <1405411167-15638-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Helps to test Audio SCO HAL

Andrei Emeltchenko (8):
  android/haltest: Add open/close input stream commands
  android/haltest: Add read command.
  android/haltest: Add loop command
  android/haltest: Implement read to file
  android/haltest: Add sample rate parameter when opening audio streams
  android/haltest: Correct check for similar buffer size
  android/haltest: Add mono to stereo conversion for loopback
  android/haltest: Refactor stop and closing streams

 android/Android.mk      |   3 +
 android/client/if-sco.c | 291 ++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 283 insertions(+), 11 deletions(-)

-- 
1.9.1

