Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 0/3] foreach early termination
Date: Thu, 11 Dec 2014 11:53:34 -0800
Message-Id: <1418327617-26951-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set enables the early termination of iteration when using the
foreach functions provided by gatt_db and queue.  This makes it possible to
make some iterations more efficient.

Michael Janssen (3):
  shared/queue: enable early terminate foreach
  unit/test-queue: add test for early termination
  shared/gatt-db: enable foreach early termination

 android/bluetooth.c      |  4 ++-
 android/gatt.c           | 48 ++++++++++++++++++++----------
 android/handsfree.c      |  9 ++++--
 android/health.c         | 36 +++++++++++++----------
 android/tester-main.c    | 32 +++++++++++++++-----
 emulator/hciemu.c        |  3 +-
 monitor/keys.c           |  9 +++---
 src/shared/att.c         | 21 ++++++++-----
 src/shared/gatt-client.c | 22 +++++++-------
 src/shared/gatt-db.c     | 76 +++++++++++++++++++++++-------------------------
 src/shared/gatt-db.h     |  2 +-
 src/shared/hci.c         |  4 ++-
 src/shared/mgmt.c        | 13 +++++----
 src/shared/queue.c       |  3 +-
 src/shared/queue.h       |  2 +-
 src/shared/uhid.c        |  6 ++--
 tools/btgatt-client.c    | 32 +++++++++++++-------
 tools/btgatt-server.c    | 24 ++++++++++-----
 unit/test-gatt.c         | 32 ++++++++++----------
 unit/test-queue.c        | 33 +++++++++++++++++++--
 20 files changed, 260 insertions(+), 151 deletions(-)

-- 
2.2.0.rc0.207.ga3a616c

