Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 0/6] android: Configuration command
Date: Tue, 13 May 2014 19:09:15 +0200
Message-Id: <1400000961-24376-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This will allow to pass Android properties over IPC and use them
in daemon for customization eg. Device Information or default adapter name.

Open points:
 - what properties should be read, currently I use ro.product.* as those
   are present on AOSP Nexus devices, but eg. on Xperia phones there
   seem to be ro.semc.product.* with more userfriendly name, so this
   may vary upon devices. (eg ST18i vs Xperia Ray in model property).
   Or maybe just use ro.bluetooth.* and require integrator to set those
   accrodingly?

 - should we also use this instead of 'Mode' passed on service init?
   This would keep handling of all properities consistent but I'm fine
   if we decide to keep Modes special.

Comments are welcome.

BR
Szymon Janc

Szymon Janc (6):
  android/hal-msg: Add configuration command
  android: Add support for configuration command
  android: Add functions for getting configuration options
  android/hal-bluetooth: Add support for sending configuration
  android/bluetooth: Use system id for default adapter name
  android/gatt: Use configuration data for device information profile

 android/bluetooth.c     |  16 +++++--
 android/gatt.c          | 125 +++++++++++++++++++++++++-----------------------
 android/hal-bluetooth.c |  48 +++++++++++++++++++
 android/hal-msg.h       |  18 +++++++
 android/main.c          |  90 ++++++++++++++++++++++++++++++++++
 android/utils.h         |   5 ++
 6 files changed, 238 insertions(+), 64 deletions(-)

-- 
1.9.1

