Return-Path: <cyrus@holtmann.org>
From: chen.ganir@ti.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH v6 0/4] Add DeviceInformationService plugin
Date: Wed,  4 Apr 2012 11:28:53 +0300
Message-Id: <1333528137-9305-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Add Device Information Service GATT Client for reading peer
device PNP_ID and store it.

Chen Ganir (4):
  Add DeviceInformation GATT Client
  DeviceInfo: Add connection logic
  DeviceInfo: Discover Characteristics
  DeviceInfo: Read PNP ID

 Makefile.am             |    8 ++-
 deviceinfo/deviceinfo.c |  193 +++++++++++++++++++++++++++++++++++++++++++++++
 deviceinfo/deviceinfo.h |   24 ++++++
 deviceinfo/main.c       |   52 +++++++++++++
 deviceinfo/manager.c    |   82 ++++++++++++++++++++
 deviceinfo/manager.h    |   24 ++++++
 doc/device-api.txt      |    4 +
 src/device.c            |   34 ++++++++
 src/device.h            |    4 +
 9 files changed, 423 insertions(+), 2 deletions(-)
 create mode 100644 deviceinfo/deviceinfo.c
 create mode 100644 deviceinfo/deviceinfo.h
 create mode 100644 deviceinfo/main.c
 create mode 100644 deviceinfo/manager.c
 create mode 100644 deviceinfo/manager.h

-- 
1.7.4.1

