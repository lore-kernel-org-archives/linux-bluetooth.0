Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 0/7] android: Some adapter and mgmt handling code cleanup
Date: Tue, 12 Nov 2013 00:24:10 +0000
Message-Id: <1384215857-19679-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This patchset moves mgmt initalization handling from main.c to adapter.c so
now all mgmt handling is done from adaper.c. Adapter.c is also renamed to
bluetooth.c to match service name implemented by it.

Startup and shutdown timeouts are still handled in main.c (mostly due to
both resulting in mainloop shutdown so extra callback are avoided).

IO handling and commands dispatch is still done in main.c

-- 
BR
Szymon Janc


Szymon Janc (7):
  android: Remove bt_adapter structure
  android: Move adapter initialization to adapter.c
  android/hidhost: Use adapter address provided on register
  android: Report adapter address in adapter_ready callback
  android: Remove not needed bt_adapter_get_address function
  android: Rename adapter.c to bluetooth.c
  android: Rename bluetooth service functions to match service name

 android/Android.mk  |    2 +-
 android/Makefile.am |    4 +-
 android/adapter.c   | 1833 -----------------------------------------------
 android/adapter.h   |   34 -
 android/bluetooth.c | 1985 +++++++++++++++++++++++++++++++++++++++++++++++++++
 android/bluetooth.h |   35 +
 android/hidhost.c   |   21 +-
 android/main.c      |  314 ++------
 8 files changed, 2092 insertions(+), 2136 deletions(-)
 delete mode 100644 android/adapter.c
 delete mode 100644 android/adapter.h
 create mode 100644 android/bluetooth.c
 create mode 100644 android/bluetooth.h

-- 
1.8.4.2

