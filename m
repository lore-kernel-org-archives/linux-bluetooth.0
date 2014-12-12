Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v2 0/3] foreach early termination
Date: Fri, 12 Dec 2014 10:44:21 -0800
Message-Id: <1418409864-26119-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set enables the early termination of iteration when using the
foreach functions provided by gatt_db and queue.  This makes it possible to
make some iterations more efficient.

v1 -> v2:
  * Rebase
  * Minor formatting fixes (thanks Arman)

Michael Janssen (3):
  shared/queue: enable early terminate foreach
  unit/test-queue: add test for early termination
  shared/gatt-db: enable foreach early termination

 android/bluetooth.c      |  4 ++-
 android/gatt.c           | 48 +++++++++++++++++++----------
 android/handsfree.c      |  9 ++++--
 android/health.c         | 36 +++++++++++++---------
 android/tester-main.c    | 32 ++++++++++++++-----
 emulator/hciemu.c        |  3 +-
 monitor/keys.c           | 10 +++---
 src/shared/att.c         | 22 ++++++++-----
 src/shared/gatt-client.c | 25 +++++++++------
 src/shared/gatt-db.c     | 80 +++++++++++++++++++++++++-----------------------
 src/shared/gatt-db.h     |  2 +-
 src/shared/hci.c         |  4 ++-
 src/shared/mgmt.c        |  8 +++--
 src/shared/queue.c       |  3 +-
 src/shared/queue.h       |  2 +-
 src/shared/uhid.c        |  6 ++--
 tools/btgatt-client.c    | 32 +++++++++++++------
 tools/btgatt-server.c    | 24 ++++++++++-----
 unit/test-gatt.c         | 35 ++++++++++++---------
 unit/test-queue.c        | 44 +++++++++++++++++++++++---
 20 files changed, 278 insertions(+), 151 deletions(-)

-- 
2.2.0.rc0.207.ga3a616c

