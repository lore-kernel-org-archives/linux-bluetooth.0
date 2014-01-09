Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@gmail.com,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 00/18] GATT API: External Services
Date: Thu,  9 Jan 2014 13:38:05 -0300
Message-Id: <1389285503-19348-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1385585457-26951-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1385585457-26951-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset implements the minimal support for managing local
services declarations. Based on "[RFC BlueZ v2] doc: Add GATT API"

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
Run bluetoothd with EXPERIMENTAL flag
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
  gatt: Add stub for gatt.{c, h} files
  gatt: Register Manager D-Bus Interface
  gatt: Add registering external service
  gatt: Add external services tracking
  gatt: Implement UnregisterService
  gatt: Register ATT command/event handler
  gatt: Add Discover All Primary Services

Andre Guedes (1):
  gatt: Add helper for creating GATT services

Claudio Takahasi (10):
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
 lib/uuid.h           |  30 ++++
 src/bluetooth.conf   |   1 +
 src/gatt-dbus.c      | 296 +++++++++++++++++++++++++++++++++++++++
 src/gatt-dbus.h      |  25 ++++
 src/gatt.c           | 383 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/gatt.h           |  36 +++++
 src/main.c           |   4 +
 test/gatt-service.c  | 254 ++++++++++++++++++++++++++++++++++
 17 files changed, 1131 insertions(+), 48 deletions(-)
 create mode 100644 src/gatt-dbus.c
 create mode 100644 src/gatt-dbus.h
 create mode 100644 src/gatt.c
 create mode 100644 src/gatt.h
 create mode 100644 test/gatt-service.c

-- 
1.8.3.1

