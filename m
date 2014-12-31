Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 00/14] Add TS Large Database, more server tests.
Date: Tue, 30 Dec 2014 16:32:18 -0800
Message-Id: <1419985952-18334-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset reworks the way that GATT test databases are defined,
defines a "large database" as defined by the test spec, adds a set
of new tests from the test spec.

It also includes some minor cleanup.

Michael Janssen (14):
  shared/gatt-db: Add gatt_db_find_by_type_value
  shared/gatt-server: support Discover by UUID
  unit/gatt: Bugfix small database construction
  unit/gatt: Add add_desc_with_value function
  unit/gatt: Rework service db definitions
  unit/gatt: Add Test Spec Large Database 1
  unit/gatt: Comment cleanup
  unit/gatt: Add /TP/GAD/SR/BV-02-C test
  unit/gatt: Add /TP/GAD/SR/BV-03-C test
  unit/gatt: Add /TP/GAD/SR/BV-04-C test
  unit/gatt: Add clarifying note about dup tests.
  unit/gatt: Add /TP/GAD/SR/BV-06-C test
  unit/gatt: Add /TP/GAR/SR/BV-01-C test
  unit/gatt: Add /TP/GAR/SR/BI-02-C test

 src/shared/gatt-db.c     |  27 ++
 src/shared/gatt-db.h     |   7 +
 src/shared/gatt-server.c | 107 +++++++
 unit/test-gatt.c         | 808 +++++++++++++++++++++++++++++++++++++++--------
 4 files changed, 812 insertions(+), 137 deletions(-)

-- 
2.2.0.rc0.207.ga3a616c

