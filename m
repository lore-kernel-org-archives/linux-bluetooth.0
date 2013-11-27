Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC BlueZ v0 00/17] GATT API: External Services
Date: Wed, 27 Nov 2013 17:50:40 -0300
Message-Id: <1385585457-26951-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset implements the minimal support for managing local
services declarations. Based on "[RFC BlueZ v2] doc: Add GATT API"

Features:
* API for internal and external services declaration
* Unix socket for testing purpose: services are exported
through unix sockets to avoid breaking the current attribute
server.

How to test:
Replace bluetooth.conf and reload DBus settings
$gatttool -L --primary (or interactive mode)

Upstreaming plan (steps):
* GATT Server: External Services
* GATT Server: External Characteristics (Server)
* GATT Server: External Descriptors (Server)
* Remove ATTIO and automatic connection mechanism from userspace
* Replace attribute server
* Fix all GATT internal plugins
* GATT Client: Remote Services
* ...

Alvaro Silva (7):
  gatt: Add stub for gatt file
  gatt: Register Manager D-Bus Interface
  gatt: Add registering external service
  gatt: Add external services tracking
  gatt: Implement UnregisterService
  gatt: Register ATT command/event handler
  gatt: Add Discover All Primary Services

Andre Guedes (1):
  gatt: Add helper for creating GATT services

Claudio Takahasi (9):
  lib: Add GATT Primary Service UUID
  gatt: Add server unix socket
  gattrib: Use default ATT LE MTU for non-standard sockets
  test: Add external service GATT skeleton
  test: Add signal handling for gatt-service
  test: Add registering external service
  gatttool: Add unix socket connect
  gatttool: Add unix socket support for interactive mode
  bluetooth.conf: Add ObjectManager interface

 Makefile.am          |   2 +
 Makefile.tools       |   5 +
 attrib/gattrib.c     |  16 +--
 attrib/gatttool.c    |  27 +++-
 attrib/gatttool.h    |   1 +
 attrib/interactive.c |  18 +--
 attrib/utils.c       |  54 ++++++++
 lib/uuid.c           |  14 ++
 lib/uuid.h           |   5 +
 src/bluetooth.conf   |   1 +
 src/gatt-dbus.c      | 296 ++++++++++++++++++++++++++++++++++++++++
 src/gatt-dbus.h      |  25 ++++
 src/gatt.c           | 371 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/gatt.h           |  36 +++++
 src/main.c           |   4 +
 test/gatt-service.c  | 254 +++++++++++++++++++++++++++++++++++
 16 files changed, 1106 insertions(+), 23 deletions(-)
 create mode 100644 src/gatt-dbus.c
 create mode 100644 src/gatt-dbus.h
 create mode 100644 src/gatt.c
 create mode 100644 src/gatt.h
 create mode 100644 test/gatt-service.c

-- 
1.8.3.1

