Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 0/8] android: Some adapter and mgmt handling code cleanup
Date: Tue, 12 Nov 2013 23:48:12 +0000
Message-Id: <1384300100-8941-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

v2:
 - addressed Johan comments about using static adapter structure instead of
   bunch of static adapter_* variables
 - Added a patch for utilizing mgmt library for passing adapter ready callback
   (patch 3)

v1:
  This patchset moves mgmt initalization handling from main.c to adapter.c so
  now all mgmt handling is done from adaper.c. Adapter.c is also renamed to
  bluetooth.c to match service name implemented by it.

  Startup and shutdown timeouts are still handled in main.c (mostly due to
  both resulting in mainloop shutdown so extra callback are avoided).

  IO handling and commands dispatch is still done in main.c


Comments are welcome.

-- 
BR
Szymon Janc

Szymon Janc (8):
  android: Make adapter static
  android: Move adapter initialization to adapter.c
  android: Don't use static pointer for storing adapter_ready callback
  android/hidhost: Use adapter address provided on register
  android: Report adapter address in adapter_ready callback
  android: Remove not needed bt_adapter_get_address function
  android: Rename adapter.c to bluetooth.c
  android: Rename bluetooth service functions to match service name

 android/Android.mk  |    2 +-
 android/Makefile.am |    4 +-
 android/adapter.c   | 2008 -----------------------------------------------
 android/adapter.h   |   37 -
 android/bluetooth.c | 2177 +++++++++++++++++++++++++++++++++++++++++++++++++++
 android/bluetooth.h |   38 +
 android/hidhost.c   |   21 +-
 android/main.c      |  314 ++------
 8 files changed, 2287 insertions(+), 2314 deletions(-)
 delete mode 100644 android/adapter.c
 delete mode 100644 android/adapter.h
 create mode 100644 android/bluetooth.c
 create mode 100644 android/bluetooth.h

-- 
1.8.4.3

