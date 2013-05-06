Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 00/13] Add experimental org.bluez.Service1
Date: Mon,  6 May 2013 10:43:17 +0200
Message-Id: <1367829810-8262-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Beyond the desktop use-cases, some users (e.g. GENIVI) are interested in having profile-specific information and control interfaces exposed in D-Bus. Such APIs did exist in BlueZ 4 but were dropped for BlueZ 5 in favor of simpler API simplicity. This service-specific interfaces had a fairly low priority for BlueZ 5 and therefore the discussion was postponed.

This patchset proposes org.bluez.Service1 as an attempt to cover these needs. As compared to the former Device.ConnectProfile()/DisconnectProfile(), the approach has the following advantages:
- Multiple instances of the same UUID can be exposed.
- The state of each service can be exposed, without hackish lists like Device.ConnectedProfiles.
- It's ObjectManager-centric.
- The design should scale better if new properties are required in the future (supported features, service handle, etc.)

Mikel Astiz (13):
  test: Remove obsolete test script
  test: Add UUID alias table to bluezutils.py
  test: Support human-friendly UUIDs in test-device
  test: Show human-friendly UUIDs in list-devices
  dbus: Add new org.bluez.Service1
  dbus: Add Device property to org.bluez.Service1
  dbus: Add UUID property to org.bluez.Service1
  dbus: Add state property to org.bluez.Service1
  dbus: Add Connect/Disconnect to org.bluez.Service1
  doc: Add API documentation for org.bluez.Service1
  dbus: Deprecate old profile-connecting API
  test: Add test-service script
  test: Add --uuid to test-service

 Makefile.am         |   2 +-
 Makefile.tools      |   2 +-
 doc/device-api.txt  |   4 +-
 doc/service-api.txt |  54 ++++++++++++++
 src/device.c        |  14 ++--
 src/service.c       | 197 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/service.h       |   2 +-
 test/bluezutils.py  |  84 ++++++++++++++++++++++
 test/list-devices   |   6 +-
 test/simple-service | 128 ----------------------------------
 test/test-device    |   4 +-
 test/test-service   | 174 ++++++++++++++++++++++++++++++++++++++++++++++
 12 files changed, 530 insertions(+), 141 deletions(-)
 create mode 100644 doc/service-api.txt
 delete mode 100755 test/simple-service
 create mode 100755 test/test-service

-- 
1.8.1.4

