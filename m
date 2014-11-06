Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 00/14] 2nd part of handsfree Android 5.0 adaptation code
Date: Thu,  6 Nov 2014 10:31:55 +0200
Message-Id: <1415262729-12573-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add support for Android 5.0 interfaces (2nd part of patches) - callbacks.

Andrei Emeltchenko (14):
  android/handsfree: Add support for new API for vr_cmd_cb
  android/handsfree: Add support for new API for handle_answer
  android/handsfree: Add support for new API for hangup_call_cmd_cb
  android/handsfree: Add support for new API for volume_cmd_cb
  android/handsfree: Add support for new API for dial_call_cmd_cb
  android/handsfree: Add support for new API for handle_dtmf
  android/handsfree: Add support for new API for nrec_cmd_cb
  android/handsfree: Add support for new API for chld_cmd_cb
  android/handsfree: Add support for new API for cnum_cmd_cb
  android/handsfree: Add support for new API for cind_cmd_cb
  android/handsfree: Add support for new API for cops_cmd_cb
  android/handsfree: Add support for new API for clcc_cmd_cb
  android/handsfree: Add support for new API for unknown_at_cmd_cb
  android/handsfree: Add support for new API for key_pressed_cmd_cb

 android/hal-handsfree.c | 95 ++++++++++++++++++++++++++++++++++++++++++++-----
 android/hal-ipc-api.txt | 25 ++++++++-----
 android/hal-msg.h       | 28 +++++++++++++++
 android/handsfree.c     | 48 +++++++++++++++++++++----
 4 files changed, 172 insertions(+), 24 deletions(-)

-- 
1.9.1

