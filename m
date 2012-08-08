Return-Path: <cyrus@holtmann.org>
From: <chen.ganir@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <jprvita@openbossa.org>, Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH v3 0/9] Add GATT Client Battery Service
Date: Wed, 8 Aug 2012 17:26:11 +0300
Message-ID: <1344435980-9866-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Add suupport for LE GATT Client Battery Service.

This plugin adds battery list to the btd_device, exposes DBUS API to list the
device batteries, and allows querying for battery information. In addition this
patch allows getting notifications for battery level changes.

Look at doc/device-api.txt and doc/battery-api.txt for more information.

This is version 3 of this patch set, rebased on top of the latest sources and 
fixes issues reported on the ML.

Chen Ganir (9):
  Battery: Add Battery Service GATT Client
  Battery: Add connection logic
  Battery: Discover Characteristic Descriptors
  Battery: Get Battery ID
  Battery: Add Battery list to btd_device
  Battery: Add Battery D-BUS API
  Battery: Read Battery level characteristic
  Battery: Add support for notifications
  Battery: Emit property changed on first read

 Makefile.am                |   10 +-
 doc/battery-api.txt        |   38 ++++
 doc/device-api.txt         |    5 +
 profiles/battery/battery.c |  536 ++++++++++++++++++++++++++++++++++++++++++++
 profiles/battery/battery.h |   26 +++
 profiles/battery/main.c    |   67 ++++++
 profiles/battery/manager.c |   71 ++++++
 profiles/battery/manager.h |   24 ++
 src/device.c               |   65 ++++++
 src/device.h               |    3 +
 10 files changed, 843 insertions(+), 2 deletions(-)
 create mode 100644 doc/battery-api.txt
 create mode 100644 profiles/battery/battery.c
 create mode 100644 profiles/battery/battery.h
 create mode 100644 profiles/battery/main.c
 create mode 100644 profiles/battery/manager.c
 create mode 100644 profiles/battery/manager.h

-- 
1.7.9.5

