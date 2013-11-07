Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 00/11] Fix issues and implement virtual unplug and send data
Date: Fri,  8 Nov 2013 00:10:09 +0200
Message-Id: <1383862220-29968-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

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

Ravi kumar Veeramally (11):
  android/hid: Remove fixed number of hid set report data length in ipc
    doc
  android/hid: Add a ascii2hex utility
  android/hid: Fix set report data format
  android/hid: Add missing hid send data parameters in ipc document
  android/hid: Add missing parameters in send data struct in HAL headers
  android/hid: Fill send data structure variables in hal-hidhost
  android/hid: Rename virtual unplug define and struct
  android/hid: Add hid event virtual unplug structure to HAL msg headers
  android/hid: Handle virtual unplug notification in hid hal
  android/hid: Add virtual unplug implemention in daemon
  android/hid: Add send data implemention in daemon

 android/Android.mk      |  1 +
 android/Makefile.am     |  2 +-
 android/hal-hidhost.c   | 64 ++++++++++++++++++++++++++--------
 android/hal-ipc-api.txt |  6 ++--
 android/hal-msg.h       | 16 ++++++---
 android/hidhost.c       | 91 ++++++++++++++++++++++++++++++++++++++++++++-----
 android/utils.c         | 41 ++++++++++++++++++++++
 android/utils.h         |  3 ++
 8 files changed, 193 insertions(+), 31 deletions(-)
 create mode 100644 android/utils.c

-- 
1.8.3.2

