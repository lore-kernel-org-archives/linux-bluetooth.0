Return-Path: <cyrus@holtmann.org>
From: <chen.ganir@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH v4 0/10] Add GATT Client Battery Service
Date: Thu, 16 Aug 2012 12:34:53 +0300
Message-ID: <1345109702-5698-1-git-send-email-chen.ganir@ti.com>
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

This is version 4 of this patch set, rebased on top of the latest sources and 
fixes:

  Remove namespace and descriptor battery properties 
  Documentation changes are now in one single patch
  reorder some patches

Chen Ganir (10):
  Battery: Add Battery Service Gatt Client
  Battery: Add Battery Service plugin skeleton
  Battery: Add connection logic
  Battery: Discover Characteristic Descriptors
  Battery: Get Battery ID
  Battery: Add Battery list to btd_device
  Battery: Read Battery level characteristic
  Battery: Add Battery D-BUS API
  Battery: Add support for notifications
  Battery: Emit property changed on first read

 Makefile.am                |   10 +-
 doc/battery-api.txt        |   26 +++
 doc/device-api.txt         |    5 +
 profiles/battery/battery.c |  529 ++++++++++++++++++++++++++++++++++++++++++++
 profiles/battery/battery.h |   26 +++
 profiles/battery/main.c    |   67 ++++++
 profiles/battery/manager.c |   71 ++++++
 profiles/battery/manager.h |   24 ++
 src/device.c               |   65 ++++++
 src/device.h               |    3 +
 10 files changed, 824 insertions(+), 2 deletions(-)
 create mode 100644 doc/battery-api.txt
 create mode 100644 profiles/battery/battery.c
 create mode 100644 profiles/battery/battery.h
 create mode 100644 profiles/battery/main.c
 create mode 100644 profiles/battery/manager.c
 create mode 100644 profiles/battery/manager.h

-- 
1.7.9.5

