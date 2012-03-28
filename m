Return-Path: <cyrus@holtmann.org>
From: chen.ganir@ti.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH v3 0/5] Add DeviceInformationService plugin
Date: Wed, 28 Mar 2012 17:26:40 +0200
Message-Id: <1332948405-1104-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Add Device Information Service GATT Client for reading peer
device PNP_ID and store it.

This is v3 of the patch set, modifying the doc/device-api.txt.

Chen Ganir (5):
  Add DeviceInformation GATT Client
  DeviceInfo: Add connection logic
  DeviceInfo: Discover Characteristics
  Fix device version in GetProperties
  DeviceInfo: Read PNP ID

 Makefile.am             |    9 ++-
 deviceinfo/deviceinfo.c |  205 +++++++++++++++++++++++++++++++++++++++++++++++
 deviceinfo/deviceinfo.h |   24 ++++++
 deviceinfo/main.c       |   55 +++++++++++++
 deviceinfo/manager.c    |   82 +++++++++++++++++++
 deviceinfo/manager.h    |   24 ++++++
 doc/device-api.txt      |    4 +
 src/device.c            |   35 ++++++++-
 src/device.h            |    3 +
 9 files changed, 437 insertions(+), 4 deletions(-)
 create mode 100644 deviceinfo/deviceinfo.c
 create mode 100644 deviceinfo/deviceinfo.h
 create mode 100644 deviceinfo/main.c
 create mode 100644 deviceinfo/manager.c
 create mode 100644 deviceinfo/manager.h

-- 
1.7.4.1

