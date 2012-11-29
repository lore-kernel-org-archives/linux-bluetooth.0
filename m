Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v2 00/15] Manager/Adapter transition to ObjectManager
Date: Thu, 29 Nov 2012 13:47:21 +0100
Message-Id: <1354193256-30610-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Note that this patchset requires the gdbus fix affecting were the ObjectManager gets registered, as submitted by Luiz.

This third proposal completely removes org.bluez.Manager, with two main consequences:
1. Clients have a harder time to find adapters. Therefore, some helper function have been added to be used by test scripts.
2. The concept of "default adapter" disappears.

All test scripts have been updated here but not all of them were tested, so apoligies if this breaks your script (some of them are already broken, by the way).

Regarding the testing code written in C, they haven't been updated. The idea is to address these once the python part has been agreed.

Cheers,
Mikel

Mikel Astiz (15):
  cups: Remove unnecessary code
  test: Add utility library for python scripts
  test: Avoid using DefaultAdapter()
  test: Update monitor script to ObjectManager
  test: Update test-manager script to ObjectManager
  test: Use ObjectManager instead of Adapters property
  dbus: Remove org.bluez.Manager
  test: Use ObjectManager instead of Devices property
  test: Add helper function to find devices
  adapter: Remove DeviceCreated/DeviceRemoved signals
  adapter: Remove redundant Devices property
  test: Avoid using Adapter.FindDevice()
  adapter: Remove FindDevice method from D-Bus API
  dbus: Rename to org.bluez.Device1
  dbus: Rename to org.bluez.Adapter1

 Makefile.am            |   3 +-
 Makefile.tools         |   3 +-
 doc/adapter-api.txt    |  23 +------
 doc/bluez-docs.xml     |   7 ---
 doc/device-api.txt     |   2 +-
 doc/manager-api.txt    |  51 ----------------
 doc/oob-api.txt        |   2 +-
 profiles/cups/main.c   |  46 +++++---------
 src/adapter.c          |  89 +--------------------------
 src/adapter.h          |   2 +-
 src/device.h           |   2 +-
 src/manager.c          | 163 -------------------------------------------------
 src/manager.h          |   3 -
 test/agent.c           |   7 ++-
 test/dbusdef.py        |   5 +-
 test/list-devices      |  20 +++---
 test/monitor-bluetooth |  68 ++++++++++-----------
 test/simple-agent      |  22 +++----
 test/simple-endpoint   |   7 +--
 test/simple-player     |   7 +--
 test/simple-service    |   7 +--
 test/test-adapter      |  41 ++++++-------
 test/test-attrib       |  18 ++----
 test/test-device       |  84 ++++++++++++-------------
 test/test-discovery    |  15 ++---
 test/test-health       |  11 +++-
 test/test-health-sink  |  12 +++-
 test/test-heartrate    |  23 +++----
 test/test-manager      |  33 +++++-----
 test/test-nap          |  10 +--
 test/test-oob          |  33 +++++-----
 test/test-proximity    |  17 +-----
 test/test-service      |   8 +--
 test/test-thermometer  |  20 +++---
 test/testutils.py      |  47 ++++++++++++++
 35 files changed, 279 insertions(+), 632 deletions(-)
 delete mode 100644 doc/manager-api.txt
 create mode 100644 test/testutils.py

-- 
1.7.11.7

