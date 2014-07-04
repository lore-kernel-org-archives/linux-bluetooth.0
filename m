Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 00/12] Varios fixes
Date: Fri,  4 Jul 2014 16:43:49 +0300
Message-Id: <1404481441-734-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes hanging in my tree for some time

Andrei Emeltchenko (12):
  android/gatt: Change DBG() to error()
  android/gatt: Fix memory leak
  android/hal-msg: trivial: Correct coding style
  android/gatt: Fix warning by rearranging allocation
  android/haltest: Auto-accept pairing
  android/hal-gatt: Remove unneeded never read initialization
  android/gatt: Add missing error check
  android/haltest: Add check for valid channel
  android/tester: Remove unused assignment
  android/gatt: Fix length check
  cups: Remove dead code
  core: Remove dead code

 android/android-tester.c |  2 +-
 android/client/if-bt.c   | 16 +++++++++++++++-
 android/client/if-hl.c   |  4 ++++
 android/gatt.c           | 17 +++++++++++------
 android/hal-gatt.c       |  4 +---
 android/hal-msg.h        |  8 ++++----
 profiles/cups/main.c     |  7 +------
 src/profile.c            |  4 ----
 8 files changed, 37 insertions(+), 25 deletions(-)

-- 
1.9.1

