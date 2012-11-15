Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v1 00/16] Manager/Adapter transition to ObjectManager
Date: Thu, 15 Nov 2012 16:09:03 +0100
Message-Id: <1352992159-11559-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Note that this patchset requires the gdbus fix affecting were the ObjectManager gets registered, as submitted by Luiz.

This v1 proposal completes v0 with the following changes:
- Test scripts are now updated (not all were tested though)
- Manager D-Bus object is moved to /org/bluez
- FindAdapter is not removed any more. Instead, it is extended to support the "default" pattern (patch v1 03/16) for convenience.

>From original cover-letter:

While thinking about how profile and their states should be exposed in D-Bus (see previous RFC), I found several potential improvements in the current version of the Manager and Adapter APIs.

Basically, this patchset removes some properties and methods that seem duplicated.

There are other similar methods/properties that could be simplified as well, but for practical reasons I started with the most obvious ones.

Mikel Astiz (16):
  cups: Remove unnecessary code
  doc: Add missing documentation in FindAdapter
  manager: Extend FindAdapter with "default" pattern
  test: Avoid using DefaultAdapter()
  manager: Move org.bluez.Manager to org/bluez
  test: Update to new Manager path
  test: Update monitor script to ObjectManager
  manager: Expose default adapter using property
  test: Update test-manager script to ObjectManager
  manager: Remove AdapterAdded/AdapterRemoved signals
  manager: Remove redundant Adapters property
  test: Use ObjectManager instead of Adapters property
  adapter: Remove DeviceCreated/DeviceRemoved signals
  adapter: Remove redundant Devices property
  test: Use ObjectManager instead of Devices property
  adapter: Remove FindDevice method from D-Bus API

 doc/adapter-api.txt    |  19 ---------
 doc/manager-api.txt    |  35 ++++------------
 profiles/cups/main.c   |  38 +++++++----------
 src/adapter.c          |  85 -------------------------------------
 src/manager.c          | 111 +++++++++++++------------------------------------
 test/agent.c           |  57 +------------------------
 test/dbusdef.py        |   5 ++-
 test/gaptest.c         |   8 +++-
 test/list-devices      |  14 +++----
 test/monitor-bluetooth |  68 ++++++++++++++----------------
 test/mpris-player.c    |  55 +-----------------------
 test/simple-agent      |   4 +-
 test/simple-endpoint   |   4 +-
 test/simple-player     |   4 +-
 test/simple-service    |   4 +-
 test/test-adapter      |   5 ++-
 test/test-attrib       |   5 ++-
 test/test-audio        |   5 ++-
 test/test-device       |   5 ++-
 test/test-discovery    |   4 +-
 test/test-health       |   9 +++-
 test/test-health-sink  |  10 ++++-
 test/test-heartrate    |   4 +-
 test/test-input        |   5 ++-
 test/test-manager      |  37 +++++++++++------
 test/test-nap          |   4 +-
 test/test-network      |   4 +-
 test/test-oob          |   2 +-
 test/test-proximity    |   4 +-
 test/test-service      |   5 ++-
 test/test-thermometer  |   4 +-
 31 files changed, 178 insertions(+), 445 deletions(-)

-- 
1.7.11.7

