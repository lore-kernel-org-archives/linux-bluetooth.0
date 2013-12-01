Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 0/4] more sixaxis goodies
Date: Sun,  1 Dec 2013 14:41:52 +0100
Message-Id: <1385905316-21800-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This adds support for setting PS3 controller LEDs both over Bluetooth
and USB. More details in commits messages.

One thing I noticed is that setting LEDs over Bluetooth fails on kernel
3.10+ (write always returns 0). Could this be related to HIDP related
work that was merged in 3.10?

Comments and testing are welcome.

-- 
BR
Szymon Janc
Szymon Janc (4):
  sixaxis: Add support for setting PS3 controller LEDs
  Rename device_is_connected to btd_device_is_connected
  sixaxis: Skip controller setup if already connected over Bluetooth
  sixaxis: Add support for setting LEDs when connected over USB

 plugins/sixaxis.c       | 164 +++++++++++++++++++++++++++++++++++++++++++++---
 profiles/input/device.c |   4 +-
 src/adapter.c           |   6 +-
 src/device.c            |   6 +-
 src/device.h            |   2 +-
 5 files changed, 165 insertions(+), 17 deletions(-)

-- 
1.8.5

