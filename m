Return-Path: <cyrus@holtmann.org>
From: <chen.ganir@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <chen.ganir@ti.com>
Subject: [PATCH v3 00/10] Implement Generic battery and LE Battery client
Date: Thu, 20 Sep 2012 11:27:33 +0300
Message-ID: <1348129663-1701-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

This patch set replaces previous patch sets which implemented the LE battery
GATT Client. This patch set implements a generic device battery D-Bus interface
that can be used to get remote device battery status using D-Bus. In addition,
This patch set also implements the GATT Battery client, which uses the generic
device battery to expose LE device battery status.

see doc/battery-api.txt and doc/device-api.txt for more information.

This is version 2 of the patch set, including multiple style and other comments
reported on the ML. This version is rebased on the latest code.

Chen Ganir (10):
  battery: Add generic device battery documentation
  battery: Implement Generic device battery
  battery: Add GATT Battery Client Service skeleton
  battery: Add client connection logic
  battery: Discover Characteristic Descriptors
  battery: Get Battery ID
  battery: Add Battery to device
  battery: Read Battery level characteristic
  battery: Add support for notifications
  battery: Support persistent battery level

 Makefile.am                |    9 +-
 doc/battery-api.txt        |   31 +++
 doc/device-api.txt         |    5 +
 lib/uuid.h                 |    3 +
 profiles/battery/battery.c |  594 ++++++++++++++++++++++++++++++++++++++++++++
 profiles/battery/battery.h |   24 ++
 profiles/battery/main.c    |   52 ++++
 profiles/battery/manager.c |   62 +++++
 profiles/battery/manager.h |   24 ++
 src/device.c               |  182 ++++++++++++++
 src/device.h               |   15 ++
 test/test-device           |   13 +
 12 files changed, 1012 insertions(+), 2 deletions(-)
 create mode 100644 doc/battery-api.txt
 create mode 100644 profiles/battery/battery.c
 create mode 100644 profiles/battery/battery.h
 create mode 100644 profiles/battery/main.c
 create mode 100644 profiles/battery/manager.c
 create mode 100644 profiles/battery/manager.h

-- 
1.7.9.5

