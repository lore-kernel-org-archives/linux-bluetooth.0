Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 00/18] Implement GATT server D-Bus API
Date: Fri, 20 Feb 2015 17:56:45 -0800
Message-Id: <1424483824-27374-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set implements the GATT server D-Bus API and provides an
example application in Python to demonstrate how the API can be used
to export GATT services of various functionality.

Some of the basics of the code is very similar to what was already in
src/gatt-dbus.c, especially the bits that use gdbus/client to fetch
and interact with remote objects. However, src/gatt-dbus had a lot of
code that used the now-defunct src/gatt (which was going to be the new
GATT abstraction for bluetoothd before we built shared/gatt), so I
decided to remove gatt-dbus entirely and start from scratch with
src/gatt-manager.

Apart from these the code is fairly straight-forward. New additions to
src/gatt-database have been made to allow upper layers to store CCC
descriptors and send out notifications. The API automatically creates
CCC and CEP (Characteristic Extended Properties) descriptors based on
characteristic properties.

Arman Uguray (18):
  core: gatt: Add GattManager1 stubs
  gdbus: Don't refresh objects/props if disconnected
  shared/gatt: Cancel timeouts when attrib removed
  bluetooth.conf: Add DBus.Properties interface
  core: gatt: Fix malformed error name in client API
  core: gatt: Implement GattManager1.RegisterService
  core: gatt: Register characteristics
  core: gatt: Support ReadValue for characteristics
  core: gatt: Support WriteValue for characteristics
  core: gatt: Make CCC addition API public
  core: gatt: Create CCC for external characteristic
  core: gatt: Add btd_gatt_database_notify function
  core: gatt: Send not/ind for D-Bus characteristics
  core: gatt: Fix PropertiesChanged for "Flags"
  core: gatt: Create CEP for external characteristic
  core: gatt: Register descriptors
  core: gatt: Support descriptor reads/writes
  tools: Added a Python example for GATT server API

 Makefile.am          |    2 +-
 gdbus/client.c       |    8 +
 src/adapter.c        |   18 +-
 src/bluetooth.conf   |    3 +
 src/gatt-client.c    |    7 +-
 src/gatt-database.c  |  114 ++++-
 src/gatt-database.h  |   16 +
 src/gatt-dbus.c      |  658 ------------------------
 src/gatt-dbus.h      |   25 -
 src/gatt-manager.c   | 1373 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/gatt-manager.h   |   23 +
 src/gatt.c           |    5 -
 src/shared/gatt-db.c |   62 ++-
 tools/gatt-example   |  484 ++++++++++++++++++
 14 files changed, 2067 insertions(+), 731 deletions(-)
 delete mode 100644 src/gatt-dbus.c
 delete mode 100644 src/gatt-dbus.h
 create mode 100644 src/gatt-manager.c
 create mode 100644 src/gatt-manager.h
 create mode 100755 tools/gatt-example

-- 
2.2.0.rc0.207.ga3a616c

