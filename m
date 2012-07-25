Return-Path: <cyrus@holtmann.org>
From: Chen Ganir <chen.ganir@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH v2 0/9] Add GATT Client Battery Service
Date: Wed, 25 Jul 2012 08:42:18 +0300
Message-ID: <1343194947-13659-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add suupport for LE GATT Client Battery Service.

This plugin adds battery list to the btd_device, exposes DBUS API to list the
device batteries, and allows querying for battery information. In addition this
patch allows getting notifications for battery level changes.

Look at doc/device-api.txt and doc/battery-api.txt for more information.

This is version 2 of this patch set, rebased on top of the latest sources and 
fixes some issues found during testing and in the ML comments.

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

 Makefile.am                          |   10 +-
 doc/battery-api.txt                  |   38 +++
 doc/device-api.txt                   |    5 +
 profiles/batterystate/batterystate.c |  518 ++++++++++++++++++++++++++++++++++
 profiles/batterystate/batterystate.h |   24 ++
 profiles/batterystate/main.c         |   67 +++++
 profiles/batterystate/manager.c      |   93 ++++++
 profiles/batterystate/manager.h      |   24 ++
 src/device.c                         |   66 +++++
 src/device.h                         |    3 +
 10 files changed, 846 insertions(+), 2 deletions(-)
 create mode 100644 doc/battery-api.txt
 create mode 100644 profiles/batterystate/batterystate.c
 create mode 100644 profiles/batterystate/batterystate.h
 create mode 100644 profiles/batterystate/main.c
 create mode 100644 profiles/batterystate/manager.c
 create mode 100644 profiles/batterystate/manager.h

-- 
1.7.9.5

