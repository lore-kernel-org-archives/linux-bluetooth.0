Return-Path: <cyrus@holtmann.org>
From: Paulo Borges <paulo.borges@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH 0/9] Battery Profile implementation
Date: Mon,  7 Jan 2013 16:40:55 -0300
Message-Id: <1357587664-16818-1-git-send-email-paulo.borges@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch series implements GATT Battery profile, and it is based on
the work of Chen Ganir.

Battery Profile is mandatory for HoG (HID over GATT).

What has been done upon the previous version:

* bugfixes
* new storage schema using key-files
* compliant with object manager

Although I've changed all commits in the series, I just took the
authorship of commits modified meaninfuly.

Chen Ganir (6):
  battery: Add GATT Battery Client Service skeleton
  battery: Discover Characteristic Descriptors
  battery: Get Battery ID
  battery: Add Battery to device
  battery: Read Battery level characteristic
  battery: Add support for notifications

Paulo Borges (3):
  battery: Add generic device battery documentation
  battery: Implement Generic device battery
  battery: Support persistent battery level

 Makefile.plugins           |    3 +
 doc/battery-api.txt        |   24 ++
 lib/uuid.h                 |    3 +
 profiles/battery/battery.c |  638 ++++++++++++++++++++++++++++++++++++++++++++
 src/device.c               |  140 ++++++++++
 src/device.h               |   15 ++
 test/test-device           |   15 ++
 7 files changed, 838 insertions(+)
 create mode 100644 doc/battery-api.txt
 create mode 100644 profiles/battery/battery.c

-- 
1.7.9.5

