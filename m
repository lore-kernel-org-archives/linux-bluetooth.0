Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 0/5] Define TS-approved "small database"
Date: Mon,  8 Dec 2014 16:05:24 -0800
Message-Id: <1418083529-4418-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set's main goal is to add the small source database as defined
by page 24 of the GATT Test Spec.

It also adds improvements to bt_string_to_uuid to ease defined service UUID
strings, and some minor simplification of the existing test data.

Finally it allows the test database used by the IUT to be switched.

Michael Janssen (5):
  lib/uuid: Simplify BT base UUIDs when possible
  unit/gatt: Define repeated MTU PDUs.
  unit/gatt: Use source db for server_tests
  unit/gatt: Add test spec "small test database"
  unit/gatt: minor fix for test PDUs

 lib/uuid.c       |   4 +
 unit/test-gatt.c | 278 +++++++++++++++++++++++++++++++++++++------------------
 unit/test-uuid.c |  22 ++++-
 3 files changed, 212 insertions(+), 92 deletions(-)

-- 
2.2.0.rc0.207.ga3a616c

