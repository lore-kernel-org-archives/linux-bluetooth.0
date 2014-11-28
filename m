Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 0/8] shared/gatt: Use gatt-db for client role.
Date: Fri, 28 Nov 2014 09:49:14 -0800
Message-Id: <1417196962-3876-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set integrates shared/gatt-db into shared/gatt-client:
  1. shared/gatt-client's internal service_list structure has been
     removed entirely in favor of gatt-db.
  2. The high level structures defined in gatt-client.h
     (bt_gatt_service_t, bt_gatt_characteristic_t, bt_gatt_descriptor_t)
     and the corresponding iterator structures and functions have been
     removed.
  3. Code using the iterators (unit/test-gatt, tools/btgatt*) now access
     the client cache via gatt-client's gatt-db.
  4. Small bug fixes in gatt-db.

Arman Uguray (8):
  shared/gatt-db: Fix bug in maximum handle check.
  shared/gatt-db: Add helper to get service handles.
  shared/gatt-client: Store services in gatt_db.
  shared/gatt-client: Use gatt_db in bt_gatt_register_notify
  tools/btgatt-server: Add the "services" command
  tools/btgatt-client: Use gatt-db instead of iterators
  unit/test-gatt: Use gatt-db for CLIENT tests
  shared/gatt-client: Remove GATT structs and iterators

 src/shared/gatt-client.c | 1189 +++++++++++++++++++++-------------------------
 src/shared/gatt-client.h |   73 +--
 src/shared/gatt-db.c     |   41 +-
 tools/btgatt-client.c    |  175 +++----
 tools/btgatt-server.c    |   90 ++++
 unit/test-gatt.c         |  241 +++++++---
 6 files changed, 911 insertions(+), 898 deletions(-)

-- 
2.2.0.rc0.207.ga3a616c

