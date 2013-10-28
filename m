Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 0/4] Improve logging for Android
Date: Mon, 28 Oct 2013 12:44:03 +0200
Message-Id: <1382957047-31775-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This patch series uses debug functions defined already for haltest and
allows to print very helpful logs on Android target like shown below:

...
hal-bluetooth.c:set_adapter_property() prop: type=BT_PROPERTY_ADAPTER_SCAN_MODE len=4 val=BT_SCAN_MODE_NONE
...

Andrei Emeltchenko (4):
  android/haltest: Export print property
  android/haltest: Use pointer as parameter for debug
  android/hal: Print full property in debug
  android/hal: Add extra logs

 android/client/if-bt.c    |  112 +--------------------------------------------
 android/client/textconv.c |  110 ++++++++++++++++++++++++++++++++++++++++++++
 android/client/textconv.h |    3 ++
 android/hal-bluetooth.c   |   24 +++++-----
 4 files changed, 127 insertions(+), 122 deletions(-)

-- 
1.7.10.4

