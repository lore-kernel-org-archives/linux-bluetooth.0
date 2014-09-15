Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 00/11] android: Configuration command
Date: Mon, 15 Sep 2014 16:49:04 +0200
Message-Id: <1410792555-24765-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This is a respin of serie that was send some time ago as RFC [1]

This will allow to pass Android properties over IPC and use them
in daemon for customization eg. Device Information or default adapter name.

Comments from RFC was taken into account. So now "ro.bluetooth.*"
and "sys.persist.bluetooth.*" are taken into account (former takes
precedence if both are present). Some configs also fallback to
generic properties if no bluetooth ones are present.

Comments are welcome.

BR
Szymon Janc

[1] "[RFC 0/6] android: Configuration command"


Szymon Janc (11):
  android/hal-ipc-api: Add Configuration command
  android/hal-msg: Add configuration command
  android: Add support for configuration command
  android: Add functions for getting configuration options
  android/bluetooth: Use model name for default adapter name
  android/gatt: Use configuration data for device information profile
  android/hal-bluetooth: Add support for sending configuration
  android/hal: Add helper for quering config from Android properties
  android: Use helper for accesing Android properties
  android/bluetoothd-wrapper: Fix indentation
  android/README: Update customization section

 android/Android.mk           |   3 +-
 android/README               |  14 ++++--
 android/bluetooth.c          |  17 +++++--
 android/bluetoothd-wrapper.c |  19 +++----
 android/client/if-gatt.c     |   2 +
 android/cutils/properties.h  |   1 +
 android/gatt.c               | 115 ++++++++++++++++++++++++-------------------
 android/hal-bluetooth.c      |  51 ++++++++++++++++---
 android/hal-handsfree.c      |  15 +++---
 android/hal-ipc-api.txt      |  16 ++++++
 android/hal-msg.h            |  17 +++++++
 android/hal-utils.c          |  32 ++++++++++++
 android/hal-utils.h          |   2 +
 android/main.c               |  94 +++++++++++++++++++++++++++++++++++
 android/utils.h              |   4 ++
 15 files changed, 314 insertions(+), 88 deletions(-)

-- 
1.9.3

