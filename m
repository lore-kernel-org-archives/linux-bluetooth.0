Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v7 00/11] GATT API: External Services
Date: Wed, 19 Feb 2014 15:51:22 -0300
Message-Id: <1392835893-6723-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1B88D85B-35F3-47BB-ACAD-872E6C4F0A79@holtmann.org>
References: <1B88D85B-35F3-47BB-ACAD-872E6C4F0A79@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset implements the minimal support for adding local services
declarations.

Limitation: Remove services and multiple services exported by the same
remote will be implemented the next series. Created services are not
integrated in the attribute server. A new patchset will be sent later
allowing access the services through the LE, BR/EDR sockets.

Changes from PATCH v6 to v7:
* Rebase
* Remove testing interface (Unix socket)

Changes from PATCH v5 to v6:
* Rebase
* Fixed warning (gcc 4.6.3/32-bits): "ignoring return value of 'write'"

Changes from PATCH v4 to v5:
* Removed Release() method of GattService1 interface

Changes from PATCH v3 to v4:
* Rebase
* src/gatt.c: Replaced GIOChannel/GAttrib by "io".

Changes from PATCH v2 to v3:
* Rebase
* Interfaces renamed: s/GattServiceManager1/GattManager1,
  s/Characteristic1/GattCharacteristic1, s/Descriptor/GattDescriptor1
* test/gatt-service.c: s/fprintf/printf

Changes from PATCH v1 to v2:
* Rebase
* Included patch "doc: Add GATT API"
* Interfaces renamed: s/Service1/GattService1, and
  s/ServiceManager1/GattServiceManager1
* Removed patch "gatt: Implement UnregisterService" from this patchset

Changes from PATCH v0 to v1:
* Rebase

Changes from RFC v0 to PATCH v0:
* Changed copyright year : s/2013/2014
* Fixed coding style
* Added gatt-service binary to gitignore
* Added extra comment in the source code

Roughly upstreaming plan (steps):
 * GATT Server: External Services -> pathset GATT API: External Services
 * GATT Server: Export new database over BR/EDR and LE
 * GATT Server: External Characteristics (Server)
 * GATT Server: External Descriptors (Server)
 * Replacement for GAttrib: use "io"
 * Replace attribute server
 * Remove ATTIO and automatic connection mechanism from userspace
 * Fix all GATT internal plugins
 * GATT Client: Remote Services

Alvaro Silva (4):
  gatt: Add stub for gatt.{c, h} files
  gatt: Register Manager D-Bus Interface
  gatt: Add registering external service
  gatt: Add external services tracking

Andre Guedes (1):
  gatt: Add helper for creating GATT services

Claudio Takahasi (6):
  doc: Add experimental GATT API
  lib: Move GATT UUID to uuid.h
  test: Add external service GATT skeleton
  test: Add signal handling for gatt-service
  test: Add registering external service
  bluetooth.conf: Add ObjectManager interface

 .gitignore          |   1 +
 Makefile.am         |   2 +
 Makefile.tools      |   5 +
 attrib/gatt.h       |  25 -----
 doc/gatt-api.txt    | 142 +++++++++++++++++++++++++++
 lib/uuid.h          |  30 ++++++
 src/bluetooth.conf  |   1 +
 src/gatt-dbus.c     | 271 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/gatt-dbus.h     |  25 +++++
 src/gatt.c          | 106 ++++++++++++++++++++
 src/gatt.h          |  36 +++++++
 src/main.c          |  15 ++-
 test/gatt-service.c | 267 +++++++++++++++++++++++++++++++++++++++++++++++++++
 13 files changed, 896 insertions(+), 30 deletions(-)
 create mode 100644 doc/gatt-api.txt
 create mode 100644 src/gatt-dbus.c
 create mode 100644 src/gatt-dbus.h
 create mode 100644 src/gatt.c
 create mode 100644 src/gatt.h
 create mode 100644 test/gatt-service.c

-- 
1.8.3.1

