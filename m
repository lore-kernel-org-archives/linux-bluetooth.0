Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 0/5] Initial Android IPC
Date: Sat, 19 Oct 2013 01:01:37 +0200
Message-Id: <1382137302-17237-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This adds initial code for Android IPC
- only connection establishment
- connecting ipc from daemon to HAL after adapter is initialized
- daemon track HAL lib lifetime and shutdown if socket is closed
- HAL library starts daemon (via android init) and wait for it to
  connect
- HAL library is *not* yet tracking lifetime of daemon

-- 
BR
Szymon Janc

Szymon Janc (5):
  android: Fix cutils/log.h stubs
  android: Define path for HAL communication socket
  android: Connect daemon to HAL library
  android: Make HAL library wait for daemon to connect on init
  android: Remove not needed property_get function form cutils stubs

 android/cutils/log.h        |  12 ++--
 android/cutils/properties.h |  27 ---------
 android/hal-bluetooth.c     | 127 ++++++++++++++++++++++++++++++++++--------
 android/hal-msg.h           |   2 +
 android/main.c              | 133 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 246 insertions(+), 55 deletions(-)

-- 
1.8.4.rc3

