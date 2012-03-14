Return-Path: <cyrus@holtmann.org>
From: chen.ganir@ti.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH v6 0/2] DeviceInfoService and BatteryService Clients
Date: Wed, 14 Mar 2012 13:37:56 +0200
Message-Id: <1331725078-27485-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Add Battery Service client and Device Information Service Client stubs.
More logic will be added to these service as development continues.

This is version 6 of the patch set, rebased on the latest modifications
to the GATT switches.


Chen Ganir (2):
  Add DeviceInformation GATT Client
  Add Battery Service GATT Client

 Makefile.am                 |   12 ++++-
 batterystate/batterystate.c |   90 +++++++++++++++++++++++++++++++++++++++++++
 batterystate/batterystate.h |   24 +++++++++++
 batterystate/main.c         |   56 ++++++++++++++++++++++++++
 batterystate/manager.c      |   80 ++++++++++++++++++++++++++++++++++++++
 batterystate/manager.h      |   24 +++++++++++
 deviceinfo/deviceinfo.c     |   88 ++++++++++++++++++++++++++++++++++++++++++
 deviceinfo/deviceinfo.h     |   24 +++++++++++
 deviceinfo/main.c           |   55 ++++++++++++++++++++++++++
 deviceinfo/manager.c        |   80 ++++++++++++++++++++++++++++++++++++++
 deviceinfo/manager.h        |   24 +++++++++++
 11 files changed, 554 insertions(+), 3 deletions(-)
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

