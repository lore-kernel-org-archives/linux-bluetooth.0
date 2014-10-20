Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 0/8] shared/gatt-server: Implement discovery operations.
Date: Mon, 20 Oct 2014 14:00:53 -0700
Message-Id: <1413838861-29956-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set implements the server side of GATT discovery procedures. With
this, characteristic, descriptor, and include declaration discovery can be
performed on a device running shared/gatt-server.

Also included are modifications to shared/gatt-db's external read/write handlers
and minor fixes to shared/att.

The TODO has also been updated to reflect the remaining core shared/gatt-server
features. I've already started with most of them but I'm including them there to
track the progress.

Arman Uguray (8):
  shared/att: bt_att_cancel should not cancel pending
    requests/indications.
  shared/gatt-db: Add complete callback to gatt_db_read.
  shared/gatt-db: Add complete callback to gatt_db_write.
  shared/att-types: Move GATT characteristic property defines to
    att-types.
  shared/att-types: Add attribute permission bitfield definitions.
  shared/gatt-server: Implement "Read By Type" request.
  shared/gatt-server: Implement "Find Information" request.
  TODO: Update shared/gatt-server items.

 TODO                     |  35 +++-
 android/gatt.c           |  42 +++--
 src/shared/att-types.h   |  26 +++
 src/shared/att.c         |  24 +--
 src/shared/gatt-client.h |   9 -
 src/shared/gatt-db.c     |  14 +-
 src/shared/gatt-db.h     |  17 +-
 src/shared/gatt-server.c | 431 ++++++++++++++++++++++++++++++++++++++++++++++-
 8 files changed, 554 insertions(+), 44 deletions(-)

-- 
2.1.0.rc2.206.gedb03e5

