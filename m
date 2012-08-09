Return-Path: <cyrus@holtmann.org>
From: Rafal Garbat <rafal.garbat@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <rafal.garbat@tieto.com>
Subject: [PATCH 00/13] Add Heart Rate Service
Date: Thu, 9 Aug 2012 09:20:03 +0200
Message-ID: <1344496816-4641-1-git-send-email-rafal.garbat@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add support for GATT Client Heart Rate Service.

This patchset adds Heart Rate client service, exposed on Heart Rate 
DBus API by Santiago Carot-Nemesio <sancane@gmail.com>. It allows 
registering and unregistering watchers, handling measurement notifications
and reseting Control Point. It bases on Thermometer service. Python 
test script is included. Tested against Polar H7 1013EE Heart Rate Sensor.

Rafal Garbat (12):
  heartrate: Add Heart Rate Service GATT client skeleton
  heartrate: Add conn logic and attio callbacks
  heartrate: Discover Characteristic Descriptors
  heartrate: Process Heart Rate Descriptors
  heartrate: Add DBus connection logic
  heartrate: Process Heart Rate Characteristics
  heartrate: Add notification support
  heartrate: Process measurements
  heartrate: Add support for Control Point Reset
  heartrate: Add GetProperties method handle
  heartrate: Add org.bluez.HeartRateWatcher iface to default policy
  heartrate: Add Heart Rate test script

Santiago Carot-Nemesio (1):
  Heart Rate Profile API

 Makefile.am                    |   10 +-
 Makefile.tools                 |    4 +-
 doc/heartrate-api.txt          |   74 ++++
 lib/uuid.h                     |    5 +
 profiles/heartrate/heartrate.c |  855 ++++++++++++++++++++++++++++++++++++++++
 profiles/heartrate/heartrate.h |   25 ++
 profiles/heartrate/main.c      |   68 ++++
 profiles/heartrate/manager.c   |   93 +++++
 profiles/heartrate/manager.h   |   24 ++
 src/bluetooth.conf             |    1 +
 test/test-heartrate            |   78 ++++
 11 files changed, 1233 insertions(+), 4 deletions(-)
 create mode 100644 doc/heartrate-api.txt
 create mode 100644 profiles/heartrate/heartrate.c
 create mode 100644 profiles/heartrate/heartrate.h
 create mode 100644 profiles/heartrate/main.c
 create mode 100644 profiles/heartrate/manager.c
 create mode 100644 profiles/heartrate/manager.h
 create mode 100755 test/test-heartrate

-- 
1.7.9.5

