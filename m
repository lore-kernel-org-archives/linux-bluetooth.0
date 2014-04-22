Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 00/11] Add health profile support for haltest
Date: Tue, 22 Apr 2014 15:05:59 +0300
Message-Id: <1398168371-29685-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v1: Patch set contains fixes and health profile support for
    haltest.

Ravi kumar Veeramally (11):
  android/hal-health: Use correct enums
  android/hal-health: Fix copying empty string
  android/hal-msg: Add mdep role and channel type defines
  android/health: Fix wrong boolean value for command handler
  android/health: Add initial function for HAL_OP_HEALTH_MDEP command
  android/client: Add initial support for health profile
  android/client: Add register_application support to haltest
  android/client: Add unregister_application support to haltest
  android/client: Add connect_channel support to haltest
  android/client: Add destroy_channel support to haltest
  android/client: Add health callbacks support for haltest

 android/Makefile.am      |   1 +
 android/client/haltest.c |   1 +
 android/client/if-bt.c   |   3 +-
 android/client/if-hl.c   | 301 +++++++++++++++++++++++++++++++++++++++++++++++
 android/client/if-main.h |   2 +
 android/hal-health.c     |  14 ++-
 android/hal-msg.h        |   7 ++
 android/health.c         |  13 +-
 8 files changed, 334 insertions(+), 8 deletions(-)
 create mode 100644 android/client/if-hl.c

-- 
1.8.3.2

