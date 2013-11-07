Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [RFC 0/3] Fix ascii to hex conversion in HAL to deamon ipc PDU
Date: Thu,  7 Nov 2013 11:26:58 +0200
Message-Id: <1383816421-18878-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case of set report and send data HAL receives the data in ascii format
but it should be in hex. This patch set updates the document, provides
utility and fix the issue in set report case.

Ravi kumar Veeramally (3):
  android/hid: Remove fixed number of hid set report data length in ipc
    doc
  android/hid: Add a ascii2hex utility
  android/hid: Fix set report data format

 android/Android.mk      |  1 +
 android/Makefile.am     |  2 +-
 android/hal-ipc-api.txt |  2 +-
 android/hal-msg.h       |  2 +-
 android/hid.c           | 12 +++++++---
 android/utils.c         | 60 +++++++++++++++++++++++++++++++++++++++++++++++++
 android/utils.h         |  3 +++
 7 files changed, 76 insertions(+), 6 deletions(-)
 create mode 100644 android/utils.c

-- 
1.8.3.2

