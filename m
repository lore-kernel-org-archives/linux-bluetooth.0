Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 0/2] Create separate file for AVRCP CTRL
Date: Tue, 18 Nov 2014 15:34:41 +0200
Message-Id: <1416317683-15258-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v2: New HAL and related Client files should be build only for
    Android 5 (Fixed Szymon's comments).

v1: Patchset contains changes related to AVRCP CTRL. Moving AVRCP CTRL
    HAL and Client related changes to it's own file (agreed on IRC to
    maintain separate file for each HAL).

Ravi kumar Veeramally (2):
  android/hal-avrcp-ctrl: Create separate HAL for AVRCP CTRL
  android/client: Create separate file for AVRCP CTRL

 android/Android.mk          |   6 +-
 android/Makefile.am         |   2 +
 android/client/haltest.c    |   2 +
 android/client/if-rc-ctrl.c | 112 ++++++++++++++++++++++++++++++++++
 android/client/if-rc.c      |  88 ---------------------------
 android/hal-avrcp-ctrl.c    | 144 ++++++++++++++++++++++++++++++++++++++++++++
 android/hal-avrcp.c         | 121 -------------------------------------
 7 files changed, 264 insertions(+), 211 deletions(-)
 create mode 100644 android/client/if-rc-ctrl.c
 create mode 100644 android/hal-avrcp-ctrl.c

-- 
2.1.0

