Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 0/5] Add support for new AVRCP ctrl interface
Date: Mon, 10 Nov 2014 16:05:04 +0200
Message-Id: <1415628309-7384-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v2: Fixed Luiz's comments (added new interface at bottom in
    hal-ipc-txt and ID in hal-msg.h).

v1: Android Lollipop has new interface for AVRCP controller. It has
    one command and two callbacks. Patchset updates support for IPC
    doc, hal-msg, HAL part and client part. 

Ravi kumar Veeramally (5):
  android/hal-ipc-txt: Add support for new AVRCP CTRL interface
  android/hal-msg: Add support for new AVRCP CTRL interface
  android/hal-avrcp: Add suuport for new AVRCP ctrl interface
  android/client: Add support for new AVRCP CTRL interface
  android/avrcp: Add initial support for new AVRCP CTRL interface

 android/avrcp.c          |  72 ++++++++++++++++++++++------
 android/avrcp.h          |   4 ++
 android/client/if-bt.c   |   2 +
 android/client/if-main.h |   2 +
 android/client/if-rc.c   |  88 ++++++++++++++++++++++++++++++++++
 android/hal-avrcp.c      | 122 +++++++++++++++++++++++++++++++++++++++++++++++
 android/hal-bluetooth.c  |   3 ++
 android/hal-ipc-api.txt  |  45 ++++++++++++++++-
 android/hal-msg.h        |  24 +++++++++-
 android/hal.h            |   1 +
 android/main.c           |  11 +++++
 11 files changed, 356 insertions(+), 18 deletions(-)

-- 
2.1.0

