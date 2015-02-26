Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 00/17] Implement GATT server D-Bus API
Date: Wed, 25 Feb 2015 21:13:13 -0800
Message-Id: <1424927610-26226-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

*v1: - Removed src/gatt.* based on email discussion.

     - After some discussions on IRC, made ObjectManager mandatory on a
       per-service-subtree basis to reduce the number of unnecessary
       object processing and caching. One initial idea was to pass the
       service subtree directly to RegisterService but one of the
       concerns was that we should allow applications to use existing
       tooling for the standard ObjectManager interface.

     - Minor fixes based on comments, also fixed things so that
       descriptors with CCC and CEP UUIDs cannot be registered by
       external apps.

     - Included a fix for recent crashes seen in unit/test-gatt.

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

Arman Uguray (17):
  shared/gatt: Call bt_att_cancel_all in unref
  gdbus/client: Don't GetManagedObjects w/o handlers
  gdbus/client: Allow specifying ObjectManager path
  doc/gatt-api.txt: New ObjectManager requirements
  core/gatt: Add GattManager1 stubs
  core/gatt: Implement GattManager1.RegisterService
  core/gatt: Register characteristics
  core/gatt: Support ReadValue for characteristics
  core/gatt: Support WriteValue for characteristics
  core/gatt: Make CCC addition API public
  core/gatt: Create CCC for external characteristic
  core/gatt: Add btd_gatt_database_notify function
  core/gatt: Send not/ind for D-Bus characteristics
  core/gatt: Create CEP for external characteristic
  core/gatt: Register descriptors
  core/gatt: Support descriptor reads/writes
  tools: Added a Python example for GATT server API

 Makefile.am              |    3 +-
 client/main.c            |    2 +-
 doc/gatt-api.txt         |   74 ++-
 gdbus/client.c           |   26 +-
 gdbus/gdbus.h            |    5 +-
 plugins/hostname.c       |    2 +-
 profiles/iap/main.c      |    2 +-
 src/adapter.c            |   18 +-
 src/gatt-database.c      |  114 +++-
 src/gatt-database.h      |   16 +
 src/gatt-dbus.c          |  658 ----------------------
 src/gatt-dbus.h          |   25 -
 src/gatt-manager.c       | 1383 ++++++++++++++++++++++++++++++++++++++++++++++
 src/gatt-manager.h       |   23 +
 src/gatt.c               |  321 -----------
 src/gatt.h               |  121 ----
 src/main.c               |    5 -
 src/shared/gatt-client.c |    9 +
 tools/bluetooth-player.c |    2 +-
 tools/gap-tester.c       |    3 +-
 tools/gatt-example       |  463 ++++++++++++++++
 tools/gatt-service.c     |    2 +-
 tools/mpris-proxy.c      |    2 +-
 tools/obexctl.c          |    2 +-
 unit/test-gdbus-client.c |   39 +-
 25 files changed, 2130 insertions(+), 1190 deletions(-)
 delete mode 100644 src/gatt-dbus.c
 delete mode 100644 src/gatt-dbus.h
 create mode 100644 src/gatt-manager.c
 create mode 100644 src/gatt-manager.h
 delete mode 100644 src/gatt.c
 delete mode 100644 src/gatt.h
 create mode 100755 tools/gatt-example

-- 
2.2.0.rc0.207.ga3a616c

