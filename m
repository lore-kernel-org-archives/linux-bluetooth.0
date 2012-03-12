Return-Path: <cyrus@holtmann.org>
From: chen.ganir@ti.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH v3 0/2] DeviceInfo and BatteryService Clients
Date: Mon, 12 Mar 2012 15:12:17 +0200
Message-Id: <1331557939-26191-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Adding Battery Service client and Device Information Service Client stubs.
More logic will be added to these service as development continues.
To enable the new features you will need to use:
--enable-batterystate
--enable-deviceinfo

This is version 3 of the patch set, after fixing some problems which were
reported in the mailing list + copyright mistakes.


Chen Ganir (2):
  Added DeviceInformation GATT Client
  Added Battery Service GATT Client

 Makefile.am                 |   14 +++++++
 acinclude.m4                |   12 ++++++
 batterystate/batterystate.c |   90 +++++++++++++++++++++++++++++++++++++++++++
 batterystate/batterystate.h |   24 +++++++++++
 batterystate/main.c         |   49 +++++++++++++++++++++++
 batterystate/manager.c      |   85 ++++++++++++++++++++++++++++++++++++++++
 batterystate/manager.h      |   24 +++++++++++
 deviceinfo/deviceinfo.c     |   88 ++++++++++++++++++++++++++++++++++++++++++
 deviceinfo/deviceinfo.h     |   24 +++++++++++
 deviceinfo/main.c           |   48 +++++++++++++++++++++++
 deviceinfo/manager.c        |   85 ++++++++++++++++++++++++++++++++++++++++
 deviceinfo/manager.h        |   24 +++++++++++
 12 files changed, 567 insertions(+), 0 deletions(-)
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

