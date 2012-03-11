Return-Path: <cyrus@holtmann.org>
From: chen.ganir@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH 0/2] DeviceInfo and BatteryService Clients
Date: Sun, 11 Mar 2012 14:57:20 +0200
Message-Id: <1331470642-23924-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Adding Battery Service client and Device Information Service Client stubs.
More logic will be added to these service as development continues.
To enable the new features you will need to use:
--enable-batterystate
--enable-deviceinfo


Chen Ganir (2):
  Added DeviceInformation GATT Client
  Added Battery Service GATT Client

 Makefile.am                 |   14 +++++++
 acinclude.m4                |   12 ++++++
 batterystate/batterystate.c |   89 +++++++++++++++++++++++++++++++++++++++++
 batterystate/batterystate.h |   26 ++++++++++++
 batterystate/main.c         |   60 ++++++++++++++++++++++++++++
 batterystate/manager.c      |   92 +++++++++++++++++++++++++++++++++++++++++++
 batterystate/manager.h      |   25 ++++++++++++
 deviceinfo/deviceinfo.c     |   89 +++++++++++++++++++++++++++++++++++++++++
 deviceinfo/deviceinfo.h     |   26 ++++++++++++
 deviceinfo/main.c           |   60 ++++++++++++++++++++++++++++
 deviceinfo/manager.c        |   92 +++++++++++++++++++++++++++++++++++++++++++
 deviceinfo/manager.h        |   25 ++++++++++++
 12 files changed, 610 insertions(+), 0 deletions(-)
 create mode 100644 batterystate/batterystate.c
 create mode 100644 batterystate/batterystate.h
 create mode 100644 batterystate/main.c
 create mode 100644 batterystate/manager.c
 create mode 100644 batterystate/manager.h
 create mode 100644 deviceinfo/deviceinfo.c
 create mode 100644 deviceinfo/deviceinfo.h
 create mode 100644 deviceinfo/main.c
 create mode 100644 deviceinfo/manager.c
 create mode 100644 deviceinfo/manager.h

-- 
1.7.4.1

