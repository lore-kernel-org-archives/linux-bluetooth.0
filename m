Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 0/4] Add support for new AVRCP ctrl interface
Date: Mon, 10 Nov 2014 13:37:53 +0200
Message-Id: <1415619477-2358-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Android Lollipop has new interface for AVRCP controller. It has
one command and two callbacks. Patchset updates support for IPC doc,
hal-msg, HAL part and client part. 

Ravi kumar Veeramally (4):
  android/hal-ipc-txt: Add support for new AVRCP CTRL interface
  android/hal-msg: Add support for new AVRCP CTRL interface
  android/hal-avrcp: Add suuport for new AVRCP ctrl interface
  android/client: Add support for new AVRCP CTRL interface

 android/client/if-bt.c   |   2 +
 android/client/if-main.h |   2 +
 android/client/if-rc.c   |  88 ++++++++++++++++++++++++++++++++++
 android/hal-avrcp.c      | 122 +++++++++++++++++++++++++++++++++++++++++++++++
 android/hal-bluetooth.c  |   3 ++
 android/hal-ipc-api.txt  |  49 +++++++++++++++++--
 android/hal-msg.h        |  30 ++++++++++--
 android/hal.h            |   1 +
 8 files changed, 289 insertions(+), 8 deletions(-)

-- 
2.1.0

