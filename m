Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v4 00/12] Implemented hid interfaces in daemon and HAL
Date: Tue,  5 Nov 2013 23:09:06 +0200
Message-Id: <1383685758-3900-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v4: Fixed Johan's comments (length issue and single byte array)

v3: Wrong order of patches

v2: Fixed Johan's comments (splitting of patches, proper function and
    struct names, update hal-msg.h and ipc document, alignment issues
    removed pointer from ipc struct)

v1: This patch set implements get/set protocol and get/set report
    interfaces and supported functionality in daemon. Sending notifications
    and notification handling in hal. Few naming fixes and error handling.
    And last handling of few uHID events.

Ravi kumar Veeramally (12):
  android/hid: Implement hid get protocol in daemon
  android/hid: Implement hid set protocol in daemon
  android/hid: Handle protocol mode notification in HAL
  android/hid: Add hid event get report structure to HAL msg headers
  android/hid: Implement hid get report in daemon
  android/hid: Add missing set report parameters to ipc document
  android/hid: Implement hid set report in daemon
  android/hid: Handle get report notification in HAL
  android/hid: Replace header checking magic number with defines
  android/hid: Handle invalid parameters in HAL
  android/hid: Handle uhid events
  android/hid: Align hal hid struct variables properly

 android/hal-hidhost.c   |  41 +++++-
 android/hal-ipc-api.txt |   4 +-
 android/hal-msg.h       |  32 +++--
 android/hid.c           | 325 ++++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 372 insertions(+), 30 deletions(-)

-- 
1.8.1.2

