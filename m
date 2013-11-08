Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v3 0/5] Fixed and implemented set report and send data ifaces
Date: Fri,  8 Nov 2013 12:24:26 +0200
Message-Id: <1383906271-23554-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v3: Fixed issues as per Johan's and Jerzy' comments and suggestions
    Implemented hex2bin as a static funtion and split the patches.

v2: Fixed issues as per Johan's comments and suggestions.
    This patch adds missing hid ipc documentation, hal headers,
    renaming and virtual unplug notification in hid HAL.
    Set report and send data interfaces are receiving data in ascii format
    but it should be in hex format. Provided utility for this and fixed
    set report data preparation. Implemented virtual unplug and send data
    methods in daemon.

v1: This patch adds missing hid ipc documentation, hal headers,
    renaming and virtual unplug notification in hid HAL.
    send RFC for ascii2hex utility.
    Unsupported methods are virtual unplug and send data in daemon.

Ravi kumar Veeramally (5):
  android/hid: Fix set seport ipc cmd preparation
  android/hid: Fix set report data format in daemon
  android/hid: Fill send data command struct in hal-hidhost
  android/hid: Add send data implemention in daemon
  android/hid: Add virtual unplug implemention in daemon

 android/hal-hidhost.c | 47 +++++++++++++++++-------
 android/hal-msg.h     |  2 +-
 android/hidhost.c     | 99 +++++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 127 insertions(+), 21 deletions(-)

-- 
1.8.3.2

