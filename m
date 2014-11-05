Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/9] 1st part of handsfree Android 5.0 adaptation code
Date: Wed,  5 Nov 2014 16:38:44 +0200
Message-Id: <1415198333-7775-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add support for Android 5.0 interfaces (1st part of patches).

Andrei Emeltchenko (9):
  android/handsfree: Add support for new API for handsfree init
  android/handsfree: Add support for new API for start_vr
  android/handsfree: Add support for new API for stop_vr
  android/handsfree: Add support for new API for volume_control
  android/handsfree: Add support for new API for cops_response
  android/handsfree: Add support for new API for cind_response
  android/handsfree: Add support for new API for formatted_at_response
  android/handsfree: Add support for new API for at_response
  android/handsfree: Add support for new API for clcc_response

 android/hal-handsfree.c | 209 +++++++++++++++++++++++++++++++++++++++++++++---
 android/hal-ipc-api.txt |  11 ++-
 android/hal-msg.h       |  13 +++
 android/handsfree.c     |  47 ++++++++---
 android/handsfree.h     |   3 +-
 android/main.c          |   3 +-
 6 files changed, 260 insertions(+), 26 deletions(-)

-- 
1.9.1

