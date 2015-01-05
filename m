Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v2 00/12] Add TS Large Databases, more server tests.
Date: Mon,  5 Jan 2015 13:32:42 -0800
Message-Id: <1420493574-37305-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds a "large database" as defined by the test spec, and a set of
new tests from the test spec.

To support some tests, find_by_type_value is now supported.

gatt_db_find_by_type shares some code with gatt_db_find_by_type_value, and
callbacks are preferred to queues, so those functions and users have been
reworked to use callbacks instead.

v1 -> v2:
 * Rebased to subsume already-commited patches
 * Switch find_by_type and find_by_type_value to callbacks

Michael Janssen (12):
  gatt_db: use callback for gatt_db_find_by_type
  shared/gatt-db: Add gatt_db_find_by_type_value
  shared/gatt-server: support Discover by UUID
  unit/gatt: Add Test Spec Large Database 1
  unit/gatt: Comment cleanup
  unit/gatt: Add /TP/GAD/SR/BV-02-C test
  unit/gatt: Add /TP/GAD/SR/BV-03-C test
  unit/gatt: Add /TP/GAD/SR/BV-04-C test
  unit/gatt: Add clarifying note about dup tests.
  unit/gatt: Add /TP/GAD/SR/BV-06-C test
  unit/gatt: Add /TP/GAR/SR/BV-01-C test
  unit/gatt: Add /TP/GAR/SR/BI-02-C test

 android/gatt.c           |  85 ++++----
 src/shared/gatt-client.c |  43 ++--
 src/shared/gatt-db.c     |  44 +++-
 src/shared/gatt-db.h     |  21 +-
 src/shared/gatt-server.c | 103 +++++++++
 unit/test-gatt.c         | 529 ++++++++++++++++++++++++++++++++++++++++++++++-
 6 files changed, 742 insertions(+), 83 deletions(-)

-- 
2.2.0.rc0.207.ga3a616c

