Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 0/6] Initial Android IPC
Date: Sun, 20 Oct 2013 11:53:52 +0200
Message-Id: <1382262838-25725-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

V2:
- simplify daemon code
- sockets handling cleanup
- other minor fixes

-- 
BR
Szymon Janc

Szymon Janc (6):
  android: Fix missing log cleanup on daemon exit
  android: Improve cutils/log.h stubs
  android: Define path for HAL communication socket
  android: Connect daemon to HAL library
  android: Make HAL library wait for daemon to connect on init
  android: Remove not needed property_get function form cutils stubs

 android/cutils/log.h        |  10 ++--
 android/cutils/properties.h |  27 ----------
 android/hal-bluetooth.c     | 126 ++++++++++++++++++++++++++++++++++++--------
 android/hal-msg.h           |   2 +
 android/main.c              | 124 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 234 insertions(+), 55 deletions(-)

-- 
1.8.4

