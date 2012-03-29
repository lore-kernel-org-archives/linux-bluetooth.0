Return-Path: <cyrus@holtmann.org>
From: chen.ganir@ti.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH v4 0/4] Add DeviceInformationService plugin
Date: Thu, 29 Mar 2012 15:52:53 +0200
Message-Id: <1333029177-15204-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Add Device Information Service GATT Client for reading peer
device PNP_ID and store it.

This is v4 of the patch set, fixing issues raised in the mailing list

Chen Ganir (4):
  Add DeviceInformation GATT Client
  DeviceInfo: Add connection logic
  DeviceInfo: Discover Characteristics
  DeviceInfo: Read PNP ID

 Makefile.am             |    9 ++-
 deviceinfo/deviceinfo.c |  194 +++++++++++++++++++++++++++++++++++++++++++++++
 deviceinfo/deviceinfo.h |   24 ++++++
 deviceinfo/main.c       |   52 +++++++++++++
 deviceinfo/manager.c    |   82 ++++++++++++++++++++
 deviceinfo/manager.h    |   24 ++++++
 doc/device-api.txt      |    4 +
 src/device.c            |   33 ++++++++
 src/device.h            |    3 +
 9 files changed, 422 insertions(+), 3 deletions(-)
 create mode 100644 deviceinfo/deviceinfo.c
 create mode 100644 deviceinfo/deviceinfo.h
 create mode 100644 deviceinfo/main.c
 create mode 100644 deviceinfo/manager.c
 create mode 100644 deviceinfo/manager.h

-- 
1.7.4.1

