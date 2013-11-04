Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 00/11] Implemented hid interfaces in daemon and hal
Date: Tue,  5 Nov 2013 00:20:04 +0200
Message-Id: <1383603615-9953-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set implements get/set protocol and get/set report
interfaces and supported functionality in daemon. Sending notifications
and notification handling in hal. Few naming fixes and error handling.
And last handling of few uHID events.

Ravi kumar Veeramally (11):
  android/hid: Rename function name set_state to notify_state
  android/hid: Retrieve BOOT_DEVICE attribute from SDP and cache it
  android/hid: Implement hid get protocol in daemon
  android/hid: Implement hid set protocol in daemon
  android/hid: Handle protocol mode notification in hal
  android/hid: Implement hid get report in daemon
  android/hid: Implement hid set report in daemon
  android/hid: Handle get report notification in hal
  android/hid: Replace header checking magic number with defines
  android/hid: Handle invalid parameters in hal
  android/hid: Handle uhid events

 android/hal-hidhost.c |  40 +++++-
 android/hal-msg.h     |  18 +++
 android/hid.c         | 353 +++++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 384 insertions(+), 27 deletions(-)

-- 
1.8.1.2

