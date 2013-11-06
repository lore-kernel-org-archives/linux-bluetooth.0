Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 0/6] Add missing hid ipc doc and hal headers
Date: Wed,  6 Nov 2013 13:48:42 +0200
Message-Id: <1383738528-14550-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds missing hid ipc documentation, hal headers,
renaming and virtual unplug notification in hid HAL.
Unsupported methods are virtual unplug and send data in daemon.

Ravi kumar Veeramally (6):
  android/hid: Add missing hid send data parameters in ipc document
  android/hid: Add missing parameters in send data struct in HAL headers
  android/hid: Fill send data structure variables in hal-hidhost
  android/hid: Rename virtual unplug define and struct
  android/hid: Add hid event virtual unplug structure to HAL msg headers
  android/hid: Handle virtual unplug notification in hid hal

 android/hal-hidhost.c   | 18 ++++++++++++++++--
 android/hal-ipc-api.txt |  4 +++-
 android/hal-msg.h       | 14 +++++++++++---
 android/hid.c           |  5 +++--
 4 files changed, 33 insertions(+), 8 deletions(-)

-- 
1.8.1.2

