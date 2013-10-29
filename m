Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 0/9] Improve logging for Android
Date: Tue, 29 Oct 2013 14:57:30 +0200
Message-Id: <1383051459-29495-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Logging on Android is really important since we do not have specification
how and in which order hal functions are called, sometimes the only way is
to examine logs or read Java Bluetooth code.

Changes:
	* v3: Merged first two patches.
	* v2: Added thread-safe helpers for printing properties, bdaddr, etc
	after comments that simple printing is not thread-safe. The idea is to
	use TLS (thread local storage) like bionic is doing for strerror for
	example. More info can be found on manpage for pthread_key_create.

This patch series uses debug functions defined already for haltest and
allows to print very helpful logs on Android target like shown below:

...
hal-bluetooth.c:set_adapter_property() prop: type=BT_PROPERTY_ADAPTER_SCAN_MODE len=4 val=BT_SCAN_MODE_NONE
...

Andrei Emeltchenko (9):
  android/haltest: Export print property
  android/haltest: Use pointer as parameter for debug
  android/hal: Print full property in debug
  android/hal: Add extra logs
  android/hal: Print adapter state
  android/hal: Print adapter property in callback
  android: Add thread-safe helpers
  android: Use thread-safe helpers
  android: Fix build errors

 android/Android.mk        |    2 +
 android/client/if-bt.c    |  112 +------------------------------------------
 android/client/textconv.c |  115 +++++++++++++++++++++++++++++++++++++++++++++
 android/client/textconv.h |    3 ++
 android/hal-bluetooth.c   |   28 ++++++-----
 android/pthread-local.h   |   58 +++++++++++++++++++++++
 6 files changed, 196 insertions(+), 122 deletions(-)
 create mode 100644 android/pthread-local.h

-- 
1.7.10.4

