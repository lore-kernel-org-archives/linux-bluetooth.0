Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 00/16] Implement GATT server D-Bus API
Date: Fri, 27 Feb 2015 00:16:23 -0800
Message-Id: <1425024999-29789-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

*v2: - Introduced g_dbus_client_new_full instead of adding a new argument to
       g_dbus_client_new.

     - Removed the crash fix patch. I'll fix this properly in a separate patch
       set by making discovery procedures cancelable.

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

Arman Uguray (16):
  gdbus/client: Don't GetManagedObjects w/o handlers
  gdbus/client: Allow specifying ObjectManager path
  doc/gatt-api.txt: New ObjectManager requirements
  core: gatt: Add GattManager1 stubs
  core: gatt: Implement GattManager1.RegisterService
  core: gatt: Register characteristics
  core: gatt: Support ReadValue for characteristics
  core: gatt: Support WriteValue for characteristics
  core: gatt: Make CCC addition API public
  core: gatt: Create CCC for external characteristic
  core: gatt: Add btd_gatt_database_notify function
  core: gatt: Send not/ind for D-Bus characteristics
  core: gatt: Create CEP for external characteristic
  core: gatt: Register descriptors
  core: gatt: Support descriptor reads/writes
  tools: Added a Python example for GATT server API

 Makefile.am         |    3 +-
 doc/gatt-api.txt    |   74 ++-
 gdbus/client.c      |   27 +-
 gdbus/gdbus.h       |    4 +
 src/adapter.c       |   18 +-
 src/gatt-database.c |  114 ++++-
 src/gatt-database.h |   16 +
 src/gatt-dbus.c     |  658 ------------------------
 src/gatt-dbus.h     |   25 -
 src/gatt-manager.c  | 1383 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/gatt-manager.h  |   23 +
 src/gatt.c          |  321 ------------
 src/gatt.h          |  121 -----
 src/main.c          |    5 -
 tools/gatt-example  |  463 +++++++++++++++++
 15 files changed, 2089 insertions(+), 1166 deletions(-)
 delete mode 100644 src/gatt-dbus.c
 delete mode 100644 src/gatt-dbus.h
 create mode 100644 src/gatt-manager.c
 create mode 100644 src/gatt-manager.h
 delete mode 100644 src/gatt.c
 delete mode 100644 src/gatt.h
 create mode 100755 tools/gatt-example

-- 
2.2.0.rc0.207.ga3a616c

