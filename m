Return-Path: <cyrus@holtmann.org>
From: chen.ganir@ti.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH v5 0/4] Add DeviceInformationService plugin
Date: Tue,  3 Apr 2012 08:35:24 +0300
Message-Id: <1333431328-26888-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Add Device Information Service GATT Client for reading peer
device PNP_ID and store it.

This is v5 of the patch set, fixing style issues

Chen Ganir (4):
  Add DeviceInformation GATT Client
  DeviceInfo: Add connection logic
  DeviceInfo: Discover Characteristics
  DeviceInfo: Read PNP ID

 Makefile.am             |    9 ++-
 deviceinfo/deviceinfo.c |  193 +++++++++++++++++++++++++++++++++++++++++++++++
 deviceinfo/deviceinfo.h |   24 ++++++
 deviceinfo/main.c       |   52 +++++++++++++
 deviceinfo/manager.c    |   82 ++++++++++++++++++++
 deviceinfo/manager.h    |   24 ++++++
 doc/device-api.txt      |    4 +
 src/device.c            |   34 ++++++++
 src/device.h            |    4 +
 9 files changed, 423 insertions(+), 3 deletions(-)
 create mode 100644 deviceinfo/deviceinfo.c
 create mode 100644 deviceinfo/deviceinfo.h
 create mode 100644 deviceinfo/main.c
 create mode 100644 deviceinfo/manager.c
 create mode 100644 deviceinfo/manager.h

-- 
1.7.4.1

