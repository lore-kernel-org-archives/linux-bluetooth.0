Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v2 0/8] Define TS-approved "small database"
Date: Tue,  9 Dec 2014 15:08:32 -0800
Message-Id: <1418166520-32993-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set's main goal is to add the small source database as defined
by page 24 of the GATT Test Spec.

It also adds improvements to bt_string_to_uuid to ease defined service UUID
strings, and some minor simplification of the existing test data.

Finally it allows the test database used by the IUT to be switched.

v1 -> v2:
  * Refactor UUID compaction patch
  * Add some tests for compaction
  * Add Service Discovery by UUID
  * Add /TP/GAD/SR/BV-02-C test

Michael Janssen (8):
  lib/uuid: Simplify BT base UUIDs when possible
  unit/gatt: Define repeated MTU PDUs.
  unit/gatt: Use source db for server_tests
  unit/gatt: Add test spec "small test database"
  unit/gatt: minor fix for test PDUs
  shared/gatt-db: Add gatt_db_find_by_type_value
  shared/gatt-server: support Discover by UUID
  unit/gatt: Add /TP/GAD/SR/BV-02-C test

 lib/uuid.c               |  17 ++-
 src/shared/gatt-db.c     |  27 +++++
 src/shared/gatt-db.h     |   7 ++
 src/shared/gatt-server.c | 107 +++++++++++++++++
 unit/test-gatt.c         | 295 +++++++++++++++++++++++++++++++++--------------
 unit/test-uuid.c         |  52 ++++++++-
 6 files changed, 410 insertions(+), 95 deletions(-)

-- 
2.2.0.rc0.207.ga3a616c

