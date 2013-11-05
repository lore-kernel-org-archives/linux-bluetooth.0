Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 00/13] Implemented hid interfaces in daemon and hal
Date: Tue,  5 Nov 2013 13:38:02 +0200
Message-Id: <1383651495-12434-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v2: Fixed Johan's comments (splitting of patches, proper function and 
    struct names, update hal-msg.h and ipc document, alignment issues
    removed pointer from ipc struct) 

v1: This patch set implements get/set protocol and get/set report
    interfaces and supported functionality in daemon. Sending notifications
    and notification handling in hal. Few naming fixes and error handling.
    And last handling of few uHID events.

Ravi kumar Veeramally (13):
  android/hid: Add hid event proto mode structure to hal msg headers
  android/hid: Implement hid get protocol in daemon
  android/hid: Implement hid set protocol in daemon
  android/hid: Handle protocol mode notification in hal
  android/hid: Add hid event get report structure to hal msg headers
  android/hid: Implement hid get report in daemon
  android/hid: Add missing set report parameters to ipc document
  android/hid: Implement hid set report in daemon
  android/hid: Handle get report notification in hal
  android/hid: Replace header checking magic number with defines
  android/hid: Handle invalid parameters in hal
  android/hid: Handle uhid events
  android/hid: Align hal hid struct variables properly

 android/hal-hidhost.c   |  41 +++++-
 android/hal-ipc-api.txt |   4 +-
 android/hal-msg.h       |  41 ++++--
 android/hid.c           | 329 ++++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 385 insertions(+), 30 deletions(-)

-- 
1.8.1.2

