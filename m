Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 00/15] Add HDP profile support at HAL side
Date: Wed, 12 Mar 2014 17:10:43 +0200
Message-Id: <1394637058-586-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Patch set contains HDP profile support at HAL side and initial
profile registration support at daemon side.

Ravi kumar Veeramally (15):
  android/hal-msg: Add HDP app registration struct
  android/hal-msg: Add HDP app unregistration struct
  android/hal-msg: Add HDP connect channel struct
  android/hal-msg: Add HDP destroy channel struct
  android/hal-msg: Add HDP app registration state event struct
  android/hal-msg: Add HDP app channel state event struct
  android/hal-health: Add hal-health file
  android/hal-health: Add HDP .init method
  android/hal-health: Add HDP .cleanup method
  android/hal-health: Add HDP .register_application method
  android/hal-health: Add HDP .unregister_application method
  android/hal-health: Add HDP .connect_channel method
  android/hal-health: Add HDP .destroy_channel method
  android/hal-health: Add app state and channel state event handlers
  android/health: Add health.c|h file with basic calls

 android/Android.mk   |   2 +
 android/Makefile.am  |   2 +
 android/hal-health.c | 243 +++++++++++++++++++++++++++++++++++++++++++++++++++
 android/hal-msg.h    |  68 ++++++++++++++
 android/hal.h        |   2 +
 android/health.c     | 115 ++++++++++++++++++++++++
 android/health.h     |  25 ++++++
 android/main.c       |  10 +++
 8 files changed, 467 insertions(+)
 create mode 100644 android/hal-health.c
 create mode 100644 android/health.c
 create mode 100644 android/health.h

-- 
1.8.3.2

