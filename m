Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 00/13] Rewrite local GATT server using shared/gatt
Date: Tue, 10 Feb 2015 20:54:13 -0800
Message-Id: <1423630466-26327-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set includes patches that rewrite the local GATT server using
shared/gatt. This in effect invalidates the existing src/attrib-server in
favor of a new src/gatt-server.

Arman Uguray (13):
  shared/att: Add bt_att_get|set_bdaddr functions
  shared/gatt: Add bdaddr_type param to gatt_db APIs
  core: Introduce btd_gatt_server.
  core: Attach gatt-server to bt_att
  core: gatt: Add GATT/GAP services to local db
  core: Add GATT UUIDs to Adapter1.UUIDs
  core: Support per-client CCC state
  core: Setup added/removed handlers in GATT server
  core: Add Service Changed characteristic
  core: device: Add getter for GATT server
  core: gatt-server: Send "Service Changed"
  core: adapter: Send UUIDs changed for GATT services
  shared/gatt: Don't incorrectly terminate discovery

 Makefile.am               |   1 +
 android/gatt.c            |  32 +-
 src/adapter.c             |  58 +++-
 src/device.c              |  53 +++-
 src/device.h              |   1 +
 src/gatt-client.c         |  20 +-
 src/gatt-server.c         | 764 ++++++++++++++++++++++++++++++++++++++++++++++
 src/gatt-server.h         |  29 ++
 src/main.c                |   3 +
 src/shared/att.c          |  28 ++
 src/shared/att.h          |   3 +
 src/shared/gatt-client.c  |   6 +-
 src/shared/gatt-db.c      |   6 +-
 src/shared/gatt-db.h      |   4 +
 src/shared/gatt-helpers.c |   3 +-
 src/shared/gatt-server.c  |  62 +++-
 tools/btgatt-server.c     |  22 +-
 unit/test-gatt.c          |   7 +-
 18 files changed, 1027 insertions(+), 75 deletions(-)
 create mode 100644 src/gatt-server.c
 create mode 100644 src/gatt-server.h

-- 
2.2.0.rc0.207.ga3a616c

