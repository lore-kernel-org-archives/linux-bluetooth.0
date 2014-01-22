Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v3 00/18] GATT API: External Services
Date: Wed, 22 Jan 2014 10:40:07 -0300
Message-Id: <1390398025-28340-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1390310814-19880-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1390310814-19880-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset implements the minimal support for adding local services
declarations.

Limitation: Remove services and multiple services exported by the same
remote will be implemented the next series.

Changes from PATCH v2 to PATCH v3:
* Rebase
* Interfaces renamed: s/GattServiceManager1/GattManager1,
  s/Characteristic1/GattCharacteristic1, s/Descriptor/GattDescriptor1
* test/gatt-service.c: s/fprintf/printf

Changes from PATCH v1 to PATCH v2:
* Rebase
* Included patch "doc: Add GATT API"
* Interfaces renamed: s/Service1/GattService1, and
  s/ServiceManager1/GattServiceManager1
  * Removed patch "gatt: Implement UnregisterService" from this patchset

  Changes from PATCH v0 to PATCH v1:
  * Rebase

  Changes from RFC v0 to PATCH v0:
  * Changed copyright year : s/2013/2014
  * Fixed coding style
  * Added gatt-service binary to gitignore
  * Added extra comment in the source code

  Features:
  * API for internal and external services declaration
  * Unix socket for testing purpose: services are exported
  through unix sockets to avoid breaking the current attribute
  server.

  How to test:
  Run bluetoothd with EXPERIMENTAL flag (-E)
  Replace /etc/dbus-1/system.d/bluetooth.conf and reload DBus settings
  $gatttool -L --primary (or interactive mode)

  Roughly upstreaming plan (steps):
  * GATT Server: External Services -> pathset GATT API: External Services
  * GATT Server: External Characteristics (Server)
  * GATT Server: External Descriptors (Server)
  * Replace attribute server

Alvaro Silva (6):
  gatt: Add stub for gatt.{c, h} files
  gatt: Register Manager D-Bus Interface
  gatt: Add registering external service
  gatt: Add external services tracking
  gatt: Register ATT command/event handler
  gatt: Add Discover All Primary Services

Andre Guedes (1):
  gatt: Add helper for creating GATT services

Claudio Takahasi (11):
  doc: Add GATT API
  lib: Move GATT UUID to uuid.h
  gatt: Add server unix socket
  gattrib: Use default ATT LE MTU for non-standard sockets
  test: Add external service GATT skeleton
  gitignore: Add test/gatt-service
  test: Add signal handling for gatt-service
  test: Add registering external service
  gatttool: Add unix socket connect
  gatttool: Add unix socket support for interactive mode
  bluetooth.conf: Add ObjectManager interface

 .gitignore           |   1 +
 Makefile.am          |   2 +
 Makefile.tools       |   5 +
 attrib/gatt.h        |  25 ----
 attrib/gattrib.c     |  16 +--
 attrib/gatttool.c    |  27 +++-
 attrib/gatttool.h    |   1 +
 attrib/interactive.c |  19 +--
 attrib/utils.c       |  54 ++++++++
 doc/gatt-api.txt     | 145 +++++++++++++++++++
 lib/uuid.h           |  30 ++++
 src/bluetooth.conf   |   1 +
 src/gatt-dbus.c      | 271 ++++++++++++++++++++++++++++++++++++
 src/gatt-dbus.h      |  25 ++++
 src/gatt.c           | 383 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/gatt.h           |  36 +++++
 src/main.c           |   4 +
 test/gatt-service.c  | 254 ++++++++++++++++++++++++++++++++++
 18 files changed, 1251 insertions(+), 48 deletions(-)
 create mode 100644 doc/gatt-api.txt
 create mode 100644 src/gatt-dbus.c
 create mode 100644 src/gatt-dbus.h
 create mode 100644 src/gatt.c
 create mode 100644 src/gatt.h
 create mode 100644 test/gatt-service.c

-- 
1.8.3.1

